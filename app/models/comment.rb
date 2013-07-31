class Comment
  include Mongoid::Document
  field :body, type: String
  field :title, type: String
  field :opinion, type: Integer
  field :abusive, type: Boolean, default: false
  belongs_to :post
  belongs_to :user
  has_many :votes
end