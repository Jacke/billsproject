class ShiftRowsController < ApplicationController
  before_action :set_row, only:  [:show, :edit, :update, :destroy]
  # # after_action :balnce_cloning, only: [:create, :destroy]
  def index; @rows = ShiftRow.all; end
  def show; end
  def edit; end

  def new
    @row = ShiftRow.new
  end
  
  def create
    @row = ShiftRow.new(shift_row_params)
    respond_to do |format|
      if @row.save
        balnce_cloning("create")
        format.html { redirect_to shift_rows_path, notice: 'Row was successfully created.' }
      else
        format.html { render action: 'new', notice: @row.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @row.update(shift_row_params)
        format.html { redirect_to shift_rows_path, notice: 'Row was successfully updated.' }
      else
        format.html { render action: 'edit', notice: @row.errors }
      end
    end
  end
  def destroy
    balnce_cloning("destroy")
    @row.destroy
    respond_to do |format|
      format.html { redirect_to shift_rows_url }
      format.json { head :no_content }
    end
  end

  private
    def balnce_cloning(act)
      if @row.row_type == 1
         ShiftRow.new(title: @row.title, row_type: 6, site_id: @row.site_id).save if act == "create"
         ShiftRow.find_by_title_and_row_type(@row.title, 6).destroy if act == "destroy"         
      end
    end
    def set_row; @row = ShiftRow.find(params[:id]); end
    def shift_row_params; params[:shift_row]; end
end
