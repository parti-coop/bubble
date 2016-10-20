if Rails.env.development? or Rails.env.test?
  require 'sidekiq/testing'
  Sidekiq::Testing.inline!
else
  Sidekiq.configure_server do |config|
    config.redis = {namespace: "bubble:#{Rails.env}"}
  end
  Sidekiq.configure_client do |config|
    config.redis = {namespace: "bubble:#{Rails.env}"}
  end
end
