require 'spec_helper'

describe "User pages" do

      describe "edit" do
        let(:user) { FactoryGirl.create(:user) }
        before {
          login user
          visit edit_user_path(user)
          }


        describe "page" do
        "pending"
        end

        describe "with invalid information" do
          before { click_button "Modifica" }

          it { should have_content('error') }
        end
      end
end