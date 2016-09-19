class SellerReport < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :binder
  
  before_create {|report| report.code = SecureRandom.hex(3).upcase}
  
  def appliances
    binder.appliances
  end
  
  def projects
    binder.projects.where(status: 'Completed')
  end
  
  def maintenance_items
    binder.maintenance_items
  end
  
  def contractors
    binder.binder_contractors
  end
  
  def paints
    binder.paints
  end
  
  def finishes
    binder.finishes
  end
  
  def documents
    @docs = Array.new
    binder.documents.each do |d|
      if d.seller_report_item && d.seller_report_item.include
        @docs << d
      end
    end
    return @docs
  end
  
  def images
    @imgs = Array.new
    binder.images.each do |i|
      if i.seller_report_item && i.seller_report_item.include
        @imgs << i
      end
    end
    return @imgs
  end
  
  def binder
    @binder ||= Binder.find(self.binder_id)
  end
  
end
