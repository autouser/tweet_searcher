class TweetSearchController < ApplicationController
  def search
    if params[:query].present?
      @tweet_search = TweetSearch.new(query: params[:query], result_type: params[:result_type])
      if @tweet_search.valid?
        @result = @tweet_search.search
      end
    end
  end
end
