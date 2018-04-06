require 'rails_helper'

RSpec.describe TweetSearchController, type: :controller do

  let(:search_result) { [{id: 12345, content: "Hello world!"}, {id: 67890, content: "Hello from another world!"}] }
  before(:each)       { mock_twitter_api(search_result) }

  describe "GET #search" do

    before(:each) { get :search }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders view :search" do
      expect( subject ).to render_template(:search)
    end

    it "assigns no :result" do
      expect( assigns[:result] ).to be_nil
    end
  end

  describe "GET #search with params" do

    before(:each) { get :search, params: {query: "helloworld"} }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders view :search" do
      expect( subject ).to render_template(:search)
    end

    it "assigns :result" do
      expect( assigns[:result] ).to eq( search_result )
    end
  end

end
