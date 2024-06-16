class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :phone_number, null: false, index: {unique: true}
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :otp_secret_key
      t.integer :last_otp_at

      t.timestamps
    end
  end
end
