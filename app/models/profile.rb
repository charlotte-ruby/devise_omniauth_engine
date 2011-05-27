class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profile_urls
  has_many :profile_locations
end