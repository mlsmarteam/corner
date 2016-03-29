class Field < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :team_player, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  has_many :events
end
