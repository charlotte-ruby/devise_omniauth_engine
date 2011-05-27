class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles, :force => true do |t|
      t.integer :user_id
      t.string :email
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :location_id
      t.string :description
      t.string :image
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end