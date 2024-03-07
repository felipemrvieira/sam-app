require 'json'
require 'aws-sdk-s3' # Require the S3 SDK

def lambda_handler(event:, context:)

  if event.dig('Records', 0, 'eventName')&.start_with?('ObjectCreated:')
    # Extrai informações do evento
    bucket_name = event.dig('Records', 0, 's3', 'bucket', 'name')
    object_key = event.dig('Records', 0, 's3', 'object', 'key')

    # Lógica específica para eventos S3 'put'
    return {
      statusCode: 200,
      body: {
        message: "S3 Put Event Detected!",
        bucket: bucket_name,
        key: object_key
      }.to_json
    }
  else

    s3_client = Aws::S3::Client.new(
      region: 'us-west-2',
      endpoint: 'http://localstack:4566', # Point to LocalStack for local testing
      # endpoint: 'http://localhost:4566', # Point to LocalStack for local testing
      # endpoint: 'http://172.17.0.1:4566', # Point to LocalStack for local testing
      # endpoint: 'http://192.168.0.12:4566',
      access_key_id: 'test', # Use mock credentials for LocalStack
      secret_access_key: 'test',
      force_path_style: true # Required for LocalStack compatibility
    )
    
    begin
      # List the buckets
      response = s3_client.list_buckets
      bucket_names = response.buckets.map(&:name) # Extract bucket names

      return {
        statusCode: 200,
        body: {
          message: "List of S3 Buckets",
          buckets: bucket_names
        }.to_json
      }
    rescue Aws::S3::Errors::ServiceError => e
      puts "Error listing buckets: #{e.message}"
      return {
        statusCode: 500,
        body: {
          message: "Error listing buckets: #{e.message}"
        }.to_json
      }
    end
  end
end
