class SmsService
  attr_reader :client

  def initialize
    @client = Vonage::Client.new
  end

  def send_otp_code(user)
    otp_code = user.otp_code
    client.sms.send(
      from: ENV["VONAGE_FROM_NUMBER"],
      to: "1#{user.phone_number}",
      text: "Your OTP code is #{otp_code}. This will expire in 2 minutes."
    )
  end
end
