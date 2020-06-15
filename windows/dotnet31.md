# Web apps


# Web API apps


# Real-time web apps
REF:
	- https://docs.microsoft.com/en-us/aspnet/core/tutorials/signalr-blazor-webassembly?view=aspnetcore-3.1&tabs=visual-studio-code
	- https://github.com/dotnet/AspNetCore.Docs/tree/master/aspnetcore/tutorials/signalr-blazor-webassembly/samples/

1. Create a Blazor WebAssembly Hosted app project

	dotnet new -i Microsoft.AspNetCore.Components.WebAssembly.Templates::3.2.0-preview2.20160.5
	dotnet new blazorwasm --hosted --output BlazorSignalRApp
	
	Add the SignalR client library
	dotnet add Client package Microsoft.AspNetCore.SignalR.Client

	Add a SignalR hub
	mkdir Hubs
	```Hubs/ChatHub.cs):
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Threading.Tasks;
	using Microsoft.AspNetCore.SignalR;

	namespace BlazorSignalRApp.Server.Hubs
	{
		public class ChatHub : Hub
		{
			public async Task SendMessage(string user, string message)
			{
				await Clients.All.SendAsync("ReceiveMessage", user, message);
			}
		}
	}
	```

	Add SignalR services and an endpoint for the SignalR hub
	```Startup.cs 
using BlazorSignalRApp.Server.Hubs;

// Startup.ConfigureServices:
services.AddSignalR();

// Startup.Configure
app.UseEndpoints(endpoints =>
{
    endpoints.MapDefaultControllerRoute();
    endpoints.MapHub<ChatHub>("/chatHub");
    endpoints.MapFallbackToClientSideBlazor<Client.Program>("index.html");
});
	```
5. Add Razor component code for chat
```Pages/Index.razor
@using Microsoft.AspNetCore.SignalR.Client
@inject NavigationManager NavigationManager

<div class="form-group">
    <label>
        User:
        <input @bind="_userInput" />
    </label>
</div>
<div class="form-group">
    <label>
        Message:
        <input @bind="_messageInput" size="50" />
    </label>
</div>
<button @onclick="Send" disabled="@(!IsConnected)">Send</button>

<hr>

<ul id="messagesList">
    @foreach (var message in _messages)
    {
        <li>@message</li>
    }
</ul>

@code {
    private HubConnection _hubConnection;
    private List<string> _messages = new List<string>();
    private string _userInput;
    private string _messageInput;

    protected override async Task OnInitializedAsync()
    {
        _hubConnection = new HubConnectionBuilder()
            .WithUrl(NavigationManager.ToAbsoluteUri("/chatHub"))
            .Build();

        _hubConnection.On<string, string>("ReceiveMessage", (user, message) =>
        {
            var encodedMsg = $"{user}: {message}";
            _messages.Add(encodedMsg);
            StateHasChanged();
        });

        await _hubConnection.StartAsync();
    }

    Task Send() =>
        _hubConnection.SendAsync("SendMessage", _userInput, _messageInput);

    public bool IsConnected =>
        _hubConnection.State == HubConnectionState.Connected;
}
```

cd Server
dotnet run




# Remote Procedure Call apps

REF:
	1. https://docs.microsoft.com/en-us/aspnet/core/tutorials/grpc/grpc-start?view=aspnetcore-3.1&tabs=visual-studio-code
	2. https://docs.microsoft.com/en-us/aspnet/core/grpc/basics?view=aspnetcore-3.1

https://github.com/dotnet/AspNetCore.Docs/tree/master/aspnetcore/tutorials/grpc/grpc-start/sample


- Create a gRPC Server
	dotnet new grpc -o GrpcGreeter
	//code -r GrpcGreeter

	dotnet run
	open https://localhost:5001

- Create a gRPC client
	dotnet new console -o GrpcGreeterClient
	//code -r GrpcGreeterClient

	dotnet add GrpcGreeterClient.csproj package Grpc.Net.Client
	dotnet add GrpcGreeterClient.csproj package Google.Protobuf
	dotnet add GrpcGreeterClient.csproj package Grpc.Tools

	mkdir Protos
	copy ..\GrpcGreeter\Protos\greet.proto Protos\


```GrpcGreeterClient.csproj
<ItemGroup>
  <Protobuf Include="Protos\greet.proto" GrpcServices="Client" />
</ItemGroup>
```

```Program.cs
	using System;
	using System.Net.Http;
	using System.Threading.Tasks;
	using GrpcGreeter;
	using Grpc.Net.Client;

	namespace GrpcGreeterClient
	{
		class Program
		{
			static async Task Main(string[] args)
			{
				// The port number(5001) must match the port of the gRPC server.
				using var channel = GrpcChannel.ForAddress("https://localhost:5001");
				var client =  new Greeter.GreeterClient(channel);
				var reply = await client.SayHelloAsync(
								  new HelloRequest { Name = "GreeterClient" });
				Console.WriteLine("Greeting: " + reply.Message);
				Console.WriteLine("Press any key to exit...");
				Console.ReadKey();
			}
		}
	}
```
	dotnet run
	dotnet dev-certs https --trust
	dotnet run



- Test the gRPC client service with the gRPC Greeter service


# Data Access



# Queue

> dotnet add package RabbitMQ.Client --version 5.1.2

https://www.rabbitmq.com/dotnet-api-guide.html
