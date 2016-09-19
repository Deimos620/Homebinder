namespace :subscription do
  
  desc "This task is used to set the subscriptions to free"
  task :update_subsc_plan => :environment do
    subscriptions = Subscription.all
    @errors = 0
    subscriptions.each do |s|
      s.plan_id = "free"
      if not s.save
        errors += 1
      end
    end
  end
  
  desc "This task is used to upgrade family and friends"
  task :upgrade_fam_friends => :environment do
    subscriptions = Subscription.all
    @errors = 0
    subscriptions.each do |s|
      if s.plan_id == 'free'
        s.plan_id = 'standard'
        s.coupon_id = 'FAMFRIENDSFREE'
        s.action = 'upgrade'
        if not s.save
          errors += 1
        end
      end
    end
  end
  
end