require 'spec_helper'
require 'rails_helper'

feature 'Remove books from cart' do
  before do
    book = Book.create title: "Geralt"
    category = Category.create title: "Programming"
    category.books << book
  end

  scenario 'remove book' do
    visit books_path
    click_link("Buy book")
    visit cart_path 
    click_link("Remove")
    expect(page).to have_content("Items in cart 0")
  end

end
