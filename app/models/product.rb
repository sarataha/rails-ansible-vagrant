class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :comments

  has_attached_file :product_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "nigerian-jollof-rice.jpg"
  validates_attachment_content_type :product_image, :content_type => /\Aimage\/.*\Z/
end
