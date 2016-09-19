require "s3"

class Logo < ActiveRecord::Base
  
  belongs_to :partner
  
  has_many :tags, :as => :taggable, :dependent => :destroy
 
  before_destroy :clean_s3
  
  private
  
  def clean_s3
    # connect to s3
    service = S3::Service.new(:access_key_id => AppConfig.aws['access_key_id'],
                              :secret_access_key => AppConfig.aws['secret_access_key'])
    # find our bucket
    bucket = service.buckets.find(AppConfig.aws['s3_bucket'])
    #find our object
    object = bucket.objects.find("#{self.key}")
    # destroy!
    object.destroy
  end

end