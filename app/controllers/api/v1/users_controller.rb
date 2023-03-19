class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!, only: ['show','update']

  def show
    user = User.find_by(email: request.headers['uid'])
    memos = user.memos
    memos_array =
      memos.map do |memo|
        {
          id: memo.id,
          title: memo.title,
          content: memo.content,
          created_at: memo.created_at,
        }
      end
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
    user = User.find_by(email: request.headers['uid'])
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
end
