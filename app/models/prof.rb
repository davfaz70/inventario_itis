class Prof < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

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

  def self.from_omniauth(access_token)
    data = access_token.info
    uid = access_token.uid
    provider = access_token.provider
    prof = Prof.where(email: data['email']).first_or_create do |prof|
      prof.name = data['first_name']
      prof.email = data['email']
      prof.surname = data['last_name']
      prof.password = Devise.friendly_token[0,20]
      prof.uid = uid
      prof.provider = provider
      prof.skip_confirmation!
    end
  prof
 end

end
