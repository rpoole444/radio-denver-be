class AwsS3Service
  def initialize(bucket_name)
    access_key_id = ENV['AWS_ACCESS_KEY_ID']
    secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    region = ENV['AWS_REGION']

    @s3_client = Aws::S3::Client.new(
      access_key_id: access_key_id,
      secret_access_key: secret_access_key,
      region: region
    )
    @bucket_name = bucket_name
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
    @s3_client.get_object(bucket: @bucket_name, key: object_key)#.presigned_url(:get)
  end
end
