class CommentsController < ApplicationController
    def index
        if params[:link_id] && @link = Link.find_by(id: params[:link_id])
            @comments = @link.comments
        else
            @comments = Comment.newest
        end
    end

    def new
        @link = Link.find_by(id: params[:link_id])
        @comment = @link.comments.build
    end

    def create
        @link = Link.find_by(id: params[:link_id])
        @comment = @link.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save
            redirect_to link_path(@link), notice: "SUCCESS"
        else
            flash.now[:alert] = "FAILURE"
            render :new
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
