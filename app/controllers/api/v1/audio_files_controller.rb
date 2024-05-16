class Api::V1::AudioFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_audio_file, only: [:show, :update, :destroy]

  # GET /audio_files
  def index
    @audio_files = current_user.audio_files
    render json: @audio_files
  end

  # GET /audio_files/1
  def show
    render json: @audio_file
  end

  # POST /audio_files
  def create
    @audio_file = current_user.audio_files.build(audio_file_params)

    if @audio_file.save
      render json: @audio_file, status: :created
    else
      render json: { errors: @audio_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /audio_files/1
  def update
    if @audio_file.update(audio_file_params)
      render json: @audio_file
    else
      render json: { errors: @audio_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /audio_files/1
  def destroy
    @audio_file.destroy
    head :no_content
  end

  private

  def set_audio_file
    @audio_file = current_user.audio_files.find(params[:id])
  end

  def audio_file_params
    params.require(:audio_file).permit(:name, :size, :s3_key)
  end
end
