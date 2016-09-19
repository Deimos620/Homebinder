#---------------------
# the one pager report for the seller
#---------------------

require 'date'
require 'open-uri'
require 'uri'
require 'prawn/table'

class SellerReportPdf < Prawn::Document
  def to_pdf(seller_report)
    @seller_report = seller_report
    binder = @seller_report.binder
    
    date = Date.today
    
    font_families.update("Arvo" => {
      :normal => { :file => "#{Rails.root}/app/assets/fonts/Arvo-Regular.ttf" },
      :italic => { :file => "#{Rails.root}/app/assets/fonts/Arvo-Italic.ttf" },
      :bold => { :file => "#{Rails.root}/app/assets/fonts/Arvo-Bold.ttf" },
      :bold_italic => { :file => "#{Rails.root}/app/assets/fonts/Arvo-BoldItalic.ttf" }
    })
    
    # logos
    bounding_box([0, 726], :width => bounds.width, :height => 50) do
      # hb logo, top left
      image "#{Rails.root}/app/assets/images/pdf/flatlogonotext.png", :height => 50, :position => :left, :vposition => :top
      
      # broker logo, top right
      move_up(50)
      if not binder.partner.nil?
        if not binder.partner.seller_report_logo.nil?
          image open(binder.partner.seller_report_logo.location, {ssl_verify_mode:OpenSSL::SSL::VERIFY_NONE}), :height => 40, :position => :right, :vposition => :top
        end
      end
      #image "#{Rails.root}/app/assets/images/pdf/brokerplaceholder.png", :height => 50, :position => :right, :vposition => :top
    end
                
    # report title
    formatted_text_box [
      { :text => "Seller's Report for\n", :color => "999999", :size => 8 },
      { :text => "#{binder.property.address1}\n", :size => 22, :font => "Arvo" },
      { :text => "#{binder.property.city}, #{binder.property.state} #{binder.property.zip}", :color => '999999', :size => 12, :font => "Arvo" }
    ], :at => [50, 725], :width => 400, :height => 80
        
  
    # property address
    #move_down(15)
    #formatted_text_box [
    #  
    #], :at => [0, cursor], :width => 400, :height => 100


    # appliances list
    appliances = @seller_report.appliances.order('install_date DESC').first(3)
    if(appliances.length > 0)
      move_down(15)
      formatted_text_box [
        { :text => "#{I18n.t(:appliance).pluralize}", :size => 14, :color => "ff6633" },
      ], :at => [0, cursor], :width => 400, :height => 50
      
      move_down(15)

      aplen = @seller_report.appliances.length
      appliancedata = [[ "DETAILS", "MAKE & MODEL", "YEAR INSTALLED" ]]
      appliances.each do |appliance|
        apname = "<b>#{appliance.name}</b>" unless appliance.name.nil?
        if not appliance.details.nil?
          apname += "\n#{appliance.details.truncate(50, :separator => ' ')}"
        end
        apmanu = "<b>#{appliance.manufacturer}</b>" unless appliance.manufacturer.nil?
        if not appliance.model.nil?
          if(apmanu)
            apmanu += "\n#{appliance.model.upcase}"
          else
            apmanu = "#{appliance.model}"
          end
        end
        apdate = appliance.install_date.strftime("%Y") unless appliance.install_date.nil?
        
        appliancedata += [[ apname, apmanu, apdate ]]
      end 
      
      table(appliancedata, :header => true, :width => bounds.width, :cell_style => { :inline_format => true }) do
        cells.padding       = 6
        cells.borders       = [:bottom]
        cells.size          = 9
        cells.border_color  = "686868"
         
        row(0).borders      = [:bottom]
        row(0).border_width = 1
        row(0).font_style   = :bold
        row(0).size         = 8
        
        column(2).align     = :right
      end
      
      if (aplen - 3) > 0
        move_down(5)
        text "+#{aplen - 3} more at homebinder.com", :size => 8, :align => :right
        move_up(15)
      end
    end
    
    
    # maintenance list
    maintenance_items = @seller_report.maintenance_items.order('name').first(3)
    if(maintenance_items.length > 0)
      move_down(25)
      formatted_text_box [
        { :text => "Maintenance", :size => 14, :color => "ff6633" },
      ], :at => [0, cursor], :width => 400, :height => 50
      
      move_down(15)
      
      milen = @seller_report.maintenance_items.length
      #@maint_items = binder.maintenance_items.sort_by {|i| i.next_event.do_date}
      maintdata = [[ "DESCRIPTION", "FREQUENCY" ]]
      maintenance_items.each do |item|
        iname = "<b>#{item.name}</b>" unless item.name.nil?
        if not item.details.nil?
          if(iname)
            iname += "\n#{item.details.truncate(75, :separator => ' ')}"
          else
            iname = "#{item.details.truncate(75, :separator => ' ')}"
          end
        end

        sinterval = ""
        if not item.interval.nil? and not item.maintenance_cycle.nil?
          sinterval = "Every "
          sinterval << item.interval.to_s unless item.interval.nil?
          sinterval << ' ' + item.maintenance_cycle unless item.maintenance_cycle.nil?
        end
        
        maintdata += [[ iname, sinterval ]]
      end 
      
      table(maintdata, :header => true, :width => bounds.width, :cell_style => { :inline_format => true }) do
        cells.padding       = 6
        cells.borders       = [:bottom]
        cells.size          = 9
        cells.border_color  = "686868"
         
        row(0).borders      = [:bottom]
        row(0).border_width = 1
        row(0).font_style   = :bold
        row(0).size         = 8

        column(1).align     = :right
      end
      
      if (milen - 3) > 0
        move_down(5)
        text "+#{milen - 3} more at homebinder.com", :size => 8, :align => :right
        move_up(15)
      end
    end


    # improvements list
    projects = @seller_report.projects.order('end_date DESC').first(3)
    if(projects.length > 0)
      move_down(25)
      formatted_text_box [
        { :text => "Home Improvements", :size => 14, :color => "ff6633" },
      ], :at => [0, cursor], :width => 400, :height => 50
      
      move_down(15)

      plen = projects.length
      projectdata = [[ "DESCRIPTION", "COMPLETED" ]]
      projects.each do |project|
        pname = "<b>#{project.name}</b>" unless project.name.nil?
        if not project.details.nil?
          pname += "\n#{project.details.truncate(75, :separator => ' ')}"
        end
        if not project.end_date.nil?
          pendd = project.end_date.strftime("%B %Y")
        else
          pendd = "In Progress"
        end 
        
        projectdata += [[ pname, pendd ]]
      end 
      
      table(projectdata, :header => true, :width => bounds.width, :cell_style => { :inline_format => true }) do
        cells.padding       = 6
        cells.borders       = [:bottom]
        cells.size          = 9
        cells.border_color  = "686868"
         
        row(0).borders      = [:bottom]
        row(0).border_width = 1
        row(0).font_style   = :bold
        row(0).size         = 8

        column(1).align     = :right
      end
      
      if (plen - 3) > 0
        move_down(5)
        text "+#{plen - 3} more at homebinder.com", :size => 8, :align => :right
        move_up(15)
      end
    end
    
    
    # contractors list
    contractors = @seller_report.contractors.first(3)
    if(contractors.length > 0)
      move_down(25)
      formatted_text_box [
        { :text => "Contractors", :size => 14, :color => "ff6633" },
      ], :at => [0, cursor], :width => 400, :height => 50
      
      move_down(15)    

      clen = contractors.length
      contrdata = [[ "NAME", "TYPE", "CONTACT" ]]
      contractors.each do |binder_contractor|
        contractor = binder_contractor.contractor
        cname = "<b>#{contractor.name.titleize}</b>" unless contractor.name.nil?
        ctype = contractor.contractor_type.titleize unless contractor.contractor_type.nil?
        if not contractor.phone.nil?
          ccont = contractor.phone.phony_formatted(:normalize => :US, :format => :national, :spaces => '-')
        else 
          if not contractor.email.nil?
            ccont = contractor.email
          end
        end
        
        contrdata += [[ cname, ctype, ccont ]]
      end 
      
      table(contrdata, :header => true, :width => bounds.width, :cell_style => { :inline_format => true }) do
        cells.padding       = 6
        cells.borders       = [:bottom]
        cells.size          = 9
        cells.border_color  = "686868"
         
        row(0).borders      = [:bottom]
        row(0).border_width = 1
        row(0).font_style   = :bold
        row(0).size         = 8

        column(2).align     = :right
      end
      
      if (clen - 3) > 0
        move_down(5)
        text "+#{clen - 3} more at homebinder.com", :size => 8, :align => :right
        move_up(15)
      end
    end
    
    
    # footer
    repeat(:all, :dynamic => true) do
      bounding_box([0,40], :width => bounds.width, :height => 30) do
        text "Get the full report at http://www.homebinder.com/#/SellerReport/" << @seller_report.code, :size => 11, :align => :center
        move_down(5)
        text "Information contained in this report is provided by the Seller.", :size => 8, :align => :center, :color => "686868"
      end
      
      formatted_text_box [
        { :text => "Website: www.homebinder.com\n", :size => 8, :color => "686868" },
        { :text => "Call support: 800.377.6915", :size => 8, :color => "686868" }
      ], :at => [0, 0], :width => 400, :height => 50
        
      formatted_text_box [
        { :text => "Report Date: #{date}", :size => 8, :color => "686868" }
      ], :at => [bounds.right-90, 0], :width => 100, :height => 50
    end
      
    render
  end
end