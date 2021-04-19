require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :controller do

    describe "GET show" do
        it "has a 200 status code" do
            get :show, params: { id: "octokit" }
          expect(response.status).to eq(200)
        end
      end

end

