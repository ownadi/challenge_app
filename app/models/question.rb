class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :title, presence: true

  def has_accepted_answer?
    self.answers.where(accepted: true).any?
  end
end
