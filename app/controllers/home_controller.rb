class HomeController < ApplicationController
  def index
  end

  def test_vonage_api
    client.sms.send(
      from: "15862801778",
      to: "13038476953",
      text: 'Careless whisper 🎷'
    )

    redirect_to root_path
  end

  private

  def client
    @client ||= Vonage::Client.new(
      api_key: ENV["VONAGE_API_KEY"],
      api_secret: ENV["VONAGE_API_SECRET"]
    )
  end
end
