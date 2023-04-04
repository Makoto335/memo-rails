class Api::V1::MemosController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %w[create update destroy]
  before_action :set_memo, only: %w[update destroy]

  def create
    memo = current_api_v1_user.memos.build(memo_params)
    if memo.save
      render json: {}, status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  def update
    if @memo.update(memo_params)
      head :no_content
    else
      render json: @memo.errors, status: :bad_request
    end
  end

  def destroy
    if @memo.destroy
      head :no_content
    else
      render json: @memo.errors, status: :bad_request
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :content)
  end

  def set_memo
    @memo = Memo.find(params[:id])
  end
end
