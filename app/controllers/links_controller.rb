class LinksController < ApplicationController
    # CONVENTION index show new edit create update destroy
    skip_before_action :authenticate_user!, only: [:index]

    def index
        if params[:community_id] && @community = Community.find_by(id: params[:community_id])
            @links = @community.links.hottest
        else
            flash.now[:alert] = "That community doesn't exist" if params[:community_id]
            @links = Link.hottest
        end
    end

    def show
        @link = Link.find_by(id: params[:id])
    end

    def new
        if params[:community_id] && @community = Community.find_by(id: params[:community_id])
            @link = @community.links.build
        else
            flash.now[:alert] = "That community doesn't exist" if params[:community_id]
            @link = Link.new
        end
    end

    def edit
        @link = Link.find_by(id: params[:id])
    end

    def create
        @link = current_user.links.build(link_params)
        if  @link.save
            redirect_to link_path(@link), notice: "Successfully created link"
        else
            flash.now[:alert] = "Failed to save link"
            render :new
        end
    end
    
    def update
        @link = Link.find_by(id: params[:id])
        if @link.update(link_params)
            redirect_to link_path(@link), notice: "Successfully edited link"
        else
            flash.now[:alert] = "Failed to edit link"
            render :edit
        end
    end

    def destroy
        @link = Link.find_by(id: params[:id])
        @link.destroy
        redirect_to root_path
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
        redirect_back(fallback_location: root_path)
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
        redirect_back(fallback_location: root_path)
    end

    def newest
        @links = Link.newest
    end
    
    private

    def link_params
        params.require(:link).permit(:title, :url, :community_title, :community_id)
    end

end
