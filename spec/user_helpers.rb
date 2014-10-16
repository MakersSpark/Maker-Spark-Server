def sign_up(email                 =  'byverdu@test.com',
	          github                = 'byverdu',
	          password              = 's3cr3t',
	          password_confirmation = 's3cr3t')

	visit '/sign_up'

	fill_in 'email',                 with: email
	fill_in 'github',								 with: github
	fill_in 'password',              with: password
	fill_in 'password_confirmation', with: password_confirmation

	click_button 'Sign up'
end

def sign_in(email 		= 'byverdu@test.com',
			password 	= 's3cr3t')
	visit '/sign_in'
	fill_in 'email',    with: email
	fill_in 'password', with: password
	click_button 'Sign in'

end

def wrong_sign_in(email, password)

	visit '/sign_in'
	fill_in 'email',    with: email
	fill_in 'password', with: password
	click_button 'Sign in'
end
