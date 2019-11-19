class CommentsController < ApplicationController

    def index
        if params[:link_id] && @link = Link.find_by(id: params[:link_id])
            @comments = @link.comments
        else
            flash.now[:alert] = "That link doesn't exist" if params[:link_id]
            @comments = Comment.newest
        end
    end

    def new
        if params[:link_id] && @link = Link.find_by(id: params[:link_id])
            @comment = @link.comments.build
        elsif params[:link_id]
            flash[:alert] = "That link doesn't exist"
            redirect_to comments_path
        else
            render :new
        end
    end

    def create
        @link = Link.find_by(id: params[:link_id])
        @comment = @link.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
            redirect_to link_path(@link)
        else
            flash[:alert] = @comment.errors.full_messages.to_sentence
            redirect_back(fallback_location: root_path)
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
