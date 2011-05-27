module OmniauthUser
  def self.find_or_create(auth)
    info = auth['user_info']
    email = info['email'] || info['nickname']
    user = User.find_by_email(email)
    if user.blank?
      user = User.new(:email => email, :password => Devise.friendly_token[0,20])
      user.authentications.build(:provider => auth['provider'], :uid => auth['uid'])
      user.save!(:validate=>false)
      
      Profile.create(:user_id=>user.id,
                    :email => info['email'], 
                         :name => info['name'], 
                         :first_name => info['first_name'], 
                         :last_name => info['last_name'], 
                         :nickname => info['nickname'], 
                         :description => info['description'], 
                         :image => info['image'])
      info["urls"].each do |url|
        user.profile.profile_urls.create(:name=>url[0],:url=>url[1]) if url[1].present?
      end if info["urls"]
    else
      #make sure they logged in with the same provider.  It is possible for someone to fake the email
      return nil if user.authentications.where(:uid=>auth['uid'],:provider=>auth['provider']).count!=1
    end
    user
  end
end