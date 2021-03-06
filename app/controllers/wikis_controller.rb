class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    # @user = current_user
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Post was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
     @wiki = Wiki.find(params[:id])
     authorize @wiki
  end

 def update
   @wiki = Wiki.find(params[:id])
   if @wiki.update_attributes(wiki_params)
     flash[:notice] = "Post was updated."
     redirect_to @wiki
   else
     flash[:error] = "There was an error saving the post. Please try again."
     render :edit
   end
 end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    title = @wiki.title

    if @wiki.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

   def wiki_params
     params.require(:wiki).permit(:title, :body, :hide)
   end
end
