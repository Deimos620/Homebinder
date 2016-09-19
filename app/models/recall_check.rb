class RecallCheck
  def initialize(appliance)
    @appliance = appliance
  end
  
  def appliance
    @appliance
  end
  
  def total
    @total
  end
  
  def last
    @last
  end
  
  def pages
    @pages
  end
  
  def recalls
    @recalls
  end
  
  def run(start_date = nil, page = 1)
    if @appliance.has_upc
      response = Recall.find_by_upc @appliance.upc, start_date, page
    else
      if @appliance.has_manufacturer_and_model
         response = Recall.find_by_manufacturer_model(@appliance.manufacturer, @appliance.model, start_date, page)
      else
        @total = 0
        @last = 0
        return nil
      end
    end
    
    recallsHash = ActiveSupport::JSON.decode(response.body)
    
    @total = recallsHash['success']['total']
    @last = @total > 10 ? 9 : @total - 1
    @pages = @total / 10
    if @total % 10 > 1
      @pages = @pages + 1
    end
    @recalls = Array.new(@last + 1)
    for i in 0..@last
      @recalls[i] = recallsHash['success']['results'][i]
    end
    @appliance.last_recall_check = Date.current
    @appliance.save
  end
end