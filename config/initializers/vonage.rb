Vonage.configure do |config|
  config.api_key = ENV["VONAGE_API_KEY"]
  config.api_secret = ENV["VONAGE_API_SECRET"]
end
