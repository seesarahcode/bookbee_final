class BlockedUserController < ApplicationController

	before_action :set_user

	def index
		@user = User.find(params[:user_id])
		@blocked_users = @user.blocked_users(params[:blocked_users)
	end

	def new
		@blocked_user = @user.blocked_users.build
	end

	def create
		@blocked_user = @user.blocked_users.build(blocked_user_params)
    if @blocked_user.save
      flash[:success] = "User blocked!"
      redirect_to user_path(@user)
	  else
      render user_path(@user)
  	end
	end

	def show
		redirect_to user_path(@user)
	end

	def edit
			end

	def update
		@blocked_user= @user.blocked_users.find(params[:id])
    if @blocked_user.update_attributes(blocked_user_params)
      flash[:success] = "Blocked status updated!"
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user), :flash => { :error => "Blocked status could not be updated." }
    end
	end

	def destroy 
		@blocked_user = @user.blocked_users.find(params[:id])
	    @blocked_user.destroy
	    respond_to do |format|
	      format.html { redirect_to user_path(@user) }
	      format.json { head :no_content }
	    end
	end

	private

		def blocked_user_params
			params.require(:blocked_user).permit(:user_id, :date_blocked)
		end

		def set_user
			@user = User.find_by_id(params[:id])
		end
end
