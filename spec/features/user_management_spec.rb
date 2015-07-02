require 'launchy'


feature 'User sign up' do 

  scenario 'I can sign up as a new user' do 
    expect { sign_up }.to change(User, :count).by(1)
    visit '/'
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  def sign_up(email: 'alice@example.com', 
              password: 'oranges!')
      visit '/users/new'
      expect(page.status_code).to eq(200)
      fill_in :email, with: email
      fill_in :password, with: password
      click_button 'Sign up'
  end


  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users') #current_path is a helper provided by Capybara
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  #Write a feature test to ensure a user can't sign up without entering an email
  scenario 'user can not sign up without entering an email address' do
    expect { sign_up(email: '') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Email address not supplied'
  end

  def sign_up(  email: 'alice@example.com',
                password: '12345678',
                password_confirmation: '12345678')
      visit '/users/new'
      fill_in :email, with: email
      fill_in :password, with: password 
      fill_in :password_confirmation, with: password_confirmation
      click_button 'Sign up'
  end



end
