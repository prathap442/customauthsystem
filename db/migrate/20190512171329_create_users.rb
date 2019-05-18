class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.string :password_digest
      t.string :otp_sent
      t.boolean :is_verified, default: false
      t.boolean :is_registered, default: false
      t.string :session_token
      t.datetime :signed_in_at
      t.datetime :last_signed_in_at
      t.string :otp_generated_at
      t.timestamps
    end
  end
end
