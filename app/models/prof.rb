class Prof < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, presence: true
  validates :surname, presence: true

  has_many :tempbooks
  has_many :books, dependent: :destroy

  before_save  :name
  before_save  :surname
  def name=(s)
    write_attribute(:name, s.to_s.titleize) # The to_s is in case you get nil/non-string
  end
  def surname=(s)
    write_attribute(:surname, s.to_s.titleize) # The to_s is in case you get nil/non-string
  end
end
