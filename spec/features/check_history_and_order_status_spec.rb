require 'spec_helper'
require 'rails_helper'

feature 'Orders history and status' do

  scenario 'check history' do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email', with: "order_tester@gmail.com"
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button('Sign up')
    end

    user_id = User.find_by(email: "order_tester@gmail.com").id
    Order.create number: "1", aasm_state: :in_progress, user_id: user_id
    Order.create number: "2", aasm_state: :processing, user_id: user_id
    Order.create number: "3", aasm_state: :in_delivery, user_id: user_id
    Order.create number: "4", aasm_state: :delivered, user_id: user_id
    Order.create number: "5", aasm_state: :cancelled, user_id: user_id

    visit orders_path
    expect(page).to have_content "Processing In delivery Delivered Cancelled"
  end

  scenario 'check status' do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email', with: "order_tester@gmail.com"
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_button('Sign up')
    end

    user_id = User.find_by(email: "order_tester@gmail.com").id
    @order = Order.create number: "1", aasm_state: :in_progress, user_id: user_id
    visit order_path(@order)
    expect(page).to have_content "In progress"
  end

end
