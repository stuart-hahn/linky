class LinksController < ApplicationController
    # CONVENTION index show new edit create update destroy
    before_action :set_link, only: [:show, :edit, :update, :destroy]

    def index
        @links = Link.all
    end

    def show
    end

    def new
        @link = Link.new
    end

    def edit
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
        @link.destroy
        redirect_to root_path, notice: "Link successfully deleted"
    end

    private

    def link_params
        params.require(:link).permit(:title, :url)
    end

    def set_link
        @link = Link.find_by(id: params[:id])
    end

end
