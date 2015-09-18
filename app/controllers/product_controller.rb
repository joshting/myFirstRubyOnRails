class ProductController < ApplicationController
  def upload
      open(params[:uploadurl], "rb") do |read_file|
        # save and read the file into read_file
        saved_file.write(read_file.read)
        # split the file by line and then by commas
        read_file.readlines.each do |line|
          CSV.parse do |line|
              # insert into database
          end
        end
      end
  end
end
