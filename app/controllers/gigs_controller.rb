# frozen_string_literal: true

class GigsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:show, :index, :new, :create, :edit, :copy, :update, :destroy]

  def show
    @gig = Gig.find(params[:id])
  end

  def index
    @active_gigs = Gig.active.ascending
    @expired_gigs = Gig.expired.descending
    @unique_gig_names = regularize_names(Gig.all)
  end

  def new
    @gig = Gig.new
  end

  def create
    @gig = Gig.new(allowed_gig_params)
    return render :new unless gig.save

    flash[:notice] = I18n.t('gig.added', count: Gig.count)
    redirect_to gig
  end

  def edit
  end

  def copy
    @gig = Gig.find(params[:id])
    @gig.published = false
    render :new
  end

  def update
    return redirect_to gig_path(params[:id]) if gig.update(allowed_gig_params)

    render :edit
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

  def regularize_names(gigs)
    front_bracket = /^\[/
    rest_of_bracket = /].*$/
    digit_words = /\d+ */

    gigs = gigs.filter { |g| !g.name.match?(/cancelled|canceled/i) }.each do |g|
      g.name = g.name.gsub(front_bracket, "").gsub(rest_of_bracket, "").gsub(digit_words, "")
    end
    gigs.sort_by(&:name).uniq { |g| g.name.downcase }.sort_by { |g| g.name.downcase }
  end

  def require_admin
    return if current_user.admin?

    flash.alert = I18n.t('.must_be_admin')
    redirect_to root_path
  end
end
