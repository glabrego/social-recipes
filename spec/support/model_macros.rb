module ModelMacros

  def login_admin
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end

  def login_user
    user = FactoryGirl.create(:user, admin: false)

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end
end
