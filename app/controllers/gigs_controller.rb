class GigsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [ :new, :create, :edit, :destroy ]
  def new
    @gig = Gig.new
  end

  def create
    @gig = Gig.new(allowed_gig_params)
    if @gig.save
      flash[:notice] = "New gig added. #{total_msg}"
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

  def edit
    @gig = Gig.find(params[:id])
  end

  def update
    @gig = Gig.find(params[:id])
    if @gig.update(allowed_gig_params)
      redirect_to gig_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    Gig.find(params[:id]).destroy
    flash[:notice] = "gig deleted.  #{total_msg}"
    redirect_to schedule_path()
  end

  private

  def allowed_gig_params
    params.require(:gig).permit(:date, :name, :link, :note, :location, :published)
  end

  def total_msg
    "There are now #{Gig.count} in the schedule."
  end

  def require_admin
    unless current_user.admin?
      flash.alert = "You must be an admin user to access that page"
      redirect_to root_path
    end
  end
end
