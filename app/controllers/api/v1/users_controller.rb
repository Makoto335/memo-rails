class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!, only: ['show','update']

  def show
    user = current_api_v1_user
    memos = user.memos
    memos_array = formatted_memos(user.memos)
    avatar_url = user.avatar_url
    render json: {
             'user' => {
               'memos_array' => memos_array,
               'avatar_url' => avatar_url,
             },
           },
           status: 200
  end

  def update
    user = current_api_v1_user
    user.avatar.attach(params[:user][:avatar]) if user.avatar.blank?
    if user.update(user_params)
      render json: {}, status: 200
    else
      render json: {}, status: 500
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

  def formatted_memos(memos)
    memos.map do |memo|
      {
        id: memo.id,
        title: memo.title,
        content: memo.content,
        created_at: memo.created_at,
      }
    end
  end
end
