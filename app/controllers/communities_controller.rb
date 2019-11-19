class CommunitiesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]
    before_action :set_link, only: [:show, :edit, :update, :destroy]

    def index
        @communitites = Community.all
    end

    def show

    end

    def new

    end

    def edit

    end

    def create

    end

    def update

    end

    def destroy

    end
end
