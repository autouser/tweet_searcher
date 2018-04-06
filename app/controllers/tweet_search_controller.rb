class TweetSearchController < ApplicationController
  def search
    @tweet_search = TweetSearch.new
    @result       = []
    
    if params[:tweet_search]
      @tweet_search.query       = params[:tweet_search][:query]
      @tweet_search.result_type = params[:tweet_search][:result_type]
      
      if @tweet_search.valid?
        @result = @tweet_search.search
      end
    
    end
  end
end
