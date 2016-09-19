require 'date'
require 'open-uri'
require 'uri'
require 'prawn'
require 'prawn/table'

class SellerReportPdfService
  
  def self.create(seller_report)
    pdf = Prawn::Document.new
    
    # figure out the number of items to print for each group
    det_item_ct(pdf, seller_report)
    
    init(pdf)
    add_logos(pdf, seller_report)
    add_title(pdf, seller_report)
    add_appliances(pdf, seller_report)
    add_maintenance(pdf, seller_report)
    add_projects(pdf, seller_report)
    add_contractors(pdf, seller_report)
    add_footer(pdf, seller_report)
    pdf
  end
  
  private
  
  # determine how many of each category to print
  def self.det_item_ct(pdf, seller_report)
    acount    = seller_report.appliances.length         # appliances
    mcount    = seller_report.maintenance_items.length  # maintenance
    pcount    = seller_report.projects.length           # projects
    ccount    = seller_report.contractors.length        # contractors
    tprinted  = 12                                      # total remaining to be printed (12)
    addgrpct  = 0                                       # num of groups to add to (0)
    
    # appliances
    if(acount >= 3)
      aprintcount = 3
    else
      aprintcount = acount
    end
    
    tprinted = (tprinted - aprintcount)
    
    # maintenances
    if(mcount >= 3)
      mprintcount = 3
    else
      mprintcount = mcount
    end
    
    tprinted = (tprinted - mprintcount)
    
    # projects
    if(pcount >= 3)
      pprintcount = 3
    else
      pprintcount = pcount
    end
    
    tprinted = (tprinted - pprintcount)
    
    # contractors
    if(ccount >= 3)
      cprintcount = 3
    else
      cprintcount = ccount
    end
    
    tprinted = (tprinted - cprintcount)
    
    # now see what we've got left
    # after our first round of printing/counting
    if(tprinted > 0)
      
      # if any of the item counts are greater than 3
      # set them as able to be added to
      # and keep count of how many item groups 
      # can take extra items
      if(acount > 3)
        acountadd = true
        addgrpct += 1
      end
      if(mcount > 3)
        mcountadd = true
        addgrpct += 1
      end
      if(pcount > 3)
        pcountadd = true
        addgrpct += 1
      end
      if(ccount > 3)
        ccountadd = true
        addgrpct += 1
      end
      
      # now determine how many items to add to each group
      # by dividing the number of remaining items
      # with the number of groups that can take extra items
      itemcttoadd = addgrpct == 0 ? 0 : (tprinted / addgrpct).round
      
      # groups that can take must already have 3,
      # that's just how this works.
      
      # TODO: for example if itemcttoadd is 2 and one grp only has 4
      # figure out what to do with the remainder.
      if(acountadd == true)
        @aprintcount = 3 + itemcttoadd
      else
        @aprintcount = acount
      end
      
      if(mcountadd == true)
        @mprintcount = 3 + itemcttoadd
      else
        @mprintcount = mcount
      end
    
      if(pcountadd == true)
        @pprintcount = 3 + itemcttoadd
      else
        @pprintcount = pcount
      end
    
      if(ccountadd == true)
        @cprintcount = 3 + itemcttoadd
      else
        @cprintcount = ccount
      end
    end
  end
  
  def self.init(pdf)
    pdf.font_families.update("Arvo" => {
      :normal => { :file => "#{Rails.root}/app/assets/fonts/Arvo-Regular.ttf" },
      :italic => { :file => "#{Rails.root}/app/assets/fonts/Arvo-Italic.ttf" },
      :bold => { :file => "#{Rails.root}/app/assets/fonts/Arvo-Bold.ttf" },
      :bold_italic => { :file => "#{Rails.root}/app/assets/fonts/Arvo-BoldItalic.ttf" }
    })
  end
  
  def self.add_logos(pdf, seller_report)
    binder = seller_report.binder
    # logos
    pdf.bounding_box([0, 726], :width => pdf.bounds.width, :height => 50) do
      # hb logo, top left
      pdf.image "#{Rails.root}/app/assets/images/pdf/flatlogonotext.png", :height => 50, :position => :left, :vposition => :top
      
      # broker logo, top right
      pdf.move_up(50)
      if binder.partner
        if binder.partner.seller_report_logo
          pdf.image open(binder.partner.seller_report_logo.location, {ssl_verify_mode:OpenSSL::SSL::VERIFY_NONE}), :height => 40, :position => :right, :vposition => :top
        end
      end
      #image "#{Rails.root}/app/assets/images/pdf/brokerplaceholder.png", :height => 50, :position => :right, :vposition => :top
    end
  end
  
  def self.add_title(pdf, seller_report)
    binder = seller_report.binder
    # report title
    pdf.formatted_text_box [
      { :text => "Seller's Report for\n", :color => "999999", :size => 8 },
      { :text => "#{binder.property.address1}\n", :size => 22, :font => "Arvo" },
      { :text => "#{binder.property.city}, #{binder.property.state} #{binder.property.zip}", :color => '999999', :size => 12, :font => "Arvo" }
    ], :at => [50, 725], :width => 400, :height => 80
  end
  
  def self.add_appliances(pdf, seller_report)
    # appliances list
    appliances = seller_report.appliances.order('install_date DESC').first(@aprintcount)
    if(appliances.length > 0)
      pdf.move_down(15)
      pdf.formatted_text_box [
        { :text => "#{I18n.t(:appliance).pluralize}", :size => 14, :color => "ff6633" },
      ], :at => [0, pdf.cursor], :width => 400, :height => 50
      
      pdf.move_down(15)

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
      
      pdf.table(appliancedata, :header => true, :width => pdf.bounds.width, :cell_style => { :inline_format => true }) do
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
      
      aplen = seller_report.appliances.length
      if (aplen - @aprintcount) > 0
        pdf.move_down(5)
        pdf.text "+#{aplen - @aprintcount} more at homebinder.com", :size => 8, :align => :right
        pdf.move_up(15)
      end
    end
  end
  
  def self.add_maintenance(pdf, seller_report)
    # maintenance list
    maintenance_items = seller_report.maintenance_items.order('name').first(@mprintcount)
    if(maintenance_items.length > 0)
      pdf.move_down(25)
      pdf.formatted_text_box [
        { :text => "Maintenance", :size => 14, :color => "ff6633" },
      ], :at => [0, pdf.cursor], :width => 400, :height => 50
      
      pdf.move_down(15)
      
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
      
      pdf.table(maintdata, :header => true, :width => pdf.bounds.width, :cell_style => { :inline_format => true }) do
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
      
      milen = seller_report.maintenance_items.length
      if (milen - @mprintcount) > 0
        pdf.move_down(5)
        pdf.text "+#{milen - @mprintcount} more at homebinder.com", :size => 8, :align => :right
        pdf.move_up(15)
      end
    end
  end
  
  def self.add_projects(pdf, seller_report)
    # improvements list
    projects = seller_report.projects.order('end_date DESC').first(@pprintcount)
    if(projects.length > 0)
      pdf.move_down(25)
      pdf.formatted_text_box [
        { :text => "Home Improvements", :size => 14, :color => "ff6633" },
      ], :at => [0, pdf.cursor], :width => 400, :height => 50
      
      pdf.move_down(15)

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
      
      pdf.table(projectdata, :header => true, :width => pdf.bounds.width, :cell_style => { :inline_format => true }) do
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
      
      plen = seller_report.projects.length
      if (plen - @pprintcount) > 0
        pdf.move_down(5)
        pdf.text "+#{plen - @pprintcount} more at homebinder.com", :size => 8, :align => :right
        pdf.move_up(15)
      end
    end
  end
  
  def self.add_contractors(pdf, seller_report)
    # contractors list
    contractors = seller_report.contractors.first(@cprintcount)
    if(contractors.length > 0)
      pdf.move_down(25)
      pdf.formatted_text_box [
        { :text => "Contractors", :size => 14, :color => "ff6633" },
      ], :at => [0, pdf.cursor], :width => 400, :height => 50
      
      pdf.move_down(15)    

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
      
      pdf.table(contrdata, :header => true, :width => pdf.bounds.width, :cell_style => { :inline_format => true }) do
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
      
      clen = seller_report.contractors.length
      if (clen - @cprintcount) > 0
        pdf.move_down(5)
        pdf.text "+#{clen - @cprintcount} more at homebinder.com", :size => 8, :align => :right
        pdf.move_up(15)
      end
    end
  end
  
  def self.add_footer(pdf, seller_report)
    # footer
    pdf.repeat(:all, :dynamic => true) do
      pdf.bounding_box([0,40], :width => pdf.bounds.width, :height => 30) do
        pdf.text "Get the full report at http://www.homebinder.com/#/SellerReport/" << seller_report.code, :size => 11, :align => :center
        pdf.move_down(5)
        pdf.text "Information contained in this report is provided by the Seller.", :size => 8, :align => :center, :color => "686868"
      end
      
      pdf.formatted_text_box [
        { :text => "Website: www.homebinder.com\n", :size => 8, :color => "686868" },
        { :text => "Call support: 800.377.6915", :size => 8, :color => "686868" }
      ], :at => [0, 0], :width => 400, :height => 50
        
      pdf.formatted_text_box [
        { :text => "Report Date: #{Date.today}", :size => 8, :color => "686868" }
      ], :at => [pdf.bounds.right-90, 0], :width => 100, :height => 50
    end
  end
  
end