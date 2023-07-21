require 'spec_helper'

RSpec.feature 'User', type: :feature do
  scenario 'User can sign up' do
    visit sign_up_path

    fill_in 'Full name', with: 'John Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'

    click_button 'SIGN UP'

    expect(page).to have_text('LOG IN')
    expect(page).to have_current_path(log_in_path)
  end

  scenario 'User can log in and log out' do
    user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')

    visit log_in_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'

    click_button 'LOG IN'

    expect(page).to have_text('TRANSACTIONS')
    expect(page).to have_current_path(categories_path)
  end
end
