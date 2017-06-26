class WikisController < ApplicationController
  def show
    @wiki = Wiki.find(params[:id])
  end

  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user_id = current_user.id

    if @wiki.save
      flash[:notice] = "New wiki created!"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "An error occured while trying to create the wiki.  Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Entry was updated"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "An error occured while trying to update the wiki.  Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "#{@wiki.title} was removed from Motopedia"
      redirect_to wikis_path
    else
      flash[:notice] = "An error occured while attempting to delete the entry.  Please try agian"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit!
  end
end