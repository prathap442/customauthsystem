class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.string :password
      t.string :otp_sent
      t.string :is_verified
      t.string :is_registered
      t.string :session_token

      t.timestamps
    end
  end
end
