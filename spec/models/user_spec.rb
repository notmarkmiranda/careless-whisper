require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#set_phone_number validation" do
    it "sets the phone number to E.164 format" do
      user = User.build(phone_number: "+1 (303) 847.6953")
      user.save

      expect(user.phone_number).to eq("+13038476953")
    end

    it "does not set the phone number if it is invalid" do
      user = User.build(phone_number: "123")

      expect(user.save).to eq(false)
      expect(user.errors.full_messages).to eq(["Phone number is invalid"])
    end
  end
end
