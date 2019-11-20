class CommentsController < ApplicationController
    def index
        if params[:link_id] && @link = Link.find_by(id: params[:link_id])
            @comments = @link.comments.newest
        else
            @comments = Comment.newest
        end
    end

    def create
        @link = Link.find_by(id: params[:link_id])
        @comment = @link.comments.build(link_params)
        if @comment.save
            redirect_to link_path(@link), notice: "Successfully posted comment"
        else
            flash[:alert] = "Failed to save comment"
            redirect_back(fallback_location: root_path)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

end
