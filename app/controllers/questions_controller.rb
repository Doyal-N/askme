class QuestionsController < ApplicationController
  helper_method :question

  before_action :authorize_user, except: [:create]

  def edit; end

  def create
    @question = Question.new(question_params)
    @question.author = current_user if current_user

    if question.save
      redirect_to user_path(question.user), notice: 'Вопрос задан'
    else
      render :edit
    end
  end

  def update
    if question.update(question_params)
      redirect_to user_path(question.user), notice: 'Вопрос сохранен'
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to user_path(question.user), notice: 'Вопрос удален :('
  end

  private

  def authorize_user
    reject_user unless question.user == current_user
  end

  def question
    @question ||= params[:id].present? ? Question.find(params[:id]) : Question.new
  end

  def question_params
    if params[:question][:user_id].to_i == current_user&.id
      params.require(:question).permit(:user_id, :text, :answer)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end
end
