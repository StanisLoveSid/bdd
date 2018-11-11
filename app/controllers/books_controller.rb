class BooksController < ApplicationController
 
  def index
  	found_by_title = Book.where("title LIKE ?", "%#{params[:search]}%")
  	authors = Author.where("full_name LIKE ?", "%#{params[:search]}%")
  	found_by_author = authors.map(&:books).flatten
    @books = params[:search].nil? ? Book.all : (found_by_author + found_by_title) 
  end

  def show
  	@book = Book.find(params[:id])
  end

end
