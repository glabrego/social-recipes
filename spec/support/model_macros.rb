module ModelMacros
  def login_admin(user = nil)
    user = FactoryBot.create(:user) if user.nil?

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'
  end

  def login_user(user = nil)
    user = FactoryBot.create(:user, admin: false) if user.nil?

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'
  end
end
