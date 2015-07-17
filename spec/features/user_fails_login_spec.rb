require 'rails_helper'

RSpec.feature "UserFailsLogin", type: :feature do
  scenario 'User fails login' do
    visit new_user_session_path
    fill_in 'Email', with: 'somethingmadeup'
    fill_in 'Password', with: 'fakepassword'
    click_button 'Log in'
    
    expect(page).to have_content('Invalid email or password')
  end
end
