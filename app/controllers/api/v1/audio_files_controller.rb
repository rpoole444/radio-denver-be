class Api::V1::AudioFilesController < ApplicationController
  before_action :authenticate_request
  before_action :set_audio_file, only: [:show, :update, :destroy]

  def index
    @audio_files = @current_user.audio_files
    render json: @audio_files
  end

  def show
    render json: @audio_file
  end

  def create
    @audio_file = @current_user.audio_files.build(audio_file_params)
    if params[:audio_file][:file]
      s3_key = upload_to_s3(params[:audio_file][:file])
      @audio_file.s3_key = s3_key
    end

    if @audio_file.save
      render json: @audio_file, status: :created
    else
      render json: { errors: @audio_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if params[:audio_file][:file]
      s3_key = upload_to_s3(params[:audio_file][:file])
      @audio_file.s3_key = s3_key
    end

    if @audio_file.update(audio_file_params)
      render json: @audio_file
    else
      render json: { errors: @audio_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    delete_from_s3(@audio_file.s3_key)
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
    params.require(:audio_file).permit(:name, :size)
  end

  def upload_to_s3(file)
    obj = S3_BUCKET.object("audio_files/#{SecureRandom.uuid}/#{file.original_filename}")
    obj.upload_file(file.path)  # Removed acl: 'public-read'
    obj.public_url
  end

  def delete_from_s3(s3_key)
    obj = S3_BUCKET.object(s3_key)
    obj.delete
  end
end
