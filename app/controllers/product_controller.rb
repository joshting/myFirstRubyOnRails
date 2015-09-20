class ProductController < ApplicationController
  def list
    @category=params[:category].to_s
  end

  def show
    #@product = Product.find(params[:productid])
  end

  def upload_products
    import_result = Product.import(params[:file_url].to_s)
    flash[:create_count] = import_result["create_count"]
    flash[:update_count] = import_result["update_count"]
  end

  def category
    @products = Product.category(params[:cat], params[:page])
  end

  def create
    redirect_to(update_products_path)
    #redirect_to :controller => 'thing', :action => 'edit', :id => 3, :something => 'else'
  end

  def destroy

  end

  def index

  end

end
