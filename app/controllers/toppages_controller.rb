class ToppagesController < ApplicationController
  before_action :require_login
  def index
    @microposts = my_post_and_follow_user_post.order(created_at: :desc).page(params[:page])
  end
  
  private
    def my_post_and_follow_user_post
      ids = [current_user.id]
      current_user.followings.each do |user| 
        ids.append(user.id)
      end
      Micropost.where(user_id: ids, reply_id: nil)
    end
end
