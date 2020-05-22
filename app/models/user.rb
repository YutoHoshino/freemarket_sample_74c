class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #  registrationの登録画面（STEP1）
  validates :nickname,                presence: true, length: {maximum: 20}, on: :validates_step1
  validates :last_name,               presence: true, on: :validates_step1
  validates :first_name,              presence: true, on: :validates_step1
  validates :last_name_kana,          presence: true, on: :validates_step1
  validates :first_name_kana,         presence: true, on: :validates_step1
  validates :birth_dd,                presence: true, on: :validates_step1
  validates :birth_mm,                presence: true, on: :validates_step1
  validates :birth_yy,                presence: true, on: :validates_step1

  #  sms_confirmationの登録画面（STEP2）
  validates :phone_number,            presence: true, uniqueness: true, on: :validates_step2


  has_one :address
  accepts_nested_attributes_for :address
  
end
