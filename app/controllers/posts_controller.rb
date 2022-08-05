class PostsController < ApplicationController
    before_action :set_q, only: [:index, :search]
    before_action :authenticate_user!
    def index
      if params[:search] == nil
          @posts= Post.all.page(params[:page]).per(2)
      elsif params[:search] == ''
          @posts= Post.all.page(params[:page]).per(3)
        else
          #部分検索
          @posts = Post.where("body LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(3)
      end
      
  end
    def new
        @post = Post.new
      end
    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        if post.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
    end
    end
    def show
        @post = Post.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end
    def edit
        @post = Post.find(params[:id])
    end
    def update
        post = Post.find(params[:id])
        if post.update(post_params)
          redirect_to :action => "show", :id => post.id
        else
          redirect_to :action => "new"
    end
    end  
    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
      end
      def search
        @results = @q.result
      end
      private
      def set_q
        @q = Post.ransack(params[:q])
      end
    def post_params
        params.require(:post).permit(:title,:media,:actor,:genre,:image,:overall,:level,:comment)
    end
end
