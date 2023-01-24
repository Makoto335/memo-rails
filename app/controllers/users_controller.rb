class UsersController < ApplicationController
  before_action :authenticate_user!, only: ["show"]

  def show
    user = User.find_by(email: request.headers["uid"])
    memos = user.memos
    memos_array =
      memos.map do |memo|
        {
          id:memo.id,
          title:memo.title,
          content: memo.content,
          created_at: memo.created_at,
        }
      end

    render json: memos_array, status: 200
  end
end
