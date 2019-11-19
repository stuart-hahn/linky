class CommunitiesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]
    before_action :set_link, only: [:show, :edit, :update, :destroy]

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
        @communty = Community.new(community_params)

        if @community.save
            redirect_to community_path(@community), notice: "SUCCESS"
        else
            flash.now[:alert] = "FAILURE"
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
