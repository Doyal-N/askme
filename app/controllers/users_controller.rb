class UsersController < ApplicationController
  helper_method :user

  before_action :authorize_user, only: %i[edit destroy update]

  def index
    @users = User.all
    @hashtags = Hashtag.all
  end

  def new; end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Пользователь успешно зарегистрирован!'
    else
      render :new
    end
  end

  def show
    @questions = user.questions.sorted
    @questions_count = @questions.length
    @answered_questions_count = @questions.where.not(answer: nil).count
    @unanswered_questions_count = @questions_count - @answered_questions_count
    @new_question = user.questions.build
  end

  def edit; end

  def update
    if user.update(user_params)
      redirect_to user_path(user), notice: 'Данные обновлены'
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Профиль удален, приходите еще!'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username,
                                 :avatar_url,
                                 :header_color)
  end

  def user
    @user ||= params[:id].present? ? User.find(params[:id]) : User.new
  end

  def authorize_user
    reject_user unless user == current_user
  end
end
