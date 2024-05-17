class Api::V1::AudioFilesController < ApplicationController
  before_action :authenticate_request
  before_action :set_audio_file, only: [:show, :update, :destroy]

  def index
    @audio_files = @current_user.audio_files
    render json: @audio_files
  end

  def show
    set_audio_file
    render json: @audio_file
  end

  def create
    @audio_file = @current_user.audio_files.build(audio_file_params)
    if @audio_file.save
      render json: @audio_file, status: :created
    else
      render json: { errors: @audio_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    set_audio_file
    if @audio_file.update(audio_file_params)
      render json: @audio_file
    else
      render json: { errors: @audio_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    set_audio_file
    @audio_file.destroy
    head :no_content
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequestService.new(request.headers).result
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end

  def set_audio_file
    @audio_file = @current_user.audio_files.find(params[:id])
  end

  def audio_file_params
    params.require(:audio_file).permit(:name, :size, :s3_key)
  end
end
