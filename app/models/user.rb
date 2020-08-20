class User < ApplicationRecord

  def self.from_omniauth(auth)
    user = User.find_by(id: auth[:uid]) || User.new
    user.attributes = {
      name: auth[:info][:name],
      email: auth[:info][:email],
      token: auth[:credentials][:token],
      refresh_token: auth[:credentials][:refresh_token],
    }
    user.save!
    user
  end
end
