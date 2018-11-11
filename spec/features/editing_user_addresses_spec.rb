require 'spec_helper'
require 'rails_helper'

feature 'Editing user information' do
  scenario 'addresses' do

    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button('Sign up')
    end

    visit edit_user_registration_path
    within ".user-billing" do
      fill_in 'Address', with: Faker::Address.full_address
      fill_in 'Zipcode', with: Faker::Address.zip_code
      fill_in 'City', with: Faker::Address.city
      fill_in 'Phone', with: Faker::Internet.email
      fill_in 'Country', with: Faker::PhoneNumber.phone_number
      click_button('Submit')
    end
    expect(page).to have_content("Your information was successfuly updated")
  end
end
