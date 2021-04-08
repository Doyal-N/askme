class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'Пользователь успешно зарегистрирован!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if user.update(user_params)
      redirect_to user, notice: 'Данные обновлены'
    else
      render :edit
    end
  end

  def show
    @new_question = user.questions.build
    @questions = user.questions.order(created_at: :desc)
    @questions_count = @questions.length
    @answered_questions_count = user.questions.where.not(answer: nil).count
    @unanswered_questions_count = @questions_count - @answered_questions_count
  end

  helper_method :user

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end

  def user
    @user ||= params[:id] ? User.find(params[:id]) : User.new
  end

  def authorize_user
    reject_user unless user == current_user
  end
end
