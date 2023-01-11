class MemosController < ApplicationController
  before_action :authenticate_user!, only: ["create"]
  
  def create
    user = User.find_by(email: request.headers["uid"])
    memo = user.memos.build(memo_params)
    if memo.save
      render json: {}, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :content)
  end
end
