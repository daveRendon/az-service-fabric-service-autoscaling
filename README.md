# az-service-fabric-service-autoscaling
Demonstration of Service level auto scaling in Azure Service Fabric.
Azure Service Fabric provides orchestration services for Applications deployed as Docker containers, along with Service instance level autoscaling. In this example, a Web API is built using ASP.NET Core 2.0, packaged using Docker containers for Linux and deployed to an Azure Service Cluster. 
## Creating the Service Fabric Cluster
This feature requires version 6.2.194.1+ of Azure Service Fabric, and enabling the 'Resource Monitor Service' on the Cluster. Since the Azure Portal does not provde an option enable this Service at this time, I am using an ARM Template (1-Nodetype-elb-SFCluster-oms.json) that deploys a cluster with this feature enabled. 

To run this ARM Template, you would require the following handy that is specific to your Azure Subscription:
1. The Key Vault URL
````
"sourceVaultValue": {
    "type": "string",
    "defaultValue": "/subscriptions/<your subcription id>/resourceGroups/<ur rg>/providers/Microsoft.KeyVault/vaults/<ur keyvault>",
     },
 ````
 2. Secret URL to the Certificate in Key Vault
 ````
  "certificateUrlValue": {
            "type": "string",
            "defaultValue": "https://<ur kv>.vault.azure.net/secrets/<ur secret name>/9a36a8986cb041d5ba45089ffcdbd92d",
        },
  ````
3. Thumbprint of the above certificate in Key Vault
````
    "certificateThumbprint": {
            "type": "string",
            "defaultValue": "<certificate thumb print>",
        },
````
4. Thumbprint of the Admin client certificate on the local Dev machine
````
 "clientCertificateStoreValue": {
            "type": "string",
            "defaultValue": "<thumbprint admin client>",
        },
````
*The ARM Template provisions an OMS Repository for Log analytics and monitoring. Ensure that OMS Service is available in the Azure region selected for the Service FAbric Cluster*
Run the ARM Template to create the Cluster. After the Service Fabric Cluster is provisioned, launch the Explorer to check the Cluster Manifest. The Resource Monitor Service would be enabled. See below

<img src="./images/ResourceMonitorConfig.PNG" alt="drawing" height="350px"/>

## Packaging the sample Application ##
An ASP.NET Core 2.0 Web API Project is packaged using Docker Container for Linux. It implements an API that performs a CPU intensive task that would be used to trigger a Service instance scale out action on the Service Fabric Cluster
````
 public class OperationsController : Controller
    {
        // GET api/Operations
        [HttpGet]
        public IEnumerable<string> Get
        
        {
            double answer = 0;
            for (int i = 0; i < 5000000; i++)
            {
                Random r = new Random();
                double d = r.Next(1, 9999999);
                answer = Math.Sqrt(d);
            }
            return new string[] { "Longrunning calculation", "answer :"+answer };
        }
    }
````
The Docker container has been uploaded to Docker Hub and referenced in the Service Manifest of the Service Fabric Application.

## Deploying the sample Application  to the Service Fabric Cluster ##
