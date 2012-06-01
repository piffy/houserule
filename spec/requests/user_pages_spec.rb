require 'spec_helper'

describe "User pages" do

      describe "edit" do
        let(:user) { FactoryGirl.create(:user) }
        before {
          login user
          visit edit_user_path(user)
          }
      end

      describe "profile page" do

        before {
          let(:user) { FactoryGirl.create(:user) }
          let!(:e1) { FactoryGirl.create(:event, user: user, name: "Evento 1") }
          let!(:e2) { FactoryGirl.create(:event, user: user, name: "Evento 2") }

          login user
        }


        describe "Show User" do
          visit show_user_path(user)
          it { should have_content(user.name) }
          it { should have_content(user.email) }
          it { should have_content(user.events.count) }
          it { should have_content(e1.name) }
          it { should have_content(e2.name) }
        end


        describe "Edit User" do
          visit edit_user_path(user)
          it { should have_content(user.name) }
          it { should have_content(user.email) }
          it { should have_content(user.events.count) }
          it { should have_content(e1.name) }
          it { should have_content(e2.name) }
        end

=begin
        describe "events" do
          it { should have_content(e1.name) }
          it { should have_content(e2.name) }
          it { should have_content(user.events.count) }
        end
=end
      end
end