class UserDecorator < ApplicationDecorator
  delegate_all

  def user_avatar
    object.avatar_url || 'avatar.jpg'
  end
end
