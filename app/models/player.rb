class Player < ActiveRecord::Base
  belongs_to :user
  has_many :pcs

  validates :name, presence: true
  

end
