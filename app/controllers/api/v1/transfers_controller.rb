class Api::V1::TransfersController < Api::V1::ApiController
  
  def index
    permission_denied unless @current_user.has_role?(:admin)
    @transfers = Transfer.all
  end
  
  def create
    begin
      @transfer = Transfer.new(params[:transfer])
      service = TransferService.new(@current_user, @transfer)
      service.transfer_binder
    rescue NotFoundException => e
      render :status => :bad_request, :json => e.message
      return
    rescue BadRequestException => e
      render :status => :bad_request, :json => e.message
      return
    end
    
    head :no_content
  end
  
end