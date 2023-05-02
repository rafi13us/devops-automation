param location string = 'east US'

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2022-01-01' = {
  name: 'pepdemo'
  location: location
  properties: {
    privateLinkServiceConnections: [
      {
        name: 'demo'
        properties: {
          privateLinkServiceId: '../subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{privateLinkServiceName}.'
          groupIds: [
            groupIds : 'sites'
          ]
        }
      }
    ]
    subnet: {
      id: 'subnet2'
    }
  }
}
