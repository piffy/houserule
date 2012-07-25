require 'spec_helper'

describe PasswordResetsController do

  let!(:user) { FactoryGirl.create(:user) }

  describe "reset password" do

    it "should show the form" do
      visit new_password_reset_path
      response.status.should be(200)
    end

    it "should redirect to homepage if logged in" do
      login FactoryGirl.create(:user)
      visit new_password_reset_path
      assert_equal root_path, URI.parse(current_url).path
    end

    it "should show the reset password form" do
      visit user.reset_password_url
      response.status.should be(200)
    end

    it "should redirect to homepage if token is wrong" do
      url="http://"+ApplicationController.hostname+"/password_resets/WRONG_TOKEN/edit"
      visit url
      assert_equal root_path, URI.parse(current_url).path
    end

  end

end
