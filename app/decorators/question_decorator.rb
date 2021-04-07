class QuestionDecorator < ApplicationDecorator
  delegate_all

  def normalize_date
    object.created_at.strftime('%d %b %M:%H')
  end
end
