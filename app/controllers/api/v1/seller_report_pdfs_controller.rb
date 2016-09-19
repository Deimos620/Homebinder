class Api::V1::SellerReportPdfsController < Api::V1::ApiController
  
  skip_before_filter :verify_api_key
  skip_before_filter :verify_jwt_token
  
  def show    
    # find the report by code
    @seller_report = SellerReport.find_by_code(params[:id])
    
    # check some stuff
    render :status => :not_found unless not @seller_report.nil?
    render :status => :forbidden unless @seller_report.public
    
    #output    = SellerReportPdf.new.to_pdf(@seller_report)
    pdf       = SellerReportPdfService.create(@seller_report)
    date      = Date.today
    pdfname   = "HomeBinder_Sellers_Report_#{@seller_report.binder.name}_#{date}.pdf"

    send_data pdf.render, filename: pdfname, type: "application/pdf", page_size: "A4"  
  end
end