require 'rails_helper'

RSpec.feature "UserCreatesDoc", type: :feature do

  scenario 'User creates doc successfully' do
    login
    old_doc_count = Doc.count

    click_link 'New doc'
    fill_in 'Name', with: 'a brand new doc'
    fill_in 'Tags', with: 'one,two,three'
    fill_in 'Content', with: 'Lorem ipsum et cetera'
    click_button 'Create Doc'
    
    expect(page).to have_content('Doc created!')
    expect(Doc.count).to eq(old_doc_count+1)
  end

  scenario 'User fails to create doc without name' do
    login
    old_doc_count = Doc.count

    click_link 'New doc'
    fill_in 'Tags', with: 'one,two,three'
    fill_in 'Content', with: 'Lorem ipsum et cetera'
    click_button 'Create Doc'
    
    expect(page).to have_content("Name can't be blank")    
    expect(Doc.count).to eq(old_doc_count)
  end

  scenario 'User tries to create doc without logging in' do
    visit new_doc_path
    expect_login_redirect
  end
end
