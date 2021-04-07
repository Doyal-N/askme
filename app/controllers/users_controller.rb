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
    @questions_count = @user.questions.count
  end
end
