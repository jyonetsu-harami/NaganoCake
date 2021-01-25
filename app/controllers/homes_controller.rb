class HomesController < ApplicationController
  def top
    # ランダム表示させるための記述
    @random = Product.order("RANDOM()").limit(1)
    @genres = Genre.where(is_invalid_flag: true).page(params[:page]).per(5)
  end

  def about
  end
  
  def admin
  end  
end
