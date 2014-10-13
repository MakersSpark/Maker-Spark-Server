require 'spec_helper'

FactoryGirl.define do
	factory :user do

		factory :valid_user do
		  email "ben@test.com"
		  password  "password"
		  password_confirmation "password"
		end

		factory :duplicate_user do
		  email "ben@test.com"
		  password  "password"
		  password_confirmation "password"
		end

		factory :wrong_email_user do
		  email "ben.test.com"
		  password  "password"
		  password_confirmation "password"
		end

		factory :mismatching_password_user do
		  email "ben@test.com"
		  password  "password"
		  password_confirmation "notpassword"
		end
	end
end