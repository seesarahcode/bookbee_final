class FollowsController < ApplicationController
  before_action :set_user
  before_action :set_follow, only: [:edit, :update]

  # GET /follows
  # GET /follows.json
  def index
    @follows = @user.follows
  end

  # GET /follows/new
  def new
    @follow = @user.follows.build
  end


  # POST /follows
  # POST /follows.json
  def create
    @follow = @user.follows.build(follow_params)
    respond_to do |format|
      if @follow.save
        format.html { redirect_to @user, notice: 'You are now following this book!' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /follows/1/edit
  def edit
    @follow = @user.follows.find(params[:id])
  end

  # PATCH/PUT /follows/1
  # PATCH/PUT /follows/1.json
  def update
    @follow = @user.follows.find(params[:id])
    respond_to do |format|
      if @follow.update_attributes(follow_params)
        format.html { redirect_to email_preferences_path, notice: "Follow status updated." }
        format.json { head :no_content }
      else
        format.html { redirect_to email_preferences_path }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1
  # DELETE /follows/1.json
  def destroy
    @follow = @user.follows.find(params[:id])
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to email_preferences_path }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = @user.follows.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def set_book
      @book = Book.find_by_id(params[:book_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follow_params
      params.require(:follow).permit(:user_id, :title, :ratings, :reviews, :book_id)
    end
end
