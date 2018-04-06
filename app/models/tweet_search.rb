class TweetSearch
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  extend ActiveModel::Naming
  include ActiveModel::Conversion
 
  attr_accessor :query, :result_type
  attr_writer   :twitter_api

  RESULT_TYPE_VALUES = [ "popular", "recent", "mixed" ]

  validates_presence_of  :query
  validates_inclusion_of :result_type, in: RESULT_TYPE_VALUES, message: "must be #{ RESULT_TYPE_VALUES.map{|t| "'#{t}'"}.join(", ") }"

  def initialize(args={})
    self.query       = args[:query]
    self.result_type = args[:result_type].blank? ? "popular" : args[:result_type]
    self.twitter_api = nil
  end

  def twitter_api
    # raise "Twitter keys are empty" unless 
    if @twitter_api.nil?
      self.twitter_api = Twitter::REST::Client.new(
        consumer_key:    Rails.application.secrets[:twitter_consumer_key],
        consumer_secret: Rails.application.secrets[:twitter_consumer_secret]
      )
    end
    @twitter_api
  end

  def search
    twitter_api.search(query, result_type: result_type, count: 10).take(10).map do |t|
      {
        id:      t.attrs[:id_str],
        content: t.attrs[:text]
      }
    end
  rescue Exception => e
    Rails.logger.error "Twitter API request Error: #{e}"
    return []
  end

  def persisted?
    false
  end
 
  def id
    nil
  end

end