# sam-app

This project contains source code and supporting files for a serverless application that you can deploy with the SAM CLI. It includes the following files and folders:

-   `hello_world` - Code for the application's Lambda function.
-   `events` - Invocation events that you can use to invoke the function.
-   `tests` - Unit tests for the application code.
-   `template.yaml` - A template that defines the application's AWS resources.

The application uses several AWS resources, including Lambda functions and an API Gateway API. These resources are defined in the `template.yaml` file in this project. You can update the template to add AWS resources through the same deployment process that updates your application code.

## Deploy the sample application

To deploy your application, you'll need the following tools:

-   **Ruby 3.2**: Ensure Ruby 3.2 is installed on your system. [Install Ruby 3.2](https://www.ruby-lang.org/en/documentation/installation/).
-   **SAM CLI**: This project uses the AWS Serverless Application Model (SAM) CLI. Make sure you have the SAM CLI installed. [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html).
-   **Docker**: The SAM CLI uses Docker to emulate your application's build environment. [Install Docker community edition](https://hub.docker.com/search/?type=edition&offering=community).

### Install Ruby Gems Locally

Before deploying your Lambda function, you need to install the necessary Ruby gems locally in a way that they can be packaged with your Lambda. This ensures that all your function's dependencies are included in the deployment package.

1. **Navigate to Your Lambda Function Directory**:

    Change directory to the root of your Lambda function where the `Gemfile` is located. If you're setting up the `mysql_lambda` function, use:

    ```bash
    cd /path/to/your/project/lambdas/mysql_lambda
    ```

2. **Install Gems Locally**:

    Run the following command to install the required gems specified in your Gemfile to a local vendor/bundle directory:

    ```bash
    bundle install --path vendor/bundle
    ```

### Setting Up MySQL Client Libraries on Ubuntu

For functions like `mysql_lambda`, you need the MySQL client libraries to interact with MySQL databases.

1. **Install MySQL Client Libraries on Ubuntu**:

    ```bash
    sudo apt-get update
    sudo apt-get install libmysqlclient-dev
    ```

2. **Locate the `libmysqlclient.so.*` Files**

    After installing the MySQL client libraries, locate the `libmysqlclient.so.*` files, which are typically found in `/usr/lib/x86_64-linux-gnu/` on Ubuntu systems. Use either the `find` or `locate` command to find them:

    #### Using `find`:

    Run this command in your terminal:

    ```bash
    find /usr/lib/x86_64-linux-gnu/ -name "libmysqlclient.so*"
    ```

3. **Copy the Necessary Files to Your Project**

    Once you have located the libmysqlclient.so.\* files, copy them into the lib directory within your Lambda function's directory. If this directory does not exist, create it first:

    ```bash
    find /usr/lib/x86_64-linux-gnu/ -name "libmysqlclient.so*"
    ```

Adjust /path/to/your/project/ to match the actual path of your SAM application.

Remember to replace `/path/to/your/project/` with the actual path to your project. This Markdown guide provides a clear, step-by-step process for locating the necessary MySQL client library files and preparing them for use with your AWS Lambda function.
