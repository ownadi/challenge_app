class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  # :recoverable, :rememberable and :trackable
  devise :database_authenticatable, :registerable, :validatable

  has_many :questions
  has_many :answers
  has_many :likes

  has_attached_file :avatar, :styles => { :avatars => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  after_save :check_if_deserved

  def to_s
    return name if self.name.present?
    email
  end

  def author_of?(content)
    content.user == self
  end

  def can_create_question?
    self.points >= 10
  end

  def likes?(answer)
    self.likes.where(answer_id: answer.id)
  end

  def take_question_price
    self.update(points: self.points - 10)
  end

  def add_points(count)
    self.update(points: self.points + count)
  end

  private

    def check_if_deserved
      unless self.deserved #am i already deserved? if no lets check
        self.update(deserved: true) if self.points >= 1000 #yes i am :) gimme my badge!
      end
    end
end
