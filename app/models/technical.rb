class Technical < ApplicationRecord
    validates :name, presence: true
    validates :surname, presence: true
    
    validates :email, presence: true, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
    before_save   :downcase_email
    def downcase_email
       self.email = email.downcase
     end
end
