require 'date'
require 'time'
require 'open-uri'

  class HomeBinderReport < Prawn::Document
    def to_pdf(binder,user)
      
      @toc = Array.new
      
      # title page
      image "#{Rails.root}/app/assets/images/pdf/title-page-small.png", 
        :at  => [-36, 756]
            
      formatted_text_box [
        { :text => "HomeBinder Report for\n", :size => 20, :styles => [:bold] },
        { :text => "#{binder.name}\n", :styles => [:bold], :color => "fc6500", :size => 26 },
        { :text => "#{binder.property.address1}\n", :styles => [:bold], :size => 18 },
        { :text => "#{binder.property.city}, #{binder.property.state} #{binder.property.zip}", :styles => [:bold], :size => 18 }
      ], :at => [62, 210], :width => 400, :height => 200
      
      
      #toc page
      start_new_page()
      
      image "#{Rails.root}/app/assets/images/pdf/toc-page-small.png", 
        :at  => [-36, 756]
      
      # property
      #start_new_page()
      
      #@toc[page_count] = "Property"
       
      #image "#{Rails.root}/app/assets/images/pdf/property-header-small.png", 
      #  :at  => [-36, 756]      
       
      #move_down(200) 
       
      #data = [ 
      #  [ "NAME", "ADDRESS", "ACREAGE", "APN NUMBER" ],
      #  [ binder.name, "#{binder.property.address1}\n#{binder.property.city}, #{binder.property.state} #{binder.property.zip}", binder.property.acres, binder.property.apn]
      #]
      
      #table(data, :header => true, :width => bounds.width, :cell_style => { :inline_format => true }) do
      #  cells.padding = 12
      #  cells.borders = []
         
      #  row(0).borders      = [:bottom]
      #  row(0).border_width = 2
      #  row(0).font_style   = :bold
      #  row(0).size         = 8
      #end
      
      #image open(ERB::Util.url_encode("http://maps.googleapis.com/maps/api/staticmap?center=#{binder.property.address1} #{binder.property.city}, #{binder.property.state}&zoom=15&size=900x300&key=AIzaSyBkAHC5xhv7J2CSDJWOgAEAbhEaATTsb1Y&sensor=false&markers=color:red|*|#{binder.property.address1} #{binder.property.city}, #{binder.property.state}")), :position => "center"
      
      
      #structures
      start_new_page
      
      @toc[page_count] = "Structures"
       
      image "#{Rails.root}/app/assets/images/pdf/structure-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 

      if(binder.structures.length > 0)
        structuredata = [[ I18n.t(:struct).upcase, I18n.t(:struct_year).upcase.sub!(":",""), I18n.t(:struct_construction_style).upcase.sub!(":",""), I18n.t(:struct_beds).upcase.sub!(":",""), I18n.t(:struct_baths).upcase.sub!(":","") ]]
        binder.structures.each do |structure|
          sname = structure.name unless structure.name.nil?
          syear = structure.year_built unless structure.year_built.nil?
          scons = structure.construction_style unless structure.construction_style.nil?
          sbeds = structure.beds unless structure.beds.nil?
          sbath = structure.baths unless structure.baths.nil?
          
          structuredata += [[ sname, syear, scons, sbeds, sbath ]]
        end 
        
        #table(structuredata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width, :cell_style => { :inline_format => true }) 
        table(structuredata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end
      else
        fill_color "000000"
        text "You currently have no #{I18n.t(:struct).pluralize}, you should add some!", :size => 12, :align => :center
      end
      
      
      #areas
      start_new_page
      
      @toc[page_count] = "Areas & Rooms"
       
      image "#{Rails.root}/app/assets/images/pdf/rooms-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 
      
      if(binder.areas.length > 0)
        #@areas   = binder.areas.sort_by {|i| i.structure_id}
        @areas   = binder.areas.sort_by {|i| i.structure_id || 0} 
        areadata = [[ I18n.t(:area).upcase, I18n.t(:area_type).upcase.sub!(":","") ]]
        curarea  = ''
        @areas.each do |area|
          
          struct = Structure.find(area.structure_id).name.upcase unless area.structure_id.nil?
          
          if(struct)
            if struct != curarea
              areadata += [[{:content => "<b>#{struct}</b>", :colspan => 2}]]
            end
          end
          
          # this kinda sucks, i wonder if there's a better way?
          aname = area.name unless area.name.nil?
          atype = area.area_type unless area.area_type.nil?
          
          areadata += [[ aname, atype ]]
          
          curarea = struct
        end 
        
        table(areadata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width, :cell_style => { :inline_format => true }) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end 
      else
        fill_color "000000"
        text "You currently have no #{I18n.t(:area).pluralize}, you should add some!", :size => 12, :align => :center
      end

      # maintenance items
      start_new_page
      
      @toc[page_count] = "Maintenance"
       
      image "#{Rails.root}/app/assets/images/pdf/maintenance-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 
      
      if(binder.maintenance_items.length > 0)
        @maint_items = binder.maintenance_items.sort_by {|i| i.next_event.do_date}
        maintdata = [[ I18n.t(:maintenance_item).pluralize.upcase, I18n.t(:maintenance_next).upcase ]]
        @maint_items.each do |item|
          iname = item.name unless item.name.nil?
          inext = item.next_event.do_date unless item.next_event.do_date.nil?
          
          maintdata += [[ iname, inext ]]
        end 
        
        table(maintdata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end 
      else
        fill_color "000000"
        text "You currently have no #{I18n.t(:maintenance_item).pluralize}, you should add some!", :size => 12, :align => :center
      end


      # projects
      start_new_page
      
      @toc[page_count] = "Projects"
       
      image "#{Rails.root}/app/assets/images/pdf/projects-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 
      
      if(binder.projects.length > 0)
        projectdata = [[ "PROJECT NAME", I18n.t(:project_ended).upcase.sub!(":",""), I18n.t(:project_status).upcase.sub!(":","") ]]
        binder.projects.each do |project|
          pname = project.name unless project.name.nil?
          pendd = project.end_date.strftime("%m/%d/%Y") unless project.end_date.nil?
          pstat = project.get_status.titleize unless project.get_status.nil?
          
          projectdata += [[ pname, pendd, pstat ]]
        end 
        
        table(projectdata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end  
      else
        fill_color "000000"
        text "You currently have no Projects, you should add some!", :size => 12, :align => :center
      end


      # contractors
      start_new_page
      
      @toc[page_count] = "Contractors"
       
      image "#{Rails.root}/app/assets/images/pdf/contractor-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 

      if(binder.contractors.length > 0)      
        contrdata = [[ I18n.t(:contractor).upcase, I18n.t(:contractor_type).upcase.sub!(":",""), I18n.t(:contractor_address).upcase.sub!(":",""), I18n.t(:contractor_phone).upcase.sub!(":",""), I18n.t(:contractor_email).upcase.sub!(":","") ]]
        binder.contractors.each do |contractor|
          
          if not contractor.address.nil?
            caddr = ''
            if not contractor.address.address1.nil?
              caddr += "#{contractor.address.address1}\n"
            end 
            if not contractor.address.address2.nil?
              caddr += "#{contractor.address.address2}\n"
            end
            if not contractor.address.city.nil?
              caddr += "#{contractor.address.city}, "
            end 
            if not contractor.address.state.nil?
              caddr += "#{contractor.address.state}, "
            end
            if not contractor.address.zip.nil?
              caddr += contractor.address.zip
            end
          end
          
          cname = contractor.name.titleize unless contractor.name.nil?
          ctype = contractor.contractor_type unless contractor.contractor_type.nil?
          cphne = contractor.phone.phony_formatted(:format => :national, :spaces => '-') unless contractor.phone.nil?
          cmail = contractor.email unless contractor.email.nil?
          
          contrdata += [[ cname, ctype, caddr, cphne, cmail ]]
        end 
        
        table(contrdata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end  
      else
        fill_color "000000"
        text "You currently have no #{I18n.t(:contractor).pluralize}, you should add some!", :size => 12, :align => :center
      end


      # appliances
      start_new_page
      
      @toc[page_count] = "Appliances"
       
      image "#{Rails.root}/app/assets/images/pdf/appliances-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 

      if(binder.appliances.length > 0)      
        appliancedata = [[ I18n.t(:appliance).upcase, I18n.t(:appliance_manufacturer).upcase.sub!(":",""), I18n.t(:appliance_model).upcase.sub!(":",""), I18n.t(:purchase_date).upcase.sub!(":",""), I18n.t(:appliance_warranty).upcase.sub!(":","") ]]
        binder.appliances.each do |appliance|
          apname = appliance.name unless appliance.name.nil?
          apmanu = appliance.manufacturer unless appliance.manufacturer.nil?
          apmodl = appliance.model unless appliance.model.nil?
          apdate = appliance.purchase.date.strftime("%m/%d/%Y") unless appliance.purchase.date.nil?
          apwarr = appliance.warranty unless appliance.warranty.nil?
          
          appliancedata += [[ apname, apmanu, apmodl, apdate, apwarr ]]
        end 
        
        table(appliancedata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end  
      else
        fill_color "000000"
        text "You currently have no #{I18n.t(:appliance).pluralize}, you should add some!", :size => 12, :align => :center
      end


      # finishes
      start_new_page
      
      @toc[page_count] = "Finishes"
       
      image "#{Rails.root}/app/assets/images/pdf/finishes-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 

      if(binder.finishes.length > 0)            
        findata = [[ I18n.t(:finish_make).upcase.sub!(":",""), I18n.t(:finish_model).upcase.sub!(":",""), I18n.t(:finish_style_color).upcase.sub!(":",""), I18n.t(:purchase_store).upcase.sub!(":",""), I18n.t(:purchase_date).upcase.sub!(":","") ]]
        binder.finishes.each do |finish|
          fmake = finish.make unless finish.make.nil?
          fmodl = finish.model unless finish.model.nil?
          fstyl = finish.style_color unless finish.style_color.nil?
          fpurc = finish.purchase.store unless finish.purchase.store.nil?
          fdate = finish.purchase.date.strftime("%m/%d/%Y") unless finish.purchase.date.nil?
          
          findata += [[ fmake, fmodl, fstyl, fpurc, fdate ]]
        end 
        
        table(findata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end  
      else
        fill_color "000000"
        text "You currently have no #{I18n.t(:finish).pluralize}, you should add some!", :size => 12, :align => :center
      end


      # paint
      start_new_page
      
      @toc[page_count] = "Paint"
       
      image "#{Rails.root}/app/assets/images/pdf/paint-header-small.png", 
        :at  => [-36, 756]      
       
      move_down(200) 

      if(binder.paints.length > 0)                  
        paintdata = [[ I18n.t(:paint).upcase, I18n.t(:paint_manufacturer).upcase.sub!(":",""), I18n.t(:paint_areas).upcase.sub!(":",""), I18n.t(:paint_type).upcase.sub!(":",""), I18n.t(:paint_code).upcase.sub!(":",""), I18n.t(:paint_makeup).upcase.sub!(":","") ]]
        parea     = ''
        binder.paints.each do |paint|
          
          #if(paint.areas.length > 0)
          #  paint.areas.each_with_index do |area, index|
          #    if index < paint.areas.length - 1
          #      parea += "#{area.name},"
          #    else
          #      parea += area.name
          #    end
          #  end
          #else
          #  parea = ''
          #end
          
          pname = paint.name unless paint.name.nil?
          pmanu = paint.manufacturer unless paint.manufacturer.nil?
          ptype = paint.paint_type unless paint.paint_type.nil?
          pcode = paint.code unless paint.code.nil?
          pmake = paint.makeup unless paint.makeup.nil?
          
          paintdata += [[ pname, pmanu, parea, ptype, pcode, pmake ]]
        end 
        
        table(paintdata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
          cells.padding = 12
          cells.borders = []
           
          row(0).borders      = [:bottom]
          row(0).border_width = 2
          row(0).font_style   = :bold
          row(0).size         = 8
        end  
      else
        fill_color "000000"
        text "You currently have no #{I18n.t(:paint).pluralize}, you should add some!", :size => 12, :align => :center
      end


      # inventory
      #start_new_page
      
      #@toc[page_count] = "Inventory"
       
      #image "#{Rails.root}/app/assets/images/pdf/maintenance-header-small.png", 
      #  :at  => [-36, 756]      
       
      #move_down(200) 
            
      #invdata = [[ I18n.t(:inventory_item).upcase, I18n.t(:inventory_type).upcase, I18n.t(:inventory_value).upcase ]]
      #binder.inventory_items.each do |inventory_item|
      #  invdata += [[ inventory_item.inventory_type, number_to_currency(inventory_item.value) ]]
      #end 
      
      #table(invdata, :header => true, :row_colors => ["F0F0F0", "FFFFFF"], :width => bounds.width) do
      #  cells.padding = 12
      #  cells.borders = []
      #   
      #  row(0).borders      = [:bottom]
      #  row(0).border_width = 2
      #  row(0).font_style   = :bold
      #  row(0).size         = 8
      #end  

      
      repeat(:all, :dynamic => true) do
        
        image "#{Rails.root}/app/assets/images/pdf/logo-small.png", 
          :at  => [0, 36]

        formatted_text_box [
          { :text => "Website: www.homebinder.com\n", :size => 10, :styles => [:bold], :color => "AAAAAA" },
          { :text => "Call support: 800. 232. 0101", :size => 10, :styles => [:bold], :color => "AAAAAA" }
        ], :at => [50, 18], :width => 400, :height => 200
          
        if(page_number != 1)
          formatted_text_box [
            { :text => "#{page_number}", :size => 20, :styles => [:bold] }
          ], :at => [bounds.right-25, 10], :width => 400, :height => 200
        end
        
      end
      
      go_to_page(2)
      
      height = 600
      
      @toc.each_with_index do |key, value|
        if(key)
          fill_color "FF6500"
          text_box "#{value}", :size => 24, :at => [62, height], :width => 200, :color => "FF6500"
          
          fill_color "FFFFFF"
          text_box "#{key}", :size => 24, :at => [95, height], :width => 200, :color => "FFFFFF"
        end
      
        height -= 30
      end 
      
      render
    end
  end