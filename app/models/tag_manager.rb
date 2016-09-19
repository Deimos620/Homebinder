class TagManager
  
  def find_tagged_data(tag, sources)
    data = Hash.new
    
    search = souces.nil? ? ['Appliance', 'Area', 'BinderContractor', 'Document', 'Image', 'InventoryItem', 'MaintenanceItem', 'Paint', 'Project', 'Structure'] : sources
    
    search.each do |type|
      results = type.joins(:tags).where(tags: {tag: params[:tag]})
      data[type] = results
    end
    
  end
  
  def self.find_tagged_resources(tags)
    results = Hash.new
    tags.each do |tag|
      # parse the parts of the tag
      parts = tag.tag.split('_')
      classname = parts[0]
      id = parts[1]
      symbol = classname.underscore.pluralize.to_sym

      # get the resource
      resource = classname.camelize.constantize.find(id)
      
      # put it into the hash
      if not results.has_key?(symbol)
        results[symbol] = Array.new
      end
      results[symbol] << resource
    end
    return results
  end
  
  def self.get_delete_list(resource, tag_list)
    delete_list = Array.new

    # check the current tags if they are still in the list being
    # saved. If they are not we want to delete the tag
    resource.tags.each do |current_tag|
      found = false
      if not tag_list.nil?
        tag_list.each do |param_tag|
          if current_tag.tag == param_tag[:tag]
            found = true
            break
          end
        end
      end
      # if the tag isn't in the params delete it
      if not found
        delete_list.push(current_tag)
      end
    end
  
    return delete_list
  end
  
  def self.delete_tag_references(tagName)
    Tag.where(:tag => tagName).each do |tag|
      tag.destroy
    end
  end
  
end