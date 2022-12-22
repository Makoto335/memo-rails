class MemosController < ApplicationController
  def index
    memos = Memo.all
    memos_array =
      memos.map do |memo|
        {
          id: memo.id,
          user_id: memo.user.id,
          name: memo.user.name,
          content: memo.content,
          email: memo.user.email,
          created_at: memo.created_at,
        }
      end

    render json: memos_array, status: 200
  end
end
