class GigsController < ApplicationController
  def new
    @gig = Gig.new
  end

  def create
    @gig = Gig.new(allowed_gig_params)
    if @gig.save
      flash[:notice] = "New gig added, there are now #{Gig.count} in the database."
      #set_flash_message :notice, :new_gig_added, count: Gig.count
      redirect_to @gig
    else
      render :new
    end
  end

  def show
    @gig = Gig.find(params[:id])
  end

  def index
    @gigs = Gig.all
  end

  private

  def allowed_gig_params
    params.require(:gig).permit(:date, :name, :link, :note, :location, :published)
  end

end
