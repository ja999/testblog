class Vote
	include Mongoid::Document
	field :value, type: Boolean, default: true
	belongs_to :user
	belongs_to :comment
end