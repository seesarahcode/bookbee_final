class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:show, :edit, :update, :destroy]

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
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
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
end
