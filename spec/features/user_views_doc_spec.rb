require 'rails_helper'

RSpec.feature "UserViewsDoc", type: :feature do

  scenario 'User views doc successfully' do
    doc = create(:doc)

    login
    visit doc_url(doc)

    expect(page).to have_content(doc.name)
    expect(page).to have_content(doc.tags.join(' '))
  end

  scenario 'User tries to view doc without logging in' do
    doc = create(:doc)

    visit doc_url(doc)
    expect_login_redirect
  end
end