class QuestionDecorator < ApplicationDecorator
  include ActionView::Helpers::UrlHelper
  delegate_all

  def normalize_date
    object.created_at.strftime('%d %b %H:%M')
  end

  def action_icon
    if object.answer.blank?
      'fas fa-reply'
    else
      'fas fa-pencil-alt'
    end
  end

  def author_link
    author = object.author
    return unless author.present? && object.user != author

    h.link_to author.username, h.user_path(author), class: 'link-author'
  end
end
