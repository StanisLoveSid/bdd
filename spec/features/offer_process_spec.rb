require 'spec_helper'
require 'rails_helper'

feature 'Offering book(s)' do

  before do
    book = Book.create title: "Geralt"
    author = Author.create full_name: "Swiss"
    category = Category.create title: "Programming"
    category.books << book
    book.authors << author
    author.books << book
    order = Order.create
    delivery = Delivery.create title: "Fast"
    order.delivery = delivery
    OrderItem.create(book_id: book.id, order_id: order.id)
  end

  scenario 'step filling shipping and billing addresses' do
    visit checkout_path("address")
    within ".order-billing" do
      fill_in 'Address', with: Faker::Address.full_address
      fill_in 'Zipcode', with: Faker::Address.zip_code
      fill_in 'City', with: Faker::Address.city
      fill_in 'Phone', with: Faker::Internet.email
      fill_in 'Country', with: Faker::PhoneNumber.phone_number
    end
    click_button('Next step')
    expect(page).to have_content('Delivery')
  end

  scenario 'choose delivery' do
    visit checkout_path("delivery")
    choose("delivery")
    click_button('Next step')
    expect(page).to have_content('Credit card')
  end

  scenario 'fill credit card data' do
    visit checkout_path("payment")
    fill_in "Number", with: Faker::Number.number(12)
    fill_in "Name", with: Faker::Name.name
    fill_in "Cvv", with: Faker::Number.number(3)
    fill_in "Expiration date", with: Time.now.strftime('%y/%m')
    click_button('Next step')
    expect(page).to have_content('Confirmation')
  end

  scenario 'show all selected info, waits for user confirmation' do
    visit checkout_path("confirm")
    click_button('Confirm')
    expect(page).to have_content("Complete")
  end

end
