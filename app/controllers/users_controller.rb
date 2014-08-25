class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, user_params)
                             @user.update(user_params)
                           else
                             params[:user].delete(:password)
                             params[:user].delete(:password_confirmation)
                             @user.update_without_password(user_params)
                           end

    if successfully_updated
      flash[:success] = "Profile updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:id])
    @books = @user.books.paginate(page: params[:page])
    if signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def new
  	@user = User.new
  end

  def new_admin
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to Bookbee!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def email_preferences
  end
  
  private

  def user_params
  	params.require(:user).permit(:name, :email, :admin,
  															:password, :password_confirmation)
  end

  def needs_password?(user, params)
    params[:password].present? ||
    params[:password_confirmation].present?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])  
    redirect_to root_url, notice: "You are not authorized to request this page"  unless admin?(current_user) || current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless admin?(current_user)
  end

end
