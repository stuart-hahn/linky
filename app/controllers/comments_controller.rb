class CommentsController < ApplicationController
    def index
        if params[:link_id] && @link = Link.find_by(id: params[:link_id])
            @comments = @link.comments.newest
        else
            flash.now[:alert] = "That link doesn't exist" if params[:link_id]
            @comments = Comment.newest
        end
    end

    def new
        if params[:link_id] && @link = Link.find_by(id: params[:link_id])
            @comment = @link.comments.build
        else
            flash[:alert] = "That link doesn't exist" if params[:link_id]
            redirect_back(fallback_location: root_path)
        end
    end

    def edit
        @comment = Comment.find_by(id: params[:id])
    end

    def create
        @link = Link.find_by(id: params[:link_id])
        @comment = @link.comments.build(comment_params)
        if @comment.save!
            redirect_to link_path(@link), notice: "Successfully created comment"
        else
            flash.now[:alert] = "Failed to save comment"
            render :new
        end
    end
    
    def update
        @link = Link.find_by(id: params[:link_id])
        @comment = Comment.find_by(id: params[:id])
        if @comment.update(comment_params)
            redirect_to link_path(@link), notice: "Successfully edited comment"
        else
            flash.now[:alert] = "Failed to edit comment"
            render :edit
        end
    end

    def destroy
        @comment = comment.find_by(id: params[:id])
        @comment.destroy
        redirect_to root_path
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

end
