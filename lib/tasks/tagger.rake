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