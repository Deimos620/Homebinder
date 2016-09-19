class Api::V1::SellerReportsController < Api::V1::ApiController
  
  skip_before_filter :verify_api_key,   :only => [:show]
  skip_before_filter :verify_jwt_token, :only => [:show]
  
  def create
    # create the new report object
    @seller_report = SellerReport.new(params[:seller_report])
    
    # check if the user has permission to create in the binder
    @binder = Binder.find(@seller_report.binder_id)
    @ability.authorize! :create, @binder
    
    # save the seller report
    if not @seller_report.save
      render status: :unprocessable_entity, json: @seller_report.errors
    end
  end
  
  def show
    # find the report by code
    @seller_report = SellerReport.find_by_code(params[:id])
    
    # check some stuff
    render :status => :not_found unless not @seller_report.nil?
    
    if params[:edit].nil?
      render :status => :forbidden unless @seller_report.public
    end
  end
  
  def update
    @seller_report = SellerReport.find(params[:id])
    
    render :status => :not_found unless not @seller_report.nil?
    
    # check if the user has permission to write in the binder
    @binder = Binder.find(@seller_report.binder_id)
    @ability.authorize! :write, @binder
    
    # set the public flag
    @seller_report.public = params[:public]
    @seller_report.save
    
    @binder.documents.each do |d|
      include = params[:documents] ? params[:documents].include?(d.id) : false
      if not d.seller_report_item
        d.seller_report_item = SellerReportItem.new(include: include)
      else
        d.seller_report_item.include = include
      end
      d.save
    end
    
    @binder.images.each do |i|
      include = params[:images] ? params[:images].include?(i.id) : false
      if not i.seller_report_item
        i.seller_report_item = SellerReportItem.new(include: include)  
      else
        i.seller_report_item.include = include
      end
      i.save
    end
  end
  
end