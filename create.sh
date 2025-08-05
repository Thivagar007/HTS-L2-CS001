# Variables
MY_RESOURCE_GROUP_NAME="HTS-L2-CS01-RG"
REGION="eastus"
ACR_NAME="hts-l2-cs01-acr"
AKS_NAME="hts-l2-cs01-aks"

# Create a resource group
echo "Creating resource group: $MY_RESOURCE_GROUP_NAME in region: $REGION"
az group create --name $MY_RESOURCE_GROUP_NAME --location $REGION

# Create an Azure Container Registry
echo "Creating Azure Container Registry: $ACR_NAME"
az acr create --resource-group $MY_RESOURCE_GROUP_NAME --name $ACR_NAME --sku Basic --location $REGION

# Create an Azure Kubernetes Service cluster
echo "Creating Azure Kubernetes Service cluster: $AKS_NAME"
az aks create --resource-group $MY_RESOURCE_GROUP_NAME --name $AKS_NAME --node-count 1 --enable-addons monitoring --generate-ssh-keys --location $REGION

# Get the AKS credentials
echo "Getting AKS credentials for cluster: $AKS_NAME"
az aks get-credentials --resource-group $MY_RESOURCE_GROUP_NAME --name $AKS_NAME

# Log in to the Azure Container Registry
echo "Logging in to Azure Container Registry: $ACR_NAME"
az acr login --name $ACR_NAME

# Connect the AKS cluster to the ACR
echo "Connecting AKS cluster to ACR"
az aks update --name $AKS_NAME --resource-group $MY_RESOURCE_GROUP_NAME --attach-acr $ACR_NAME