class Product < ActiveRecord::Base
  validates:productid, presence:true
  validates:category, presence:true
  validates:product_name, presence:true
  validates:price, numericality: {greater_than: 0}

  def self.import(url)
    require 'open-uri'
    require 'csv'
    puts "product url: " + url
    csv_text  = open(url) {|file| file.read }
    csv = CSV.parse(csv_text, :headers => true)
    update_count = 0
    create_count = 0
    csv.each do |row|
      row_hash = row.to_hash
      # check if the product exists in the DB based on the ProductID
      p = Product.where(productid:row_hash["ProductID"])
      # if product exists, update the record
      if p.size > 0
        puts "PRODUCT ID " + row_hash["ProductID"] + " FOUND. UPDATE RECORD"
        _p = Product.find(p.first.id)
        _p.attributes = {
                          category: row_hash["Category"],
                          product_name: row_hash["Product Name"],
                          price: row_hash["Price"]
                        }
        _p.save
        update_count += 1
      # if the product does not exists, create new record
      else
        puts "PRODUCT ID " + row_hash["ProductID"].to_s + " NOT FOUND.  CREATE NEW"
        Product.create(
                        productid: row_hash["ProductID"],
                        category: row_hash["Category"],
                        product_name: row_hash["Product Name"],
                        price: row_hash["Price"],
                      )
        create_count += 1
      end
    end
    #flash[:create_count] = create_count
    #flash[:update_count] = update_count
    return {"create_count" => create_count, "update_count" => update_count}
  end

  def self.category(category,page)
    return Product.where(category:category).paginate(:page => page, :per_page => 5)
  end

end
