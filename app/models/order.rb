class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user

  # validates :transaction_id,  presence: true, uniqueness: { case_sensitive: false }
  default_scope{ order("created_at desc")}

end
