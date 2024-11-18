class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy

  has_many :comments, dependent: :destroy

  before_create :set_admin
  
  def set_admin
    if User.where(admin: true).count.zero?
      self.admin = true
    else
      self.admin = false
    end
  end

  def admin?
    self.admin
  end

end
