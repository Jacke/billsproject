class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  def index
    @sites = Site.all
  end

  def show
  end

  def new
    @site = Site.new
  end

  def edit
  end

  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to sites_url, notice: 'Точка создана.' }
        format.json { render action: 'show', status: :created, location: @site }
      else
        format.html { render action: 'new' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to sites_url, notice: 'Точка обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private
    def set_site
      @site = Site.find(params[:id])
    end
    def site_params
      params.require(:site).permit(:name, :direction)
    end
end
