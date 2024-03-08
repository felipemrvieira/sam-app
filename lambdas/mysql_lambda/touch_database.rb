require 'json'
require 'mysql2'

def lambda_handler(event:, context:)
   # Replace these with your actual database connection details
   client = Mysql2::Client.new(
    host: "172.17.0.1", # or the specific IP address of your MySQL host within the Docker network
    port: 3306,
    username: "root",
    password: "password",
    database: "test"
  )


  # Example query
  results = client.query("SELECT * FROM users LIMIT 10")

  results.each do |row|
    # Process each row
    puts row
  end

  { statusCode: 200, body: JSON.generate("Query executed successfully.") }
rescue Mysql2::Error => e
  { statusCode: 500, body: JSON.generate("Error connecting to the database: #{e.message}") }
end