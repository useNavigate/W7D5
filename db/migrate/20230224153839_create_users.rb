class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username ,index:true
      t.string :password_digest
      t.string :session_token ,index:true

      t.timestamps
    end
  end
end
