require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  before do
    @user = create(:user)
  end

  describe "After sign-in" do
    it "redirects to the dashboard_index_url page" do
      controller.after_sign_in_path_for(@user).should == dashboard_index_url
    end
  end

  describe "After sign up" do
    it "redirects to the dashboard_index_url page" do
      controller.after_sign_up_path_for(@user).should == dashboard_index_url
    end
  end

  describe "After sign out" do
    it "redirects to the login page" do
      controller.after_sign_out_path_for(@user).should == user_session_url
    end
  end
end
