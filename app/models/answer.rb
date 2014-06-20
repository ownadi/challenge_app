class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :likes

  validates :contents, presence: true
end
