class MemosController < ApplicationController
  before_action :authenticate_user!, only: ["index","create"]
  
  def create
    @memo = current_user.memos.build(memo_params)
    # @memo.image.attach(params[:memo][:image])
    if @memo.save
    else
      @feed_items = current_user.feed.page(params[:page])
      render 'static_pages/home'
    end
  end

  private

  def memo_params
    # params.require(:memo).permit(:title, :content)
    params.permit(:title, :content)
  end
end
