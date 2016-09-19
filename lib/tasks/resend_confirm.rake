task :resend_confirm, [:email] => :environment do |t, args|
  puts 'resending confirmation for ' << args.email
  user = User.find_by_email(args.email)
  if user.nil?
    puts 'User not found'
  else if user.confirmation_token.nil?
    puts 'User account already confirmed'
  else
    user.send_confirmation_instructions
  end
  end
  puts 'done'
end