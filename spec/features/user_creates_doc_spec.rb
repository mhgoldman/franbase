require 'rails_helper'

RSpec.feature "UserCreatesDoc", type: :feature do
  before do
    user = create(:user)
    user.update!(password: 'testpassword', password_confirmation: 'testpassword')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'testpassword'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'User creates doc successfully' do
    click_link 'New doc'
    fill_in 'Name', with: 'a brand new doc'
    fill_in 'Tags', with: 'one,two,three'
    fill_in 'Content', with: 'Lorem ipsum et cetera'
    click_button 'Create Doc'
    expect(page).to have_content('Doc created!')
  end

  scenario 'User fails to create doc without name' do
    click_link 'New doc'
    fill_in 'Tags', with: 'one,two,three'
    fill_in 'Content', with: 'Lorem ipsum et cetera'
    click_button 'Create Doc'
    expect(page).to have_content("Name can't be blank")    
  end
end
