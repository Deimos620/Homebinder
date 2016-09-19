class SellerReportItem < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :seller_reportable, :polymorphic => true
end