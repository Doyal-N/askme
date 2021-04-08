class QuestionDecorator < ApplicationDecorator
  delegate_all

  def normalize_date
    object.created_at.strftime('%d %b %M:%H')
  end

  def true_icon
    if object.answer.blank?
      'fas fa-reply'
    else
      'fas fa-pencil-alt'
    end
  end
end
