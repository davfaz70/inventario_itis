class Technical < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable #:omniauthable, omniauth_providers: [:google_oauth2]

         validates :name, presence: true
         validates :surname, presence: true
         has_many :lab_technicals
         has_many :labs, through: :lab_technicals
         has_many :requests, dependent: :destroy
         has_many :reportings, dependent: :destroy

         before_save  :name
         before_save  :surname
        # default_scope -> {order(created_at: :desc)}
         def name=(s)
           write_attribute(:name, s.to_s.titleize) # The to_s is in case you get nil/non-string
         end
         def surname=(s)
           write_attribute(:surname, s.to_s.titleize) # The to_s is in case you get nil/non-string
         end

      #   def self.from_omniauth(access_token)
      #     data = access_token.info
      #     uid = access_token.uid
      #     provider = access_token.provider
      #     technical = Technical.where(email: data['email']).first
#
#
#           unless technical
#                technical = Technical.create(name: data['first_name'],
#                   email: data['email'],
#                   password: Devise.friendly_token[0,20],
#                   uid: uid,
#                   surname: data['last_name'],
#                   provider: provider
#                )
#                technical.skip_confirmation!
#                #AdminMailer.new_confirmated_technical(technical).deliver_later
#            end
#
#         technical
#
#        end
end
