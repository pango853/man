
Azure Traffic Manager
Azure Key Vault


# Microsoft Learn

## Azure

### Azure fundamentals
	//az group create --name XXX --location YYY
	az group list

	USERNAME=azureuser
	PASSWORD=$(openssl rand -base64 32)
	RG=d868d953-2c36-4dc6-991c-48cd526b7bb2

	az vm list-sizes --location japaneast
	az vm image list --offer CentOS
	az vm image list --publisher Microsoft
	az network nsg list --output table

	//Windows
	az vm create --name myVM --resource-group $RG --image Win2016Datacenter --size Standard_DS2_v2 --location japaneast --admin-username $USERNAME --admin-password $PASSWORD
	az vm get-instance-view --name myVM --resource-group $RG --output table
	az vm extension set --resource-group $RG --vm-name myVM --publisher Microsoft.Compute --name CustomScriptExtension --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-iis.ps1"]}' --protected-settings '{"CommandToExecute":"powershell -ExecutionPolicy Unrestricted -File configure-iis.ps1"}'

	//Linux
	az vm create --name myVM --resource-group $RG --image UbuntuLTS --location japaneast --size Standard_DS2_v2 --admin-username $USERNAME --generate-ssh-keys
		ls -al ~/.ssh
		ssh $USERNAME@13.78.26.2
	az vm get-instance-view --name myVM --resource-group $RG --output table
	az vm extension set --resource-group $RG --vm-name myVM --publisher Microsoft.Azure.Extensions --name customScript --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' --protected-settings '{"commandToExecute":"./configure-nginx.sh"}'


	az vm open-port --resource-group $RG --name myVM --port 80

	az vm show --resource-group $RG --name myVM --show-details --query [publicIps] --output tsv
		13.78.30.235

	az vm resize --resource-group $RG --name myVM --size Standard_DS3_v2
	az vm show --resource-group $RG --name myVM --query hardwareProfile --output tsv


### Get started with Azure DevOps
REF: https://docs.microsoft.com/en-us/learn/modules/get-started-with-devops/

"DevOps is the union of people, process, and products to enable continuous delivery of value to our end users," Principal DevOps Manager on Microsoft's Cloud Developer Advocacy team, Donovan Brown.

https://dev.azure.com
	Azure Boards
	Azure Pipelines
	Azure Repos
	Azure Test Plans
	Azure Artifacts

### Deploy a website to Azure with Azure App Service
REF: https://docs.microsoft.com/en-us/learn/paths/deploy-a-website-with-azure-app-service/

- IDE
  - VS Code
    - Azure App Service
  - VS
    - NuGet package or Visual Studio extension
    - Visual Studio Installer > Workloads > Azure development
  - Eclipse
    - Azure Toolkit for Eclipse
    - Azure Toolkit for Java, http://dl.microsoft.com/eclipse/. Tools > Azure menu
- App Service web app
  - Deployment slots
  - App Service plan
  - Starter web application tutorials: https://docs.microsoft.com/en-us/learn/modules/host-a-web-app-with-azure-app-service/4-exercise-implement-a-web-application?pivots=csharp
    - C#
      $ dotnet new mvc --name BestBikeApp
      $ cd BestBikeApp; dotnet run
      App Service> (Select) > Deployment Center > SOURCE CONTROL: Local Git, BUILD PROVIDOR: App Service Kudu build server
      Deployment Credentials > User Credentials > Set Username and Password > Save Credentials and Copy Git Clone Uri
      	biker:B238946asUIERF
      	https://myapp137137\biker@myapp137137.scm.azurewebsites.net:443/myapp137137.git
      $ git config --global user.name "[your name]"
      $ git config --global user.email "[your email]"
      $ cat ~/.gitconfig
      $ cd ~/BestBikeApp/
      $ git init
      $ git add .
      $ git commit -m "Initial"
      $ git remote add origin https://myapp137137\biker@myapp137137.scm.azurewebsites.net:443/myapp137137.git
      $ git remote -v
      $ git push origin master
      Goto Deployment Center to see the commits, and then browse https://myapp137137.azurewebsites.net/
    - Java
      $ cd ~; mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp
      $ cd helloworld; mvn package
      $ az webapp deployment user set --user-name biker --password B238946asUIERF
      $ cd ~/helloworld/target
      $ curl -v -X POST -u biker:B238946asUIERF https://myapp137137.scm.azurewebsites.net/api/wardeploy --data-binary @helloworld.war
      Then browse https://myapp137137.scm.azurewebsites.net
    - Node.js
      cd ~; mkdir helloworld; cd helloworld
      npm init
      touch index.js
      code .
      #package.json
			{
			  "name": "helloworld",
			  ...
			  "scripts": {
			    "start": "node index.js"
			  },
			  ...
			}
			// Ctrl-S
      #index.js
			var http = require('http');

			var server = http.createServer(function(request, response) {

			    response.writeHead(200, { "Content-Type": "text/html" });
			    response.end("<html><h1>Hello World!</h1></html>");

			});

			var port = process.env.PORT || 1337;
			server.listen(port);

			console.log("Server running at http://localhost:%d", port);
			// Ctrl-S, Ctrl-Q
      zip -r helloworld.zip .
      Browse https://<app_name>.scm.azurewebsites.net/ZipDeployUI and drag "helloworld.zip" there to deploy
      OR
      az webapp deployment source config-zip --resource-group $RG --src helloworld.zip --name <app_name>
      Browse https://<app_name>.azurewebsites.net to confirm.
  - Publish web app with Visual Studio
    VS > New Project > Web > ASP.NET Core Web Application > .NET Core/ASP.NET Core 2.1/Web Application
    F5 or Ctrl+F5 to run the app. VS starts the IIS Express web browser and loads the app.
    Solution Explorer > Right Click > Publish
    Start > Choose App Service > Create New > Configure Create App Service
    Browse https://WebApplication120190113110059.azurewebsites.net/
    Modify About.cshtml and then Publish again.
    Browse https://webapplication120190113110059.azurewebsites.net/About to see the changes.
    Also go to Azure Portal > App Services > (Select) > Activity log to see the activities.

### Azure Container
REF: https://docs.microsoft.com/en-us/learn/paths/administer-containers-in-azure/

- Azure Container Registry
  $ az group list
  $ RG=b06c76ba-2e4f-47ad-a2c3-d08f0657016b
  $ ACR=MyRegistry1795830
  $ az acr create --resource-group $RG --name $ACR --sku Premium
  	// Note "loginServer": "myregistory.azurecr.io",
  - Azure Container Registry Tasks
    $ mkdir image1; cd image1
    $ code
		FROM    node:9-alpine
		ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/package.json /
		ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/server.js /
		RUN     npm install
		EXPOSE  80
		CMD     ["node", "server.js"]
    	// Ctrl+S, save as Dockerfile, Ctrl+Q
    $ az acr build --registry $ACR --image helloacrtask:v1 .
    $ az acr repository list --name $ACR --output table
  - ACR authentication with admin account enabled
    $ az acr update --name $ACR --admin-enabled true
    $ az acr credential show --name $ACR
    	// "value": "ZQAjrtif0jDOXsw=MsXceRzyCjohqggC"
    	// "username": "MyRegistry1798320"
    $ ACRURL=${ACR,,}.azurecr.io
    $ az container create --resource-group $RG --name acrtask1 --image $ACRURL/hellocrtasks:v1 --registry-login-server $ACRURL --ip-address Public --location japaneast --registry-user "MyRegistry1798320" --registry-password "ZQAjrtif0jDOXsw=MsXceRzyCjohqggC"
    $ az container show --resource-group $RG --name acrtask1 --query ipAddress.ip --output table
    Browse http://<acrtask1's IP>
  - Geo-replicated registries
    $ az acr replication create --registry $ACR --location japanwest
    $ az acr replication list --registry $ACR --output table
  - Azure Container Instances(ACI)
    $ RG=1c155b13-88d5-49d2-aa59-744d08d6588d
    $ DNSLABEL=mytestingdns17325
    $ az container create --resource-group $RG --name mycontainer --image microsoft/aci-helloworld --ports 80 --dns-name-label $DNSLABEL --location eastus
    $ az container show --resource-group $RG --name mycontainer --query "{FQDN:ipAddress.fqdn,State:provisioningState}" --output table
    	// mytestingdns17325.eastus.azurecontainer.io
    Browse http://mytestingdns17325.eastus.azurecontainer.io
    Run another with restart policy: Always(default)|Never|OnFailure
    $ az container create --resource-group $RG --name restart-demo --image microsoft/aci-wordcount:latest --restart-policy OnFailure --location eastus
    $ az container show --resource-group $RG --name restart-demo --query containers[0].instanceView.currentState.state
    $ az container logs --resource-group $RG --name restart-demo
    - Secured environment variables
      $ COSMOSDB=mycosmosdb-$RANDOM
      $ COSMOSEND=$(az cosmosdb create --resource-group $RG --name $COSMOSDB --query documentEndpoint --output tsv)
      $ COSMOSKEY=$(az cosmosdb list-keys --resource-group $RG --name $COSMOSDB --query primaryMasterKey --output tsv)
      $ az cosmosdb list
      $ az container create --resource-group $RG --name cosmodemo1 --image microsoft/azure-vote-front:cosmosdb --ip-address Public --location eastus --environment-variables COSMOS_DB_ENDPOINT=$COSMOSEND COSMOS_DB_MASTERKEY=$COSMOSKEY
      $ az container show --resource-group $RG --name cosmodemo1 --query ipAddress.ip --output tsv
      Browse http://<cosmodemo1's ip>
      $ az container show --resource-group $RG --name cosmodemo1 --query containers[0].environmentVariables
      $ az container create --resource-group $RG --name cosmodemo2 --image microsoft/azure-vote-front:consmosdb --ip-address Public --location eastus --secure-environment-variables COSMOS_DB_ENDPOINT=$COSMOSEND COSMOS_DB_MASTERKEY=$COSMOSKEY
      $ az container show --resource-group $RG --name cosmodemo2 --query containers[0].environmentVariables
    - Use data volumes
      $ STORAGEACCOUNT=mystorageaccount$RANDOM
      $ az storage account create --resource-group $RG --name $STORAGEACCOUNT --sku Standard_LRS --location eastus
      $ export AZURE_STORAGE_CONNECTION_STRING=$(az storage account show-connection-string --resource-group $RG --name $STORAGEACCOUNT --output tsv)
      	// Like: DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=mystorageaccount9802;AccountKey=z3gxu5tfq+vE4aX4C/QCUJoDc1rYVAq/oeMxWd2G2wZCIpGEtcCmocv9KhkBRZyRvQTzzeMBrY/SWwtGzmPfqQ==
      $ az storage share create --name aci-share-demo
      Get storage credentials
      $ STORAGEKEY=$(az storage account keys list --resource-group $RG --account-name $STORAGEACCOUNT --query "[0].value" --output tsv)
      $ az container create --resource-group $RG --name aci-demo-files --image microsoft/aci-hellofiles --location eastus --ports 80 --ip-address Public --azure-file-volume-account-name $STORAGEACCOUNT --azure--file-volume-account-key $STORAGEKEY --azure-file-volume-share-name aci-share-demo --azure-file-volume-mount-path /aci/logs/
      $ az container show --resource-group $RG --name aci-demo-files --query ipAddress.ip --output tsv
      Browse http://<aci-demo-files's IP> and submit something
      $ az storage file list --share-name aci-share-demo --output table
      $ az storage file download --share-name aci-share-demo --path <filename>
      $ cat <filename>
    - Troubleshooting
      Pulling container logs
      $ az container create --resource-group $RG --name mycontainer --image microsoft/sample-aks-helloworld --ports 80 --ip-address Public --location eastus
      $ az container logs --resource-group $RG --name mycontainer
      Viewing container events
      $ az container attach --resource-group $RG --name mycontainer
        // Ctrl+C to disconnect
      Attaching to a container instance
      $ az container exec --resource-group $RG --name mycontainer --exec-command /bin/sh
      	ls and exit
      $ CONTAINERID=$(az container show --resource-group $RG --name mycontainer --query id --output tsv)
      	// "/subscriptions/3172206f-d4ef-4c89-a908-54494bf18b5c/resourceGroups/1c155b13-88d5-49d2-aa59-744d08d6588d/providers/Microsoft.ContainerInstance/containerGroups/mycontainer"
      $ az monitor metrics list --resource $CONTAINERID --metric CPUUsage --output table
      $ az monitor metrics list --resource $CONTAINERID --metric MemoryUsage --output table
  - Azure Kubernetes Service(AKS) for full orchestration
    TODO...

### Azure Cosmos DB
REF: https://docs.microsoft.com/en-us/learn/paths/work-with-nosql-data-in-azure-cosmos-db/
- Azure Cosmos DB account
- Data model
  - Core(SQL)
  - Gremlin(graph)
  - MongoDB API
  - Cassandra
  - Azure Table
- Request unit(RU) and throughput requirements
  - Azure Cosmos DB Capacity Planner, https://www.documentdb.com/capacityplanner
  - Provision a minimum of 400 RU/s or a maximum of 250,000 RU/s
  - Set 1000 RU/s otherwise cannot scale!
- Data consistency: Session | 
- Indexing policy: None | 
- Patitioning strategy to scale out
  - Storage space of each partition key < 10 GB = 1 physical partition -> Deal with Composite key like userID-date
- Example for a retail app
  Create Cosmos DB account > Go to resource > Data Explorer > New Collection:
  - Database id: Products
    Collection Id: Clothing
    Partition key: /productid
    Throughput: 1000
    ! Don't check the "Provision database throughput" option
- Insert and query data in your Azure Cosmos DB database
  $ az account list --output table
  $ az account set --subscription "<subscription name>"
  $ az group list --output table
  $ COSMOSDB=mycosmosdb01
  $ RG=$(az group list --query [0].name --output tsv)
  $ LC=eastus
  $ DBNAME=Products
  $ az group create --name $RG --location LC
  $ az cosmosdb create --resource-group $RG --name $COSMOSDB --kind GlobalDocumentDB
  $ az cosmosdb database create --resource-group $RG --name $COSMOSDB --db-name $DBNAME
  $ az cosmosdb collection create --resource-group $RG --name $COSMOSDB --db-name $DBNAME --collection-name Clothing --partition-key-path /productId --throughput 1000
  Add data with Data Explorer
  Open Full Screen > Open > SQL API pane > expand Clothing > Documents > New Document > Add as JSON:
	    {
	    	"id": "1",
	    	"productId" : "33218896",
	    	"category" : "Women's Clothing",
	    	"manufacturer" : "Contoso Sport",
	    	"description" : "Quick dry crew neck t-shirt",
	    	"price" : "14.99",
	    	"shipping" : {
		    	"weight" : 1,
		    	"dimensions":{
		    	"width" : 6,
		    	"height" : 8,
		    	"depth" : 1
		    	}
	    	}
	    }
  Save and create one more
	    {
	    	"id": "2",
	    	"productId" : "33218897",
	    	"category" : "Women's Outerwear",
	    	"manufacturer" : "Contoso",
	    	"description" : "Blank wool pea-coat",
	    	"price" : "49.99",
	    	"shipping" : {
		    	"weight" : 2,
		    	"dimensions":{
		    	"width" : 8,
		    	"height" : 11,
		    	"depth" : 3
		    	}
	    	}
	    }
  Confirm in the Documents tab.
  Data Explorer > New SQL Query:
    - SELECT * FROM c
    - SELECt * FROM Products p WHERE p.id = "1"
    - SELECT p.productId, p.price, p.description FROM Products p ORDER BY p.price ASC
- Stored procedure and User-defined functions for performing ACID transaction
  Just run the default sample first. Data Explorer > New Stored Procedure > Id:sample > Update > Execute > Stored Procedure Id: 33218896
  Next create another stored procedure.
	// Stored procudure
	function helloWorld(){
		var ctx = getContext();
		var rsp = ctx.getResponse();
		rsp.setBody("Hellow, World");
	}
  Next create another stored procedure that creates documents.
    function createMyDocument(){
    	var ctx = getContext();
    	var col = ctx.getCollection();
    	var doc = { "id": "3", "productId": "33218898", "description": "Contoso microfleece zip-up jacket", "price": "44.99"};
    	var accepted = col.createDocument(col.getSelfLink(), doc, function (err, documentCreated){
    		if(err) throw new Error('Error' + err.message);
    		ctx.getResponse().setBody(documentCreated);
    	});
    	if(!accepted) return;
    	// ...
    }
  Execute with partition key value: 33218898 and confirm in the Documents tab.
  Now, create a UDF. Data Explorer > New UDF
	function productTax(price){
		if(price == undefined) throw 'no input';
		var amount = parseFloat(price);
		if(amount < 1000) return amount * 0.1;
		else if(amount < 10000) return amount * 0.2;
		else return amount * 0.4;
	}
  Go to the Query 1 tab and copy and paste the following query and run.
  	SELECT c.id, c.productId, c.price, udf.productTax(c.price) AS tax FROM c
- Geospatial queries???
- Set up an app with Azure Cosmos DB extension for Visual Studio Code
  Install Azure Cosmos DB extension and reload
  View > Command Palette > Type: Azure: Sign In to sign in
  > Azure: Select Subscriptions
  Azure icon > right-click Concierge Subscription > Create Account or Click + button to add one
  Azure: Cosmos DB pane > expand Concierge Subscription > right-click the Account > Create Database > type Users, WebCustomers, userId, 1000
  Azure: Cosmos DB pane > expand the account > expand Users database > expand WebCustomers collection
  File > Open Folder > learning-module
  View > Terminal
  	> dotnet new console
  	> dotnet run

  	> dotnet add package System.Net.Http
  	> dotnet add package System.Configuration
  	> dotnet add package System.Configuration.ConfigurationManager
  	> dotnet add package Microsoft.Azure.DocumentDB.Core
  	> dotnet add package Newtonsoft.Json
  	> dotnet add package System.Threading.Tasks
  	> dotnet add package System.Linq
  	> dotnet restore
  Open Program.cs
    using System;
  	using System.Configuration;
  	using System.Linq;
  	using System.Threading.Tasks;
  	using System.Net;
  	using Microsoft.Azure.Documents;
  	using Microsoft.Azure.Documents.Client;
  	using Newtonsoft.Json;
  Create a new file App.config
	<?xml version="1.0" encoding="utf-8"?>
	    <configuration>
	      <appSettings>
	        <add key="accountEndpoint" value="https://<account-name-lower-case>.documents.azure.com:443/" />
	        <add key="accountKey" value="<right-click the Cosmos DB Account on Azure: Cosmos DB pane and Copy Connection String>" />
	      </appSettings>
	</configuration>
  Check again
    > dotnet run
  Open Program.cs
  	class Program
  	{
		private DocumentClient client;
		private async Task BasicOperations()
		{
		    this.client = new DocumentClient(new Uri(ConfigurationManager.AppSettings["accountEndpoint"]), ConfigurationManager.AppSettings["accountKey"]);
		    await this.client.CreateDatabaseIfNotExistsAsync(new Database { Id = "Users" });
			DocumentCollection collection = new DocumentCollection{ Id = "WebCustomers"};
			collection.PartitionKey.Paths.Add("/userId");
			await this.client.CreateDocumentCollectionIfNotExistsAsync(UriFactory.CreateDatabaseUri("Users"), collection);
		    Console.WriteLine("Database and collection validation complete");
		}
  > dotnet run
  Copy and paste into the Main method.
		try
		{
		    Program p = new Program();
		    p.BasicOperations().Wait();
		}
		catch (DocumentClientException de)
		{
		    Exception baseException = de.GetBaseException();
		    Console.WriteLine("{0} error occurred: {1}, Message: {2}", de.StatusCode, de.Message, baseException.Message);
		}
		catch (Exception e)
		{
		    Exception baseException = e.GetBaseException();
		    Console.WriteLine("Error: {0}, Message: {1}", e.Message, baseException.Message);
		}
		finally
		{
		    Console.WriteLine("End of demo, press any key to exit.");
		    Console.ReadKey();
		}
  > dotnet run
- Use .NET Core SDK to perform CRUD operations
  First create document classes in Program.cs.
		public class User{
		    [JsonProperty("id")] public string Id { get; set; }
		    [JsonProperty("userId")] public string UserId { get; set; } // As partition key!
		    [JsonProperty("lastName")] public string LastName { get; set; }
		    [JsonProperty("firstName")] public string FirstName { get; set; }
		    [JsonProperty("email")] public string Email { get; set; }
		    [JsonProperty("dividend")] public string Dividend { get; set; }
		    [JsonProperty("OrderHistory")] public OrderHistory[] OrderHistory { get; set; }
		    [JsonProperty("ShippingPreference")] public ShippingPreference[] ShippingPreference { get; set; }
		    [JsonProperty("CouponsUsed")] public CouponsUsed[] Coupons { get; set; }
		    public override string ToString(){ return JsonConvert.SerializeObject(this); }
		}
		public class OrderHistory{
		    public string OrderId { get; set; }
		    public string DateShipped { get; set; }
		    public string Total { get; set; }
		}
		public class ShippingPreference{
		    public int Priority { get; set; }
		    public string AddressLine1 { get; set; }
		    public string AddressLine2 { get; set; }
		    public string City { get; set; }
		    public string State { get; set; }
		    public string ZipCode { get; set; }
		    public string Country { get; set; }
		}
		public class CouponsUsed{
		    public string CouponCode { get; set; }
		}

		private void WriteToConsoleAndPromptToContinue(string format, params object[] args){
		    Console.WriteLine(format, args);
		    Console.WriteLine("Press any key to continue ...");
		    Console.ReadKey();
		}
  > dotnet run
  Then, modify as below,
		private async Task CreateUserDocumentIfNotExists(string databaseName, string collectionName, User user){
		    try{
		        await this.client.ReadDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, user.Id), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
		        this.WriteToConsoleAndPromptToContinue("User {0} already exists in the database", user.Id);
		    }catch (DocumentClientException de){
		        if (de.StatusCode == HttpStatusCode.NotFound){
		            await this.client.CreateDocumentAsync(UriFactory.CreateDocumentCollectionUri(databaseName, collectionName), user);
		            this.WriteToConsoleAndPromptToContinue("Created User {0}", user.Id);
		        }else{
		            throw;
		        }
		    }
		}
		// In BasicOperations method
			User yanhe = new User{
			    Id = "1", UserId = "yanhe", LastName = "He", FirstName = "Yan", Email = "yanhe@contoso.com", OrderHistory = new OrderHistory[]{
			            new OrderHistory { OrderId = "1000", DateShipped = "08/17/2018", Total = "52.49" }
			        },
			        ShippingPreference = new ShippingPreference[]{
			                new ShippingPreference { Priority = 1, AddressLine1 = "90 W 8th St", City = "New York", State = "NY", ZipCode = "10001", Country = "USA"}
			        },
			};
			await this.CreateUserDocumentIfNotExists("Users", "WebCustomers", yanhe);

			User nelapin = new User{ Id = "2", UserId = "nelapin", LastName = "Pindakova", FirstName = "Nela", Email = "nelapin@contoso.com", Dividend = "8.50", OrderHistory = new OrderHistory[]
			    { new OrderHistory { OrderId = "1001", DateShipped = "08/17/2018", Total = "105.89" } },
			     ShippingPreference = new ShippingPreference[] {
			        new ShippingPreference { Priority = 1, AddressLine1 = "505 NW 5th St", City = "New York", State = "NY", ZipCode = "10001", Country = "USA" },
			        new ShippingPreference { Priority = 2, AddressLine1 = "505 NW 5th St", City = "New York", State = "NY", ZipCode = "10001", Country = "USA" }
			    },
			    Coupons = new CouponsUsed[] {
			        new CouponsUsed{ CouponCode = "Fall2018" }
			    }
			};
			await this.CreateUserDocumentIfNotExists("Users", "WebCustomers", nelapin);
  > dotnet run
  Read documents
		private async Task ReadUserDocument(string databaseName, string collectionName, User user){
		    try{
		        await this.client.ReadDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, user.Id), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
		        this.WriteToConsoleAndPromptToContinue("Read user {0}", user.Id);
		    }catch (DocumentClientException de){
		        if (de.StatusCode == HttpStatusCode.NotFound){
		            this.WriteToConsoleAndPromptToContinue("User {0} not read", user.Id);
		        }else{
		            throw;
		        }
		    }
		}
		// In BasicOperations method, add
			await this.ReadUserDocument("Users", "WebCustomers", yanhe);
  > dotnet run
  Replace documents
		private async Task ReplaceUserDocument(string databaseName, string collectionName, User updatedUser){
		    try{
		        await this.client.ReplaceDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, updatedUser.Id), updatedUser, new RequestOptions { PartitionKey = new PartitionKey(updatedUser.UserId) });
		        this.WriteToConsoleAndPromptToContinue("Replaced last name for {0}", updatedUser.LastName);
		    }catch (DocumentClientException de){
		        if (de.StatusCode == HttpStatusCode.NotFound){
		            this.WriteToConsoleAndPromptToContinue("User {0} not found for replacement", updatedUser.Id);
		        }else{
		            throw;
		        }
		    }
		}
		// In BasicOperations method, add
			yanhe.LastName = "Suh";
			await this.ReplaceUserDocument("Users", "WebCustomers", yanhe);
  > dotnet run
  Delete documents
		private async Task DeleteUserDocument(string databaseName, string collectionName, User deletedUser){
		    try{
		        await this.client.DeleteDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, deletedUser.Id), new RequestOptions { PartitionKey = new PartitionKey(deletedUser.UserId) });
		        Console.WriteLine("Deleted user {0}", deletedUser.Id);
		    }catch (DocumentClientException de){
		        if (de.StatusCode == HttpStatusCode.NotFound){
		            this.WriteToConsoleAndPromptToContinue("User {0} not found for deletion", deletedUser.Id);
		        }else{
		            throw;
		        }
		    }
		}
		// In BasicOperations method, add
			await this.DeleteUserDocument("Users", "WebCustomers", yanhe);
  > dotnet run
- Query using the Azure COSMOS DB .NET Core SDK
  - LINQ expressions
    - input.Select(family => family.parents[0].familyName);
    - input.Select(family => family.children[0].grade + c);
    - input.Select(family => new { name = family.children[0].familyName, grade = family.children[0].grade + 3})
    - input.Where(family => family.parents[0].familyName == "Smith")
  - Run LINQ queries and SQL queries
		private void ExecuteSimpleQuery(string databaseName, string collectionName){
		    // Set some common query options
		    FeedOptions queryOptions = new FeedOptions { MaxItemCount = -1, EnableCrossPartitionQuery = true };

		    // Here we find nelapin via their LastName
		    IQueryable<User> userQuery = this.client.CreateDocumentQuery<User>(
		            UriFactory.CreateDocumentCollectionUri(databaseName, collectionName), queryOptions)
		            .Where(u => u.LastName == "Pindakova");

		    // The query is executed synchronously here, but can also be executed asynchronously via the IDocumentQuery<T> interface
		    Console.WriteLine("Running LINQ query...");
		    foreach (User user in userQuery){
		        Console.WriteLine("\tRead {0}", user);
		    }

		    // Now execute the same query via direct SQL
		    IQueryable<User> userQueryInSql = this.client.CreateDocumentQuery<User>(
		            UriFactory.CreateDocumentCollectionUri(databaseName, collectionName),
		            "SELECT * FROM User WHERE User.lastName = 'Pindakova'", queryOptions );

		    Console.WriteLine("Running direct SQL query...");
		    foreach (User user in userQueryInSql){
		            Console.WriteLine("\tRead {0}", user);
		    }

		    Console.WriteLine("Press any key to continue ...");
		    Console.ReadKey();
		}
		// Add to BasicOperations method,
			this.ExecuteSimpleQuery("Users", "WebCustomers");
- Create a stored procedure
  Azure: Cosmos DB pane > Expand account > Users > WebCustomers > right-click Stored Procedures > Create Stored Procedure > type UpdateOrderTotal
  // Just use the default sample
  Open Program.cs and add
		public async Task RunStoredProcedure(string databaseName, string collectionName, User user){
		    await client.ExecuteStoredProcedureAsync<string>(UriFactory.CreateStoredProcedureUri(databaseName, collectionName, "UpdateOrderTotal"), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
		    Console.WriteLine("Stored procedure complete");
		}
		// Add to BasicOperations method,
			await this.RunStoredProcedure("Users", "WebCustomers", yanhe);
- Distribute data globally
  Create a Cosmos DB account with "Multi-region Writes" enabled.
  Go to resource >  Settings > Replicate data globally > select regions and Save
  - Write to multiple regions
    - Multi-master support
      - Conflict resolution: Last-Writer-Wins(LWW) | Custom - User-defined function | Custom - Async
    - Failover
      - Configure preferred read region list at the application side
      - Applications can use the WriteEndpoint property of DocumentClient class to detect the change in write region
      Replicate data globally > Automatic Failover > Enable Automatic Failover > Read regions > drag and drop to change read region priorities
  - Choose a consistency level: Strong, Bounded-staleness, Session, Consistent prefix, and Eventual

## Build a chat bot with the Azure Bot Service
REF: https://docs.microsoft.com/en-us/learn/modules/build-chat-bot-with-azure-bot-service/

- Learn environment
  Microsoft Learn - Hosted Environment URL: https://labondemand.com/VirtualizationClient/0a8f2718-fe5e-444e-a4b3-9aee2a7e4acb?rc=10
  LabUser:3K28zYJ%zhPpZe2
  Azure Portal URL:https://portal.azure.com
  Username: LabUser-8209938@triplecrownlabsoutlook.onmicrosoft.com, Password: FMp62+j!aJ
1. Deploy a bot
   Azure > Create a resource > AI + Machine Learning > Web App Bot >
   Bot template: SDK v3, Node.js, Question and Answer >
   App service plan/Location: Create New
   - A bot was created and registered, an Azure web app was created to host it, and the bot was configured to work with Microsoft QnA Maker. The next step is to use QnA Maker to create a knowledge base of questions and answers to infuse the bot with intelligence.
		Web App Bot
		App Service plan
		App Service
		Storage account
		Application Insights
2. Create a knowledge base with Microsoft QnA Maker
   https://www.qnamaker.ai > Sign in > Create a knowledge base > Create a QnA service >
   Create a QnA service on Azure. Now we have 
   Connect your QnA service to your KB
		Cognitive Services
		App Service plan
		App Service
		Application Insights
		Search service
   Then return to Create a knowledge base > Specify "Microsoft Azure Directory ID" and "Azure subscription name" > ...
   Populate your KB, you can import them from online FAQs or local files. Supported formats include tab-delimited text files, Microsoft Word documents, Excel spreadsheets, and PDF files.
   Open https://github.com/MicrosoftDocs/mslearn-build-chat-bot-with-azure-bot-service/blob/master/Factbot.tsv.zip and extract.
   Add file > Select "Factbot.tsv" > Create your KB > Save and train
   Test > type "Hi" > type "What book has sold the most copies?"
   PUBLISH tab > Publish
		Postman:
		POST /knowledgebases/44926b26-0199-475c-a813-31e2f6efbea4/generateAnswer
		Host: https://oh0myqnaserv-kb-001.azurewebsites.net/qnamaker
		Authorization: EndpointKey 7afbbc87-358f-4540-bda7-155dc3f92707
		Content-Type: application/json
		{"question":"<Your question>"}
		Curl:
		curl -X POST https://oh0myqnaserv-kb-001.azurewebsites.net/qnamaker/knowledgebases/44926b26-0199-475c-a813-31e2f6efbea4/generateAnswer -H "Authorization: EndpointKey 7afbbc87-358f-4540-bda7-155dc3f92707" -H "Content-type: application/json" -d "{'question':'<Your question>'}"
3. Deploy a bot that can use the knowledge base with VS Code
   When you created an Azure web app bot, an Azure web app was deployed to host it.
   Now deploy the code to the bot.
   the code was generated for you by the Azure Bot Service
   
   Azure > Open the pre-created "Web App Bot" in the resource group > Build > Download Bot source code > Publish: Publish updates automatically to Azure with Continuous Deployment
   To set up the deployment:
   Web App Bot blade > Setup > Choose Source > Local Git Repository > Setup connection (factbotAdminQ123rjv:VBgser89S) > OK > Close
   Web App Bot blade > All App service settings
     URL: https://qa-factboot123.azurewebsites.net
     Git clone url: https://factbotAdminQ123rjv@qa-factboot123.scm.azurewebsites.net:443/qa-factboot123.git
   Go somewhere and run
   > git clone https://factbotAdminQ123rjv@qa-factboot123.scm.azurewebsites.net:443/qa-factboot123.git
     	factbotAdminQ123rjv:VBgser89S
   > git push -u origin master
4. Debug the bot locally
   > cd qa-factboot123\
   > npm install restify
   > npm install botbuilder
   > npm install botbuilder-azure
   > npm install botbuilder-cognitiveservices
   Open app.js
		"use strict";
		var builder = require("botbuilder");
		var botbuilder_azure = require("botbuilder-azure");

		var useEmulator = true;
		var userName = "";
		var yearsCoding = "";
		var selectedLanguage = "";

		var connector = useEmulator ? new builder.ChatConnector() : new botbuilder_azure.BotServiceConnector({
		    appId: process.env.MicrosoftAppId,
		    appPassword: process.env.MicrosoftAppPassword
		});

		var bot = new builder.UniversalBot(connector);

		bot.dialog('/', [

		function (session) {
		    builder.Prompts.text(session, "Hello, and welcome to QnA Factbot! What's your name?");
		},

		function (session, results) {
		    userName = results.response;
		    builder.Prompts.number(session, "Hi " + userName + ", how many years have you been writing code?");
		},

		function (session, results) {
		    yearsCoding = results.response;
		    builder.Prompts.choice(session, "What language do you love the most?", ["C#", "Python", "Node.js", "Visual FoxPro"]);
		},

		function (session, results) {
		    selectedLanguage = results.response.entity;

		    session.send("Okay, " + userName + ", I think I've got it:" +
		        " You've been writing code for " + yearsCoding + " years," +
		        " and prefer to use " + selectedLanguage + ".");
		}]);

		var restify = require('restify');
		var server = restify.createServer();

		server.listen(3978, function() {
		    console.log('test bot endpoint at http://localhost:3978/api/messages');
		});

		server.post('/api/messages', connector.listen());
   Set breakpoints on lines 20, 25, and 30 (builder.Prompts... calls) and run Debug.
   Launch "Bot Framework Emulator", enter "http://localhost:3978/api/messages" as endpoint URL and CONNECT > type Hi to test.
5. Connect the bot to the knowledge base
   Azure > App Service > Application settings >
     Set as below and Save.
     - QnAAuthKey = 7afbbc87-358f-4540-bda7-155dc3f92707
     - QnAKnowledgebaseId = 44926b26-0199-475c-a813-31e2f6efbea4
     - QnAEndpointHostName = oh0myqnaserv-kb-001.azurewebsites.net/qnamaker
   Edit app.js
		var restify = require('restify');
		var builder = require('botbuilder');
		var botbuilder_azure = require("botbuilder-azure");
		var builder_cognitiveservices = require("botbuilder-cognitiveservices");

		// Setup Restify Server
		var server = restify.createServer();
		server.listen(process.env.port || process.env.PORT || 3978, function () {
		    console.log('%s listening to %s', server.name, server.url);
		});

		// Create chat connector for communicating with the Bot Framework Service
		var connector = new builder.ChatConnector({
		    appId: process.env.MicrosoftAppId,
		    appPassword: process.env.MicrosoftAppPassword,
		    openIdMetadata: process.env.BotOpenIdMetadata
		});

		// Listen for messages from users
		server.post('/api/messages', connector.listen());

		var tableName = 'botdata';
		var azureTableClient = new botbuilder_azure.AzureTableClient(tableName, process.env['AzureWebJobsStorage']);
		var tableStorage = new botbuilder_azure.AzureBotStorage({ gzipData: false }, azureTableClient);

		// Create your bot with a function to receive messages from the user
		var bot = new builder.UniversalBot(connector);
		bot.set('storage', tableStorage);

		// Recognizer and and Dialog for preview QnAMaker service
		var previewRecognizer = new builder_cognitiveservices.QnAMakerRecognizer({
		    knowledgeBaseId: process.env.QnAKnowledgebaseId,
		    authKey: process.env.QnAAuthKey || process.env.QnASubscriptionKey
		});
		//Note: The call to create a QnAMakerDialog instance on line 30. This creates a dialog that integrates a bot built with the Azure Bot Service with a knowledge base built via Microsoft QnA Maker.

		var basicQnAMakerPreviewDialog = new builder_cognitiveservices.QnAMakerDialog({
		    recognizers: [previewRecognizer],
		    defaultMessage: 'No match! Try changing the query terms!',
		    qnaThreshold: 0.3
		}
		);

		bot.dialog('basicQnAMakerPreviewDialog', basicQnAMakerPreviewDialog);

		// Recognizer and and Dialog for GA QnAMaker service
		var recognizer = new builder_cognitiveservices.QnAMakerRecognizer({
		    knowledgeBaseId: process.env.QnAKnowledgebaseId,
		    authKey: process.env.QnAAuthKey || process.env.QnASubscriptionKey, // Backward compatibility with QnAMaker (Preview)
		    endpointHostName: process.env.QnAEndpointHostName
		});

		var basicQnAMakerDialog = new builder_cognitiveservices.QnAMakerDialog({
		    recognizers: [recognizer],
		    defaultMessage: "I'm not quite sure what you're asking. Please ask your question again.",
		    qnaThreshold: 0.3
		});

		bot.dialog('basicQnAMakerDialog', basicQnAMakerDialog);

		bot.dialog('/', //basicQnAMakerDialog);
		    [
		        function (session) {
		            var qnaKnowledgebaseId = process.env.QnAKnowledgebaseId;
		            var qnaAuthKey = process.env.QnAAuthKey || process.env.QnASubscriptionKey;
		            var endpointHostName = process.env.QnAEndpointHostName;

		            // QnA Subscription Key and KnowledgeBase Id null verification
		            if ((qnaAuthKey == null || qnaAuthKey == '') || (qnaKnowledgebaseId == null || qnaKnowledgebaseId == ''))
		                session.send('Please set QnAKnowledgebaseId, QnAAuthKey and QnAEndpointHostName (if applicable) in App Settings. Learn how to get them at https://aka.ms/qnaabssetup.');
		            else {
		                if (endpointHostName == null || endpointHostName == '')
		                    // Replace with Preview QnAMakerDialog service
		                    session.replaceDialog('basicQnAMakerPreviewDialog');
		                else
		                    // Replace with GA QnAMakerDialog service
		                    session.replaceDialog('basicQnAMakerDialog');
		            }
		        }
		    ]);
   > git add app.js
   NOTE: Do not include package.json. Its change is just for debugging.
   > git push -u origin master
   Azure portal > Web App Bot > Bot management > Test in Web Chat
- More resources
  There is much more that you can do to leverage the power of the Azure Bot Service by incorporating
  - Dialogs (http://aihelpwebsite.com/Blog/EntryId/9/Introduction-To-Using-Dialogs-With-The-Microsoft-Bot-Framework)
  - FormFlow (https://blogs.msdn.microsoft.com/uk_faculty_connection/2016/07/14/building-a-microsoft-bot-using-microsoft-bot-framework-using-formflow/)
  - Microsoft Language Understanding and Intelligence Services (LUIS, https://docs.botframework.com/node/builder/guides/understanding-natural-language/)
  - Online FAQ: https://docs.microsoft.com/en-us/azure/bot-service/bot-service-resources-bot-framework-faq?view=azure-bot-service-3.0
  - Use QnA Maker to answer questions - Bot Service | Microsoft Docs, https://docs.microsoft.com/en-us/azure/bot-service/bot-builder-howto-qna?view=azure-bot-service-4.0&tabs=cs
  - https://github.com/Microsoft/BotBuilder-Samples
- Microsoft QnA Maker(https://www.qnamaker.ai/) of https://www.microsoft.com/cognitive-services/
  - Usage scenario
    create a knowledge base from the URL of a FAQ page so the bot can answer domain-specific questions such as "How do I find my Windows product key" or "Where can I download Visual Studio Code?"
- Microsoft Bot Framework Emulator


### The Mojifier - Create a Slack bot that replaces people's faces with emojis matching their emotion
REF: https://docs.microsoft.com/en-us/learn/modules/replace-faces-with-emojis-matching-emotion/






# MISC
- https://labondemand.com/VirtualizationClient/




### azure functions

func azure login
func azure account

func azure functionapp list
func azure storage list

func azure functionapp fetch-app-settings hubaby

func init
func new
fun run HttpTriggerJS
	Access  http://localhost:7071/api/HttpTriggerJS?name=Pango

func run HttpTrigger-JS -c "{\"name\": \"Donna\"}"
func run HttpTrigger-JS -c "{\"name\": \"Donna\"}" --debug
launch.json
	{
		"version": "0.2.0",
		"configurations": [
			{
				"name": "Attach to Azure Functions",
				"type": "node",
				"request": "attach",
				"port": 5858
			}
		]
	}


func new --language JavaScript --template TimerTriggerJS --name HourlyGitty


#. function app x sendgrid
	SendGrid > Settings > API Keys > 
	Funtion Apps > select app > Application settings > add new Application settings: key=SendGrid, value=...


!!! SendGrid API
	TryFunctions:	Gu0yME-FRpuATu48MuoRsQ / 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


###. Services

Stream Analytics
	データを受け取ってからデータを書き込むまでにロジックが必要ならFunctions、ロジックが必要ないのならStream Analyticsというような選択になりそうです。

Service Bus Topic

Azure Storage queue


