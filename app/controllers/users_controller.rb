class UsersController < ApplicationController
  before_action :authenticate_user!, only: ['show']

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
           }, status: 200
  end
end
