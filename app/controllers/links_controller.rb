class LinksController < ApplicationController
    # CONVENTION index show new edit create update destroy
    skip_before_action :authenticate_user!, only: [:index]

    def index
        @links = Link.hottest
    end

    def show
        @link = Link.find_by(id: params[:id])
    end

    def new
        @link = current_user.links.build
    end

    def edit
        @link = current_user.links.update(link_params)
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

end
