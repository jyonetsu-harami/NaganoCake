class HomesController < ApplicationController
  def top
    # ランダム表示させるための記述
    @random = Product.order("RANDOM()").limit(4)
    @genres = Genre.where(is_invalid_flag: true).page(params[:page]).per(5)
    @product = Product.all
  end

  def about
  end
end
