require 'spec_helper'
require 'rails_helper'

feature 'Navigation' do
  before do
  	Category.create title: "Programming"
  end	
  scenario 'Visitor navigates site by categories' do
    visit categories_path
    click_link("Programming")
    expect(page).to have_content 'Category Programming'
  end
end
