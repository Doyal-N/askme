class UsersController < ApplicationController
  def index
    @users = User.all
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
    # @questions = User.find(params[:id]).questions
    @questions = user.questions
    @questions_count = @questions.length
    @answered_questions_count = @questions.where.not(answer: nil).count
    @unanswered_questions_count = @questions_count - @answered_questions_count

    @new_question = user.questions.build
  end

  def edit; end

  def update
    if user.update(user_params)
      redirect_to user, notice: 'Данные обновлены'
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Профиль удален, приходите еще!'
  end

  helper_method :user

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username,
                                 :avatar_url,
                                 :header_color)
  end

  def user
    @user ||= params[:id] ? User.find(params[:id]) : User.new
  end

  def authorize_user
    reject_user unless user == current_user
  end
end
