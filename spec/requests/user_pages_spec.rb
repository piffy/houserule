require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    before do
      login FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_selector('h1', text: 'Elenco utenti') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }
      let(:first_page) { User.paginate(page: 1) }
      let(:second_page) { User.paginate(page: 2) }

      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      it "should list the first page of users" do
        first_page.each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      describe "showing the second page" do
        before { visit users_path(page: 2) }

        it "should list the second page of users" do
          second_page.each do |user|
            page.should have_selector('li', text: user.name)
          end
        end
      end
    end

=begin
    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
=end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:admin) }
    let!(:m1) { FactoryGirl.create(:event, user: user, name: "Foo") }
    let!(:m2) { FactoryGirl.create(:event, user: user, name: "Bar") }

    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }

    describe "events" do
      it { should have_content(m1.name) }
      it { should have_content(m2.name) }
      it { should have_content(user.events.count) }
    end

=begin
    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end

=end

  end

  describe "signup page" do
    before { visit login_path }

    it { should have_selector('h1', text: 'Login') }
  end

  describe "registration" do

    before { visit new_user_path }

    let(:submit) { "Crea utente" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "error messages" do
        before { click_button submit }

        it { should have_selector('h1', text: 'Registrazione') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_name", with: "Example User"
        fill_in "user_email", with: "user@example.com"
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }

        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('div.alert.alert-success') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      login user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1', text: "Modifica di") }
      #it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      before do
        fill_in "user_name", with: new_name
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password
        click_button "Modifica"
      end


      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Logout', href: logout_path) }
      specify { user.reload.name.should == new_name }
    end
  end

=begin
  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_selector('title', text: full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_selector('title', text: full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
=end
end