require 'spec_helper'
require 'rails_helper'

feature 'Put books in cart' do
  before do
    book = Book.create title: "Geralt"
    author = Author.create full_name: "Swiss"
    category = Category.create title: "Programming"
    category.books << book
    book.authors << author
    author.books << book
    visit books_path
  end	

  scenario 'add book' do
   click_link("Buy book")
   expect(page).to have_content("Items in cart 1")
  end
end