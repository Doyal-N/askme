class UserDecorator < ApplicationDecorator
  delegate_all

  def user_avatar
    object.avatar_url || 'avatar.jpg'
  end

  def correct_ending(one, two, many)
    number ||= object.questions.count
    last_num = number % 10
    last_num2 = number % 100

    return many if last_num2.between?(11, 14)
    return one if last_num == 1
    return two if last_num.between?(2, 4)

    many
  end
end
