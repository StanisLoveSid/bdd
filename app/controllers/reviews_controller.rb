class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @book_id = @review.book_id
    respond_to do |format|
      if @review.save
        format.html  { redirect_to(book_path(@book_id), notice: 'Administrator will check it before submission') }
      else
        format.html  { redirect_to(book_path(@book_id), alert: 'Something went wrong') }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:rate, :title, :description, :book_id)
  end
end
