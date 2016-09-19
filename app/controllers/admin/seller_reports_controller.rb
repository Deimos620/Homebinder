class Admin::SellerReportsController < Admin::AdminController
  
  def index
    @seller_reports = SellerReport.all
  end
  
end