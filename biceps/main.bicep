
param location string = resourceGroup().location
var storageaccountname = 'storageaccount'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageaccountname
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'appserviveplan'
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}
resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appinsights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

 resource azureFunction 'Microsoft.Web/sites@2020-12-01' = {
  name: 'azureFunctionApp'
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: 'serverfarms.id'
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsDashboard'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName1;AccountKey=${listKeys('storageAccountID1', '2019-06-01').key1}'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName2;AccountKey=${listKeys('storageAccountID2', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName3;AccountKey=${listKeys('storageAccountID3', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower('name')
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~2'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference('insightsComponents.id', '2015-05-01').InstrumentationKey
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
  }
}


