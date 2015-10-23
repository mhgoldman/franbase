require 'rails_helper'

RSpec.feature "UserViewsDocList", type: :feature do

  scenario 'User views doc list successfully' do
    docs = create_list(:doc, 10)

    docs.each {|d| d.set(updater_id: d.creator_id) }

    login
    visit docs_path

    docs.each do |doc|
      expect(page).to have_content(doc.name)
    end
  end

  scenario 'User tries to view doc list without logging in' do
    visit docs_path
    expect_login_redirect
  end
end