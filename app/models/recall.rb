require 'httparty'

class Recall < ActiveResource::Base
  include HTTParty
  base_uri 'api.usa.gov'
  default_params :output => 'json'
  format :json
  
  def self.find_by_manufacturer_model(manufacturer, model = nil, start_date = nil, page = 1)
    query = ''
    if not manufacturer.nil? and not manufacturer.empty?
      query = manufacturer
    end
    
    if not model.nil? and not model.empty?
      query = query.empty? ? model : query << '+' << model
    end
    
    if start_date.nil?
      get('/recalls/search', :query => {:organization => 'CPSC', :page => page, :query => query})
    else
      get('/recalls/search', :query => {:organization => 'CPSC', :start_date => start_date, :page => page, :query => query})
    end
  end
  
  def self.find_by_upc(upc, start_date = nil, page = 1)
    if start_date.nil?
      get('/recalls/search', :query => {:organization => 'CPSC', :upc => upc, :page => page})
    else
      get('/recalls/search', :query => {:organization => 'CPSC', :upc => upc, :start_date => start_date, :page => page})
    end
  end
  
end
  

