require 'json'

def lambda_handler(event:, context:)
  # Verifica se o evento contém 'Records' e se 'eventName' está presente
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
    # Lógica padrão para outros tipos de evento ou se o evento não contiver 'Records'
    return {
      statusCode: 200,
      body: {
        message: "Hello World or Event Not Recognized"
      }.to_json
    }
  end
end
