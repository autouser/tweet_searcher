class TweetSearch
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations

  attr_accessor :query, :result_type

  RESULT_TYPE_VALUES = [ "popular", "recent", "mixed" ]

  validates_presence_of  :query
  validates_inclusion_of :result_type, in: RESULT_TYPE_VALUES, message: "must be #{ RESULT_TYPE_VALUES.map{|t| "'#{t}'"}.join(", ") }"

  def initialize(args={})
    self.query       = args[:query]
    self.result_type = args[:result_type].blank? ? "popular" : args[:result_type]
  end
end