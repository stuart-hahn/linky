class CommunitiesController < ApplicationController
    before_action :set_community, only: [:show, :edit, :update, :destroy]

    def index
        @communities = Community.most_links
        # @communities = Community.alphabetized
    end

    def show
        redirect_to community_links_path(@community)
    end

    def new
        @community = Community.new
    end

    def edit
    end

    def create
        @community = Community.new(community_params)

        if @community.save
            redirect_to community_path(@community), notice: "Successfully created community"
        else
            flash.now[:alert] = "Failed to create community"
            render :new
        end
    end

    def update
        if @community.update(community_params)
            redirect_to community_path(@community)
        else
            render :edit
        end
    end

    def destroy
        @community.destroy
        redirect_to root_path
    end

    private

    def community_params
        params.require(:community).permit(:title)
    end

    def set_community
        @community = Community.find_by(id: params[:id])
    end
end
