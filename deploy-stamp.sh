#!/bin/bash

STAMP_NAME=$1
LOCATION=$2
ENVIRONMENT=$3
RESOURCE_GROUP="${STAMP_NAME}RG"


# Create Resource Group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create App Service Plan
az appservice plan create \
  --name "${STAMP_NAME}AppServicePlan" \
  --resource-group $RESOURCE_GROUP \
  --sku S1 \
  --is-linux

# Create Web App
az webapp create \
  --name "${STAMP_NAME}WebApp" \
  --resource-group $RESOURCE_GROUP \
  --plan "${STAMP_NAME}AppServicePlan" \
  --runtime "PYTHON|3.9"

#Update tags
az group update \
  --name $RESOURCE_GROUP \
  --tags environment="${ENVIRONMENT}" stamp=true stamp_name="${STAMP_NAME}"
