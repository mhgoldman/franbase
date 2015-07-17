require 'rails_helper'

RSpec.feature "UserViewsDocList", type: :feature do

  scenario 'User views doc list successfully' do
    user = create(:user)
    user.update!(password: 'testpassword', password_confirmation: 'testpassword')

    docs = create_list(:doc, 10)

    visit docs_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'testpassword'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    docs.each do |doc|
      puts doc.name
      expect(page).to have_content(doc.name)
    end
  end

  scenario 'User fails to view doc list' do
    visit docs_path
    fill_in 'Email', with: 'somethingmadeup'
    fill_in 'Password', with: 'fakepassword'
    click_button 'Log in'
    expect(page).to have_content('Invalid email or password')
  end
end