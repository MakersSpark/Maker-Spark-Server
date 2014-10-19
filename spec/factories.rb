require 'spec_helper'

FactoryGirl.define do
	factory :user do

		factory :valid_user do
		  email "albert@test.com"
		  rfid_code '41d21cd'
		  github_user 'byverdu'
		  password  "oranges"
		  password_confirmation "oranges"
		end

		factory :duplicate_user do
		  email "albert@test.com"
		  rfid_code '41d21cd'
		  github_user 'byverdu'
		  password  "oranges"
		  password_confirmation "oranges"
		end

		factory :wrong_email_user do
			to_create {|instance| instance.save(validate: false) }
		  email "alberttestcom"
		  rfid_code '41d21cd'
		  github_user 'kikrahau'
		  password  "oranges"
		  password_confirmation "oranges"
		end

		factory :wrong_github_user do
		to_create {|instance| instance.save(validate: false) } 
		  email "albert@test.com"
		  rfid_code '41d21cd'
		  github_user 'vincentxyz'
		  password  "oranges"
		  password_confirmation "oranges"
		end

		factory :mismatching_password_user do
			to_create {|instance| instance.save(validate: false) }
		  email "ben@test.com"
		  password  "password"
		  password_confirmation "notpassword"
		end

		factory :blank_fields_user do 
			to_create {|instance| instance.save(validate: false) }
		  email "albert@test.com"
		  rfid_code '41d21cd'
		  github_user 'vincentxyz'
		  password  "oranges"
		  password_confirmation "oranges"
		end

	end
end