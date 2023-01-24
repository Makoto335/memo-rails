class Api::MemosController < ApplicationController
  before_action :authenticate_user!, only: %w[create update destroy]

  def create
    user = User.find_by(email: request.headers['uid'])
    memo = user.memos.build(memo_params)
    if memo.save
      render json: {}, status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  def update
    memo = Memo.find(params[:id])
    if memo.update(memo_params)
      head :no_content
    else
      render json: memo.errors, status: :bad_request
    end
  end

  def destroy
    memo = Memo.find(params[:id])
    if memo.destroy
      head :no_content
    else
      render json: memo.errors, status: :bad_request
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :content)
  end
end
