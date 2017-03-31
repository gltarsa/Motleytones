# frozen_string_literal: true
class GigsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  def show
    @gig = Gig.find(params[:id])
  end

  def index
    @gigs = Gig.all
  end

  def new
    @gig = Gig.new
  end

  def create
    @gig = Gig.new(allowed_gig_params)
    if gig.save
      flash[:notice] = I18n.t('gig.added', count: Gig.count)
      redirect_to gig
    else
      render :new
    end
  end

  def edit
  end

  def update
    if gig.update(allowed_gig_params)
      redirect_to gig_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    gig.destroy
    flash[:notice] = I18n.t('.gig.deleted', count: Gig.count)
    redirect_to gigs_path
  end

  private

  def gig
    @gig ||= Gig.find(params[:id])
  end
  helper_method :gig

  def allowed_gig_params
    params.require(:gig).permit(:date, :days, :name,
                                :note, :location, :published)
  end

  def require_admin
    return if current_user.admin?
    flash.alert = I18n.t('.must_be_admin')
    redirect_to root_path
  end
end
