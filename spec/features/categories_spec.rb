require 'rails_helper'

RSpec.feature 'Category Management', type: :feature do
  let(:user1) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  before do
    sign_in(user1)
  end

  scenario 'User can create a new category' do
    visit new_category_path

    fill_in 'NAME', with: 'Category 1'
    fill_in 'ICON', with: 'https://example.com/category_icon.png'

    click_button 'CREATE CATEGORY'

    expect(page).to have_text('TRANSACTIONS')
    expect(page).to have_current_path(categories_path)
  end

  scenario 'User can view category details and transactions' do
    category = Category.create(name: 'Category 1', user: user1, icon: 'https://example.com/category_icon.png')

    visit category_path(category)

    expect(page).to have_text(category.name)
    expect(page).to have_text('0')
    click_link 'NEW TRANSACTION'

    expect(page).to have_current_path(new_category_purchase_path(category))

    fill_in 'NAME', with: 'Purchase'
    fill_in 'AMOUNT', with: 10
    click_button 'SAVE'

    expect(page).to have_text('DETAILS')
    expect(page).to have_current_path(category_path(category))
  end
end