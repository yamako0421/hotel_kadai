class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, length: {maximum: 20}
  validates :email, presence: true
  
  # Update user without requiring current password
  def update_without_password(params, *options)
    params.delete(:password)
    params.delete(:password_confirmation)

    result = update(params, *options)
    clean_up_passwords
    result
  end

  # Method for conditional password validation
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  validates :password, presence: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  has_many :rooms
  has_one_attached :avatar
  has_many :reservations
 


end
