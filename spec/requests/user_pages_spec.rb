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
        let(:user) { FactoryGirl.create(:user) }
        let!(:e1) { FactoryGirl.create(:event, user: user, name: "Evento 1") }
        let!(:e2) { FactoryGirl.create(:event, user: user, name: "Evento 2") }

        before {
            login user
            visit edit_user_path(user)
            visit user_path(user)
        }


        describe "events" do
          it { should have_content(e1.name) }
          it { should have_content(e2.name) }
          it { should have_content(user.events.count) }
        end
      end
end