class LinksController < ApplicationController
    # CONVENTION index show new edit create update destroy

    def index
        @links = Link.all
    end

    def show
        @link = Link.find(params[:id])
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
    end

    def destroy
    end

    private

    def link_params
        params.require(:link).permit(:title, :url)
    end

end
