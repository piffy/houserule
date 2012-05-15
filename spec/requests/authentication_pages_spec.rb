require 'spec_helper'


describe "Authentication" do

  subject { page }

  describe "login page" do
    before { visit login_path }

    describe "with invalid information" do
      before { click_button "Login" }

      it { should have_selector('h1',    text: 'Login') }
      it { should have_selector('div.alert.alert-error', text: 'errata') }

      describe "after visiting another page" do
        before { visit "/" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Login"
      end

      it { should have_link('Profilo', href: user_path(user)) }
      it { should have_link('Modifica', href: edit_user_path(user)) }
      it { should have_link('Logout', href: logout_path) }
      it { should_not have_link('Login', href: login_path) }



    end



  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Events controller" do

        describe "getting to the new event page" do
          before { get new_event_path }
          specify { response.should redirect_to(login_path) }
        end

        describe "submitting to the create action" do
          before { post events_path }
          specify { response.should redirect_to(login_path) }
        end

        describe "submitting to the destroy action" do
          before do
            event = FactoryGirl.create(:event)
            delete event_path(event)
          end
          specify { response.should redirect_to(login_path) }
        end
      end


      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('h1', text: 'Login') }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('h1', text: 'Login') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(login_path) }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Login"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('h1', text: 'Modifica')
          end
        end
      end

    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { login user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('h1', text: "Modifica") }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end


  end

end

