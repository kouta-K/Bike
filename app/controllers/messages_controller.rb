class MessagesController < ApplicationController
    before_action :group_member, only: [:create]
    before_action :user_message, only: [:destroy]
    before_action :require_login
    def create 
        @message = current_user.send_messages.build(content: params[:message][:content], image: params[:message][:image], group_id: @group.id)
        if @message.save
            flash[:success] = "送信完了"
            redirect_to @group
        else
            flash[:danger] = "送信失敗"
            redirect_to @group
        end
    end
    
    def destroy
        if @message.destroy
            flash[:success] = "メッセージを削除しました"
            redirect_back(fallback_location: root_url)
        else
            flash[:danger] = "削除に失敗しました"
            redirect_back(fallback_location: root_url)
        end 
    end 
    
    private
        def user_message
            @message = Message.find(params[:id])
            unless current_user.send_messages.include?(@message)
                redirect_to root_url
            end
        end

end