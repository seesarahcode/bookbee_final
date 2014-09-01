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
    #@user.attributes = params[:user]
    @user.follows.each { |t| t.attributes = params[:follow][t.id.to_s] }
    if @user.valid? && @user.follows.all?(&:valid?)
      if @user.update_attributes(user_params)
        @user.save!
        @user.follows.each(&:save!)
        flash[:success] = "Profile updated!"
        redirect_to @user
      end
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
    if admin?(current_user)
      @blocked_user = @user.blocked_users.build(params[:blocked_user])
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
    @user = User.find(params[:id])
  end

  def create_blocked_user
    @user = User.find(params[:id])
    @blocked_user = @user.blocked_users.build(blocked_user_params)
    if @blocked_user.save
      @blocked_user = BlockedUser.new
    end
    redirect_to @user
    flash[:success] = "User blocked!"
  end

  def destroy_blocked_user
    @user = User.find(params[:id])
    @blocked_user = @user.blocked_users.find(params[:id])
    @blocked_user.destroy
    respond_to do |format|
        format.html { redirect_to user_path(@user), notice: "User blocked!" }
        format.json { head :no_content }
    end
  end
  
  private

  def user_params
  	params.require(:user).permit(:name, :email, :admin, :blocked, :email_frequency,
  															:password, :password_confirmation)
  end

  def blocked_user_params
    params.require(:blocked_user).permit(:user_id, :date_blocked, :blocked_user_id)
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

  def skip_password_attribute
    if params[:password].blank? && params[:password_validation].blank?
      params.except!(:password, :password_validation)
    end
  end

end
