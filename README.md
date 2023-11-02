# Creating Your First Azure API with Python, Azure Web App, and Terraform Using Azure API Management

Azure API Management helps organizations publish APIs to external, partner, and internal developers to unlock the potential of their data and services. It is made up of an API gateway, a management plane, and a developer portal. These components are Azure-hosted and fully managed by default.

- The **API gateway** is the endpoint that accepts API calls and routes them to appropriate backends, verifies API keys and other credentials presented with requests.
- The **management plane** is the administrative interface where you set up your API program. It's used to provision and configure API Management service settings, and define or import API schema.
- The **Developer portal** is an automatically generated, fully customizable website with the documentation of your APIs. It provides access to read API documentation and call an API via the interactive console.

## API Management Service Setup

### Step 1: Create an Azure API Management Service Instance
1. Go to the Azure portal and search for "API Management Service."
2. In the API Management Service, provide a **UNIQUE resource name**, use your name as the organization email, and provide your email as the Administrator email.
3. Once your instance is deployed, navigate to the API Management service resource you created (e.g., `first-apim-demo`). It may take a few minutes for the instance to become ready.

You can also create the API Management service using Terraform, available in the [GitHub repository](https://github.com/Abhimanyu9988/azure-api-management.git). To access it:

```bash
git clone https://github.com/Abhimanyu9988/azure-api-management.git
cd azure-api-management
terraform init
terraform apply --auto-approve
```

### Step 2: Create a Python application

1. In the TerraformForAzureApp directory, You will be able to see "main.py" and "requirements.txt" file
2. To run locally->
```bash
pip3 install -r requirements.txt
uvicorn main:app
```

#### Do note that uvicon needs to be in your path, Else do an export 
#### Let's push the application in Dockerhub so we can access it in our WebApp

```Dockerfile
FROM python:3.9

WORKDIR /code

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY main.py .

EXPOSE 8000
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
CMD ["./entrypoint.sh"]
```

#### To push in the repo->

```bash
docker build -t <image-name> --platform=linux/amd64 .
docker tag <image-name> <your-repo>/<image-name>
docker push <your-repo>/<image-name>
```


### Step 3: Create a Web App 

1. In the TerraformForAzureApp, Edit the file main.tf with the image name, Below section is what we want to edit->

```bash
docker_image_name = "YourImage
docker_registry_url = "https://index.docker.io"
```

2. Once done, Let's deploy the TF to create our WebApp->


```bash
terraform init
terraform apply --auto-approve
```

#### If you wish to edit names, Then do edit variables.tf file

