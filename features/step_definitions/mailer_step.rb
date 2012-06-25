
Then /^il sistema ha inviato (\d+) emails?$/ do |email_count|
  ActionMailer::Base.deliveries.size.to_s.should == email_count
end


Then /^il sistema non ha ancora inviato emails?$/ do
  ActionMailer::Base.deliveries = []
end