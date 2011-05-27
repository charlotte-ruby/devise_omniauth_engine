class CreateProfileLocations < ActiveRecord::Migration
  def self.up
    create_table :profile_locations, :force => true do |t|
      t.integer :profile_id
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.float :longitude
      t.float :latitude
      t.timestamps
    end
  end

  def self.down
    drop_table :profile_locations
  end
end