class LinksController < ApplicationController
    # CONVENTION index show new edit create update destroy

    def index
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
            render :new, alert: "Failed to create link"
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
