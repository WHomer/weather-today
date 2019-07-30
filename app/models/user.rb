class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validates :email, uniqueness: true

  before_create :create_api_key

  private

  def create_api_key
    self.api_key = SecureRandom.uuid
  end
end
