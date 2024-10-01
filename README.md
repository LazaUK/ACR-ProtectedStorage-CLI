# Azure Container Registry (ACR): Building custom image with tarball from non-public Azure Storage account
By default, blobs and containers on Azure Storage account are not accessible by anonymous accounts.

This repo explains how to use **_Command-Line Interface (CLI)_** to authenticate with _Azure Storage_ and _Azure Container Registry_ resources using **Entra ID** credentials, retrieve a custom tarball and use it then to build a customised Docker image of an **Nginx** Web service.

> [!NOTE]
> This step-by-step guide assumes that you are using Windows 11 on your development machine.

## Table of contents:
- [Pre-requisites](https://github.com/LazaUK/ACR-ProtectedStorage-CLI#pre-requisites)
- [Step 1: Operations with Azure Storage account](https://github.com/LazaUK/ACR-ProtectedStorage-CLI#step-1-operations-with-azure-storage-account)
- [Step 2: Operations with Azure Container Registry](https://github.com/LazaUK/ACR-ProtectedStorage-CLI#step-2-operations-with-azure-container-registry)
- [Step 3: Testing customised Nginx Web service](https://github.com/LazaUK/ACR-ProtectedStorage-CLI#step-3-testing-customised-nginx-web-service)

## Pre-requisites
1. To build this demo, you'll need:
    - An Azure subscription with an active Entra ID account,
    - An Azure Storage account with a container holding the tarball,
    - An Azure Container Registry (ACR),
    - Docker installed on your development machine.
2. Once you have all the above resources deployed, set relevant environment variables to support execution of CLI commands in the steps below.
``` shell
set MyRegistry=<YOUR_ACR_RESOURCE>
set MyResourceGroup=<RESOURCE_GROUP_OF_ACR>
set MyImage=<TARGET_ACR_IMAGE_NAME>
set MyStorage=<YOUR_STORAGE_RESOURCE>
set MyContainer=<STORAGE_CONTAINER_NAME>
set MyBlob=<TARBALL_FILE_NAME>
```
3. Use the ```az login``` command to authenticate with your Azure subscription using Entra ID credentials.

## Step 1: Operations with Azure Storage account
1. The following command lists all the blobs in the specified Azure Storage container. You can verify the presence of your tarball (_%MyBlob%_) here.
``` PowerShell
az storage blob list --account-name %MyStorage% --container-name %MyContainer% --output table --auth-mode login
```
> [!NOTE]
> For demo purposes, you can re-use _tarball_ provided with this repo.
2. If positive, download the specified blob (%MyBlob%) from your storage account and place it in the ./src directory on your development machine.
``` PowerShell
az storage blob download --account-name %MyStorage% --container-name %MyContainer% --name %MyBlob% --file ./src/%MyBlob% --auth-mode login
```

## Step 2: Operations with Azure Container Registry
1. Use ```az acr build``` command to build a Docker image using the _Dockerfile_ and the downloaded tarball from the local src directory. Replace %MyImage% with the desired image name for your project.
``` PowerShell
az acr build --registry %MyRegistry% --image %MyImage%:latest --file Dockerfile ./src
```
> [!NOTE]
> For demo purposes, you can re-use _Dockerfile_ provided with this repo.

## Step 3: Testing customised Nginx Web service

![Nginx_site](images/ACR_Tarball.gif)
