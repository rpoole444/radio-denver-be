require 'rails_helper'
require 'tempfile'

RSpec.describe AwsS3Service, vcr: true, type: :service do
  let(:bucket_name) { 'radio-denver' }
  let(:key) { 'file.txt' }

  subject { described_class.new(bucket_name) }

  describe '#upload_file' do
    it 'uploads a file to S3' do
      # Create a temporary file for testing
      Tempfile.open(['file', '.txt']) do |file|
        file.write('test data')
        file.rewind

        # Upload the temporary file
        expect(file).to be_truthy
        expect(subject.upload_file(file.path, key)).to_not be_nil
      end
    end
  end
end
