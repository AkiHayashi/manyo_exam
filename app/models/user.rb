class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :user_name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
  before_destroy :ensure_admin_exist
  def ensure_admin_exist
    if User.where(admin: "true").count == 1 && self.admin?
      errors.add :base, '最低 1 人は管理ユーザを残す必要があります'
      throw :abort
    end
  end
  has_many :tasks, dependent: :destroy
end
