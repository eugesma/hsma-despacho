class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, uniqueness: true

  devise :rememberable, :trackable

  devise :database_authenticatable, :authentication_keys => [:username]

  has_many :entry_notes, foreign_key: "author_id"
  has_many :out_notes, foreign_key: "author_id"
end
