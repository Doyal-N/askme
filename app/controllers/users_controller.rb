class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    @questions_count = @questions.length
    @answered_questions_count = @user.questions.where.not(answer: nil).count
    @unanswered_questions_count = @questions_count - @answered_questions_count
  end
end
