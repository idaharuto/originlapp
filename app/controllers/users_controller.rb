class UsersController < ApplicationController
    def show
        @user = User.find(params[:id]) 
      
        user = User.find(params[:id])
        @posts = Post.all.page(params[:page]).per(2)
      
    end

end
