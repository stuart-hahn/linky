class CommunitiesController < ApplicationController
    def index
        @communities = Community.all
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
        @community = current_user.communities.build(community_params)

        if @community.save
            redirect_to communities_path, notice: "SUCCESS"
        else
            flash.now[:alert] = "FAILURE"
            render :new
        end
    end

    def update
        @community = Community.find_by(id: params[:id])

        if @community.update(community_params)
            redirect_to community_path(@community), notice: "SUCCESSFULLY EDITED"
        else
            flash.now[:alert] = "FAILURE"
            render :edit
        end
    end

    def destroy
        @community = Community.find_by(id: params[:id])
    end

    private

    def community_params
        params.require(:community).permit(:title)
    end
end
