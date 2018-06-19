# az-service-fabric-service-autoscaling
Demonstration of Service level auto scaling in Azure Service Fabric.
Azure Service Fabric provides orchestration services for Applications deployed as Docker containers, providing capabilities Service instance level autoscaling. In this example, a Web API is built using ASP.NET Core 2.0, packaged using Docker containers for Linux and deployed to an Azure Service Cluster. 
## Creating the Service Fabric Cluster
This feature requires version 6.2+ of Azure Service Fabric, and enabling the Resource Monitor Service on the cluster. Since this cannot be done from the Azure Portal at this time, I am using an ARM Template that deploys a cluster with this feature enabled.


--- in progress --
