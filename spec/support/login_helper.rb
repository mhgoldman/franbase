module LoginHelper
  def login(user_options={})
    user_options = {password: 'testpassword', password_confirmation: 'testpassword'}.merge(user_options)
    user = create(:user, user_options)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    user
  end

  def expect_login_redirect
    expect(page.current_url).to eq(new_user_session_url)
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :feature
end
