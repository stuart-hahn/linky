class CommunitiesController < ApplicationController
    def index
        @communities = Community.most_links
        # @communities = Community.alphabetized
    end

    def show
        @community = Community.find_by(id: params[:id])
    end

    def new
        @community = Community.new
    end

    def edit
        @community = Community.find_by(id: params[:id])
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
        @community = Community.find_by(id: params[:id])
    end

    def destroy
        @community = Community.find_by(id: params[:id])
    end

    private

    def community_params
        params.require(:community).permit(:title)
    end
end
