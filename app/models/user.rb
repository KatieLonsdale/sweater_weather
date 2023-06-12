class User < ApplicationRecord
  before_validation :create_api_key

  validates :email, 
            presence: true, 
            uniqueness: { case_sensitive: false}
  # validates :api_key, 
  #           presence: true, 
  #           uniqueness: true
  validates_presence_of :password

  has_secure_password

  private

  def create_api_key
    self.api_key = SecureRandom.base64
  end
end
