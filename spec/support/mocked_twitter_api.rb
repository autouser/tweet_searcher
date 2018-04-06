module MockedTwitterApi

  def mock_twitter_api(search_result)
    allow_any_instance_of( Twitter::REST::Client ).to receive(:search) do
      search_result.map do |r|
        double("tweet", attrs: {id_str: r[:id], text: r[:content]})
      end
    end
  end
end