FactoryBot.define do
  module ControllerMacros
    def login_user
      # Before each test, create and login the user
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryBot.create(:user)
        user.confirm
        sign_in user
      end
    end

    def login_admin
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryBot.create(:user, role: "admin")
        user.confirm
        sign_in user
      end
    end
  end
end
