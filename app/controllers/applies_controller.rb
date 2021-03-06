class AppliesController < ApplicationController
  before_action :set_apply, only: [:show, :edit, :update, :destroy]

  # GET /applies
  # GET /applies.json
  def index
    @applies = Apply.all
  end

  # GET /applies/1
  # GET /applies/1.json
  def show
  end

  # GET /applies/new
  def new
    @apply = Apply.new
  end

  # GET /applies/1/edit
  def edit
  end

  # POST /applies
  # POST /applies.json
  def create
    my_apply = Apply.find_by(user_id: current_user.id, recruit_id: params[:recruit_id])
    if my_apply.nil?
      @apply = Apply.new(user_id: current_user.id, recruit_id: params[:recruit_id])

      respond_to do |format|
        if @apply.save
          format.html { redirect_to @apply.recruit, notice: 'Apply was successfully created.' }
          format.json { render :show, status: :created, location: @apply }
        else
          format.html { render :new }
          format.json { render json: @apply.errors, status: :unprocessable_entity }
        end
      end
    elsif
      redirect_to my_apply.recruit, notice: 'すでにApplyは作られています'
    end
  end

  # PATCH/PUT /applies/1
  # PATCH/PUT /applies/1.json
  def update
    respond_to do |format|
      if @apply.update(apply_params)
        format.html { redirect_to @apply, notice: 'Apply was successfully updated.' }
        format.json { render :show, status: :ok, location: @apply }
      else
        format.html { render :edit }
        format.json { render json: @apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applies/1
  # DELETE /applies/1.json
  def destroy
    @apply.destroy
    respond_to do |format|
      format.html { redirect_to applies_url, notice: 'Apply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apply
      @apply = Apply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apply_params
      params.require(:apply).permit(:user_id, :recruit_id)
    end
end
