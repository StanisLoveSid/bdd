require 'spec_helper'
require 'rails_helper'

feature 'View detailed book information' do

  before do
    @book = Book.create(
      title: "Geralt", number_of_pages: 543,
      publication_date: "30.10.1979", description: "turbo description"
    )
    category = Category.create title: "Programming"
    category.books << @book
    author = Author.create full_name: "Swiss"
    @book.authors << author
    author.books << @book
  end

  scenario 'Visitor looks book' do
    visit book_path(@book)
    expect(page).to have_content "Geralt"
    expect(page).to have_content "543"
    expect(page).to have_content "30.10.1979"
    expect(page).to have_content "turbo description"
    expect(page).to have_content "Swiss"
  end

end
