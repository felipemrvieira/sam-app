require 'json'
require 'aws-sdk-s3' # Require the S3 SDK

# Configure AWS SDK for Ruby to use LocalStack
Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new('test', 'test'),
  endpoint: 'http://localhost:4566', # Ensure this is reachable from your script's environment
  force_path_style: true # Required for LocalStack compatibility
})

# Initialize the S3 client
s3_client = Aws::S3::Client.new

begin
  # List the buckets
  response = s3_client.list_buckets
  bucket_names = response.buckets.map(&:name) # Extract bucket names

  # Output the list of bucket names
  puts "List of S3 Buckets:"
  puts bucket_names
rescue Aws::S3::Errors::ServiceError => e
  puts "Error listing buckets: #{e.message}"
end
