require 'spec_helper'
require 'rails_helper'

feature 'Searching book' do

  before do
    book = Book.create title: "Geralt"
    author = Author.create full_name: "Swiss"
    category = Category.create title: "Programming"
    category.books << book
    book.authors << author
    author.books << book
    visit books_path
  end

  scenario 'Visitor searches books by title' do
    fill_in 'search', with: "Geralt"
    click_button('Search')
    expect(page).to have_content 'Geralt'
  end

  scenario 'Visitor searches books by author' do
    fill_in 'search', with: "Swiss"
    click_button('Search')
    expect(page).to have_content 'Geralt'
  end

end
