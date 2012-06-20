require 'spec_helper'

describe "Eventpages " do

  let!(:user) { FactoryGirl.create(:user) }




  describe "homepage" do

    it "works! (now write some real specs)" do
       get root_path
      response.status.should be(200)
    end
  end
end
