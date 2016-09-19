require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  
  test "minimum required values" do
    data = Hash.new
    data["address1"] = "742 Evergreen Ter"
    data["city"] = "Springfield"
    data["state"] = "KY"
    @property = Property.new(data)
    assert @property.save, "Failed to save property with minimum valid data"
  end
  
  test "" do
    
  end
  
end
