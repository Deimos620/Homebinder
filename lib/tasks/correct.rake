namespace :correct do
  desc "This task is used to migrate the typeahead fields from ids to strings"
  task :migrate_typeahead => :environment do
    puts "Doing typehaed migration..."
    
    # appliances
    Appliance.all.each do |a|
      a.appliance_type = ApplianceType.find(a.appliance_type_id).name unless a.appliance_type_id.nil?
      a.manufacturer = ApplianceManufacturer.find(a.appliance_manufacturer_id).name unless a.appliance_manufacturer_id.nil?
      a.model = ApplianceModel.find(a.appliance_model_id).name unless a.appliance_model_id.nil?
      if not a.save
        puts a.errors
      end
    end
    
    # areas
    Area.all.each do |a|
      a.area_type = AreaType.find(a.area_type_id).name unless a.area_type_id.nil?
      if not a.save
        puts a.erors
      end
    end
    
    #contractors
    Contractor.all.each do |c|
      c.contractor_type = ContractorType.find(c.contractor_type_id).name unless c.contractor_type_id.nil?
      if not c.save
        puts c.errors
      end
    end
    
    # finishes
    Finish.all.each do |f|
      f.make = FinishMake.find(f.finish_make_id).name unless f.finish_make_id.nil?
      f.model = FinishModel.find(f.finish_model_id).name unless f.finish_model_id.nil?
      if not f.save
        puts f.errors
      end
    end
    
    # inventory items
    InventoryItem.all.each do |i|
      i.inventory_item_type = InventoryItemType.find(i.inventory_item_type_id).name unless i.inventory_item_type_id.nil?
      if not i.save
        puts i.errors
      end
    end
    
    # maintenance items
    MaintenanceItem.all.each do |m|
      m.maintenance_cycle = MaintenanceCycle.find(m.maintenance_cycle_id).name unless m.maintenance_cycle_id.nil?
      m.maintenance_type = MaintenanceType.find(m.maintenance_type_id).name unless m.maintenance_type_id.nil?
      if not m.save
        puts m.errors
      end
    end
    
    # paints
    Paint.all.each do |p|
      p.paint_type = PaintType.find(p.paint_type_id).name unless p.paint_type_id.nil?
      p.manufacturer = PaintManufacturer.find(p.paint_manufacturer_id).name unless p.paint_manufacturer_id.nil?
      if not p.save
        puts p.errors
      end
    end
    
    #projects 
    Project.all.each do |p|
      p.project_type = ProjectType.find(p.project_type_id).name unless p.project_type_id.nil?
      p.status = ProjectStatus.find(p.project_status_id).name unless p.project_status_id.nil?
      if not p.save
        puts p.errors
      end
    end
    
    # structures
    Structure.all.each do |s|
      s.building_type = BuildingType.find(s.building_type_id).name unless s.building_type_id.nil?
      s.construction_style = ConstructionStyle.find(s.construction_style_id).name unless s.construction_style_id.nil?
      s.construction_type = ConstructionType.find(s.construction_type_id).name unless s.construction_type_id.nil?
      s.heat_type = HeatType.find(s.heat_type_id).name unless s.heat_type_id.nil?
      s.heat_source = HeatSource.find(s.heat_source_id).name unless s.heat_source_id.nil?
      if not s.save
        puts s.errors
      end
    end
    
    puts "done."
  end
  
  desc "Tag existing documents and images"
  task :tag_docs_and_images => :environment do
    puts "Tagging existing documents and images..."
    Document.all.each do |doc|
      keyParts = doc.key.split('/')
      # only doing this for documents with the old style key
      # /userId/binderId/controller/resourceId/doc/filename
      if keyParts.length == 6
        controller = keyParts[2]
        resourceId = keyParts[3]
        tagName = controller.classify.to_s.downcase << '_' << resourceId
        if doc.tags.where(:tag => tagName).length == 0
          doc.tags.new(tag: tagName)
          doc.save
        end
      end
    end
    Image.all.each do |img|
      keyParts = img.key.split('/')
      # only doing this for images with the old style key
      # /userId/binderId/controller/resourceId/image/filename
      if keyParts.length == 6
        controller = keyParts[2]
        resourceId = keyParts[3]
        tagName = controller.classify.to_s.downcase << '_' << resourceId
        if img.tags.where(:tag => tagName).length == 0
          img.tags.new(tag: tagName)
          img.save
        end
      end
    end
    
    puts "done."
  end
  
  desc "Move account number and details from contractor to binder contractor"
  task :contractor_info => :environment do
    BinderContractor.all.each do |bc|
      if not bc.contractor.account_number.nil?
        bc.account_number = bc.contractor.account_number
        bc.contractor.account_number = nil
      end
      if not bc.contractor.contact.nil?
        bc.contact = bc.contractor.contact
        bc.contractor.contact = nil
      end
      if not bc.contractor.details.nil?
        bc.details = bc.contractor.details
        bc.contractor.details = nil
      end
      if not bc.save
        puts "Failed to update #{bc.id}"
        bc.errors.each do |err|
          puts err
        end
      end
    end
  end
end