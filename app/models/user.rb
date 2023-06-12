class User < ApplicationRecord
  validates :email, 
            presence: true, 
            uniqueness: { case_sensitive: false}
  validates_presence_of :password

  has_secure_password
end
