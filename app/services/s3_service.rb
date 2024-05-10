require 'aws-sdk-s3'

class AwsS3Service
  def initialize
    @s3_client = Aws::S3::Client.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION']
    )
    @bucket_name = ENV['S3_BUCKET_NAME']
  end

  def upload_file(file_path, object_key)
    File.open(file_path, 'rb') do |file|
      @s3_client.put_object(bucket: @bucket_name, key: object_key, body: file)
    end
  end

  def delete_file(object_key)
    @s3_client.delete_object(bucket: @bucket_name, key: object_key)
  end

  def get_file_url(object_key)
    @s3_client.get_object(bucket: @bucket_name, key: object_key).presigned_url(:get)
  end
end
