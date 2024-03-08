require 'json'
require 'aws-sdk-secretsmanager'

def lambda_handler(event:, context:)
  def database_secrets(secret_name: nil)
    begin
      client = Aws::SecretsManager::Client.new(
        region: 'us-west-2',
        endpoint: 'http://localstack:4566',
        access_key_id: 'test', # Use mock credentials for LocalStack
        secret_access_key: 'test'
      )
      secret_value = client.get_secret_value(secret_id: "DevelopmentSecret")
    rescue Aws::SecretsManager::Errors::ServiceError => e
      puts "Error fetching secret: #{e.message}"
    end
  end
  
  return {
    statusCode: 200,
    body: database_secrets.to_json
  }
end
