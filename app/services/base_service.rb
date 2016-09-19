class BaseService
  
  def initialize(current_user)
    @current_user = current_user
    @ability = Ability.new(@current_user)
  end
  
end