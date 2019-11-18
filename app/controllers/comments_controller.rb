class CommentsController < ApplicationController

    def new
        @link = Link.find_by(id: params[:link_id])
        @comment = @link.comments.build
        redirect_to link_path(@link)
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
