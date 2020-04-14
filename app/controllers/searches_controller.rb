class SearchesController < ApplicationController
    def index 
        if params[:search].nil?
            @microposts = Micropost.all.page(params[:page])
        else
            @microposts = Micropost.where(['content LIKE ?' ,"%#{params[:search]}%"]).page(params[:page])
        end
    end
end
