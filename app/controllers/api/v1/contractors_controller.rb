class Api::V1::ContractorsController < Api::V1::ApiController
  def show
    @contractor = Contractor.find(params[:id])
    
    render status: :not_found, json: { :message => "Contractor not found" } unless not @contractor.nil?
  end
end