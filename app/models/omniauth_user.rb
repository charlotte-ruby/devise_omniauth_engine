module OmniauthUser
  def self.find_or_create(auth)
    email = auth['user_info']['email'] || auth['user_info']['nickname']
    user = User.find_by_email(email)
    if user.blank?
      user = User.new(:email => email, :password => Devise.friendly_token[0,20])
      user.authentications.build(:provider => auth['provider'], :uid => auth['uid'])
      user.save!(:validate=>false)
    else
      #make sure they logged in with the same provider.  It is possible for someone to fake the email
      return nil if user.authentications.where(:uid=>auth['uid'],:provider=>auth['provider']).count!=1
    end
    user
  end
end