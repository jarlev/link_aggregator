class Postvote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :post, uniqueness: { scope: :user }
  validates :user, uniqueness: { scope: :post }
  
end
