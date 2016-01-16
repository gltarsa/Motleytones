class GigsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [ :manage, :new, :create, :edit, :destroy ]
  before_action :set_gig,       only: [ :show, :edit, :update, :destroy ]

  def new
    @gig = Gig.new
  end

  def create
    @gig = Gig.new(allowed_gig_params)
    if @gig.save
      flash[:notice] = "New gig added. #{total_msg}"
      redirect_to @gig
    else
      render :new
    end
  end

  def show
  end

  def manage
    @gigs = Gig.all
  end

  def edit
  end

  def update
    if @gig.update(allowed_gig_params)
      redirect_to gig_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @gig.destroy
    flash[:notice] = "gig deleted.  #{total_msg}"
    redirect_to manage_gigs_path()
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end

  def allowed_gig_params
    params.require(:gig).permit(:date, :days, :name, :note, :location, :published)
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
