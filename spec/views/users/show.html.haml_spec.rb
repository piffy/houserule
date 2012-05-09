require 'spec_helper'

describe "users/show.html.haml" do

  let(:user) { FactoryGirl.create(:user) }
  before { login user }

  it { should have_selector('h1', text: "Informazioni") }
  it { should have_link('Profile',  href: user_path(user)) }
  it { should have_link('Settings', href: edit_user_path(user)) }
  it { should have_link('Sign out', href: signout_path) }
  it { should_not have_link('Sign in', href: signin_path) }

end


