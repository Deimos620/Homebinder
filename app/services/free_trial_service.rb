class FreeTrialService
  
  def self.request_free_trial(free_trial)
    if free_trial.save
      FreeTrialRequestMailer.delay.notify_free_trial_request_mail(free_trial)
    else
      raise UnprocessableException
    end
    
  end
  
end