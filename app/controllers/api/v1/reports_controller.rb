class Api::V1::ReportsController < Api::V1::ApiController
  
  # GET /report  
  def index
     # check if the user can read the binder
    @binder = Binder.find(params[:binder_id])
    
    # verify the subscription
    verify_subscription
    
    output    = HomeBinderReport.new.to_pdf(@binder, @current_user)
    #output    = SellerReport.new.to_pdf(@binder, @current_user)
    
    date      = Date.today
    time      = Time.now
    pdfname   = "HomeBinder_Report_#{@binder.name}_#{time}.pdf"

    send_data output, filename: pdfname, type: "application/pdf", page_size: "A4"  
  end
    
end