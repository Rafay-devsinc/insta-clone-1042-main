# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true
  validates :password, confirmation: true
  validates :password, confirmation: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # Setup accessible (or protected) attributes for your model
  validates :avatar, presence: true

  # :destroy causes all the associated objects to be deleted from the database with validations
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy
  # For relationship model[Handels people we follow]
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Relationship',
                            dependent: :destroy
  # This access the user through the relationship object.
  has_many :followees, through: :followed_users, dependent: :destroy
  # For relationship model [Handels people following us]
  has_many :following_users, foreign_key: :followee_id, class_name: 'Relationship',
                             dependent: :destroy
  # This access the user through the relationship object.
  has_many :followers, through: :following_users, dependent: :destroy

  # for requests [to people we do follow request]
  has_many :requested_users, foreign_key: :requester_id, class_name: 'Request',
                             dependent: :destroy
  # This access the user through the request object.
  has_many :requestees, through: :requested_users, dependent: :destroy

  # for other people requests [current user
  has_many :requesting_users, foreign_key: :requestee_id, class_name: 'Request',
                              dependent: :destroy
  # This access the user through the request object.
  has_many :requesters, through: :requesting_users, dependent: :destroy

  has_one_attached :avatar

  scope :name_search, ->(name) { where('name ILIKE ?', "%#{name}%") }

  def public?
    User.find_by(id: id).is_public
  end
end
