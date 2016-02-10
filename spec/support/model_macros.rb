module ModelMacros

  def login_admin(user = nil)
    unless user != nil
      user = FactoryGirl.create(:user)
    end

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end

  def login_user(user = nil)
    unless user != nil
      user = FactoryGirl.create(:user, admin: false)
    end

    visit new_user_session_path

    fill_in 'Email',     with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end
end
