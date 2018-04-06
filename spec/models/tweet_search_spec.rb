require 'rails_helper'

RSpec.describe TweetSearch, type: :model do
  context "#initialize" do
    context "with correct attributes" do
      let(:tweet_search) { described_class.new(query: "helloworld", result_type: "popular") }
      
      it "is valid" do
        expect( tweet_search ).to be_valid
      end
      it "sets :query" do
        expect( tweet_search.query ).to eq("helloworld")
      end

      it "sets :result_type" do
        expect( tweet_search.result_type ).to eq("popular")
      end
    end

    context "with empty :query" do
      it "is invalid" do
        expect( described_class.new(result_type: "popular") ).not_to be_valid
      end
    end
    context "with empty :result_type" do
      let(:tweet_search) { described_class.new(query: "helloworld") }

      it "is valid" do
        expect( tweet_search ).to be_valid
      end
      it "sets result_type to 'popular'" do
        expect( tweet_search.result_type ).to eq('popular')
      end
    end
    context "with unknown :result_type" do
      let(:tweet_search) { described_class.new(query: "helloworld", result_type: "wrong_type") }
      
      it "is invalid" do
        expect( tweet_search ).not_to be_valid
        expect( tweet_search.errors.size ).to eq(1)
        expect( tweet_search.errors[:result_type] ).to match_array("must be 'popular', 'recent', 'mixed'")
      end
    end
  end

  context "#search" do
    it "returns search results"
  end
end
