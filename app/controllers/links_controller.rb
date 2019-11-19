class LinksController < ApplicationController
    # CONVENTION index show new edit create update destroy
    skip_before_action :authenticate_user!, only: [:index]
    before_action :set_link, only: [:show, :edit, :update, :destroy]

    def index
        @links = Link.hottest
    end

    def show
        @comment = @link.comments.build
    end

    def new
        @link = Link.new
    end

    def edit
        redirect_to root_path, notice: 'Not authorized to edit this link' unless current_user && current_user.owns_link?(@link)
    end

    def create
        @link = current_user.links.build(link_params)

        if @link.save
            redirect_to link_path(@link), notice: "Link successfully created"
        else
            flash.now[:alert] = "Failed to create link"
            render :new
        end
    end

    def update
        if @link.update(link_params)
            redirect_to link_path(@link), notice: "Link successfully updated"
        else
            flash.now[:alert] = "Failed to update link"
            render :edit
        end
    end

    def destroy
        if current_user.owns_link?(@link)
            @link.destroy
            redirect_to root_path, notice: "Link successfully deleted"
        else
            flash.now[:alert] = "You are not authorized to delete that link"
            redirect_back(fallback_location: root_path)
        end
    end

    ## CUSTOM ROUTES

    
    def downvote
        link = Link.find_by(id: params[:id])
        if current_user.downvoted?(link)
            current_user.remove_vote(link)
        elsif current_user.upvoted?(link)
            current_user.remove_vote(link)
            current_user.downvote(link)
        else
            current_user.downvote(link)
        end
        link.calc_hot_score
        redirect_to root_path
    end
    
    def upvote
        link = Link.find_by(id: params[:id])
        if current_user.upvoted?(link)
            current_user.remove_vote(link)
        elsif current_user.downvoted?(link)
            current_user.remove_vote(link)
            current_user.upvote(link)
        else
            current_user.upvote(link)
        end
        link.calc_hot_score
        redirect_to root_path
    end

    def newest
        @links = Link.newest
    end
    
    private

    def link_params
        params.require(:link).permit(:title, :url)
    end

    def set_link
        @link = Link.find_by(id: params[:id])
    end

end
