require 'spec_helper'
require 'rails_helper'

feature 'User writes a review' do
  before do
  	@book = Book.create title: "Lol"
  end

  scenario 'create review' do
    visit book_path(@book)
    within ".add-review" do
      fill_in "Description", with: Faker::Lorem.paragraph 
      fill_in "Title", with: Faker::Lorem.word
      choose("5")
      click_button('Submit')
    end
    expect(page).to have_content("Administrator")
  end
end
