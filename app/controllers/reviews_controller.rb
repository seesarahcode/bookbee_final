class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  after_action :send_individual_emails, only: [:create, :edit, :update]
  
  include UsersHelper
  # GET /reviews
  # GET /reviews.json
  def index
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews.paginate(page: params[:review])
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])
  end

  # GET /reviews/new
  def new
    @review = @book.reviews.build
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = @book.reviews.build(review_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_to [@book, @review], notice: 'Review was successfully created!' }
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { render action: 'new' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = @book.reviews.find(params[:id])
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    @review = @book.reviews.find(params[:id])
    respond_to do |format|
      if @review.update_attributes(review_params)
        format.html { redirect_to [@book, @review], notice: 'Review was successfully updated!' }
        format.json { head :no_content }
      else
        redirect_to edit_book_review_path(@book, @review)
        flash[:errors] = "Something went wrong."
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = @book.reviews.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @book }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = @book.reviews.find(params[:id])
    end

    def set_book
      @book = Book.find_by_id(params[:book_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:title, :text, :fave_quote, :user_id)
    end

    # Returns BCC list
  def review_individual_email_list(book)
    # email list to return at the end
    @bcc_individual = []
    # search through every user and find
    User.all.each do |u|
      # if User has a Follow that matches this book and receives individual emails
      if following?(u, book) && u.email_frequency == :individual
        # and follow's reviews are set to true
        Follow.all.each do |f|
          if f.reviews == true
            # add to bcc
            @bcc_individual << u.email
          end
        end
      elsif following?(u, book) && u.email_frequency == :daily
        create_digest_events(book)
      end
    end
    return @bcc_individual
  end

  def following?(user, book)
    user.follows.where(book_id = book.id).exists?
  end

  def send_individual_emails
    bcc_list = review_individual_email_list(@book)
    # for everyone 
    ReviewMailer.review_notification(bcc_list, @book).deliver
    @owner = User.find_by_id(@book.user_id)
    # Add owner to list?
    if receives_book_updates?(@owner)
      ReviewMailer.creator_notification(@owner, @book).deliver
    end
  end

  def create_digest_events(book)
    # search through every user and find
    User.all.each do |u|
      # if User has a Follow that matches this book and receives daily emails
      if following?(u, book) && u.email_frequency == :daily
          # and follow's reviews are set to true
          Follow.all.each do |f|
            if f.reviews == true
              new_event = DailyDigestEvent.new(:user_id => u.id, :book_id => book.id, :update_type => :review)
              new_event.save!
            end
          end
      end
  end
end

end