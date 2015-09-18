class Product < ActiveRecord::Base
  validates:productid, presence:true
  validates:category, presence:true
  validates:product_name, presence:true
  validates:price, numericality: {greater_than: 0}
end
