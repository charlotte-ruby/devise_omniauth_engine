class CreateProfileUrls < ActiveRecord::Migration
  def self.up
    create_table :profile_urls, :force => true do |t|
      t.integer :profile_id
      t.string :name
      t.string :description
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :profile_urls
  end
end