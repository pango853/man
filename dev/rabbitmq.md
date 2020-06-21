

# 事例
- MQがなかったら、
	Service A --(request)--> Service B --> Service C1,C2,C3
	- How about Service B is DOWN (even for a while)!	=> Task/Data lost
	- How about Service C4 is added to Service C1,C2,C3,C4?		=> Service B re-config
	With MQ,
	Service A --(request)--> MQ --> Service B --> MQ --> Service C1,C2,C3
	- Queuing up
	- Join as consumer/subscriber to MQ

大規模分散システムのモデルを単純化できる
- システムを High Available にできる
- システムを Scalable にできる

メッセージキューを利用した非同期アーキテクチャの導入:
- タスクをキューイングする事で、ワークロードの spike を無くしたい
- 複数のワーカーで1つのキューを処理して、負荷分散を行いたい
- イベントドリブンアーキテクチャを実現して、マイクロサービス間での関心事を分離したい




# 各種プロトコルと実装について
			Queuing Pub/Sub
- AMQP (RabbitMQ) ◯ ◯
- MQTT (ActiveMQ) ❌ ◯
- STOMP (NewtMQ) ◯ △
- Kafka ◯ ◯

# 運用




# jargon

- producing		means sending message
- producer		A program that sends messages
- queue			A queue is the name for a post box which lives inside RabbitMQ that messages store in.
- consuming		receiving
- consumer 		a program that mostly waits to receive messages
- broker		rabbitmq in this case


# Methods

## Hello World
	- 2 programs
	- a producer that sends a single message, and a consumer that receives messages and prints them out.

REF: https://github.com/rabbitmq/rabbitmq-tutorials/

dotnet new console --name Send
mv Send/Program.cs Send/Send.cs
dotnet new console --name Receive
mv Receive/Program.cs Receive/Receive.cs

cd Send
dotnet add package RabbitMQ.Client
dotnet restore
cd ../Receive
dotnet add package RabbitMQ.Client
dotnet restore

```https://github.com/rabbitmq/rabbitmq-tutorials/blob/master/dotnet/Send/Send.cs
using System;
using RabbitMQ.Client;
using System.Text;

class Send
{
    public static void Main()
    {
        var factory = new ConnectionFactory() { HostName = "localhost" };
        using(var connection = factory.CreateConnection())
        using(var channel = connection.CreateModel())
        {
            channel.QueueDeclare(queue: "hello",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);

            string message = "Hello World!";
            var body = Encoding.UTF8.GetBytes(message);

            channel.BasicPublish(exchange: "",
                                 routingKey: "hello",
                                 basicProperties: null,
                                 body: body);
            Console.WriteLine(" [x] Sent {0}", message);
        }

        Console.WriteLine(" Press [enter] to exit.");
        Console.ReadLine();
    }
}
```

```https://github.com/rabbitmq/rabbitmq-tutorials/blob/master/dotnet/Receive/Receive.cs
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Text;

class Receive
{
    public static void Main()
    {
        var factory = new ConnectionFactory() { HostName = "localhost" };
        using(var connection = factory.CreateConnection())
        using(var channel = connection.CreateModel())
        {
            channel.QueueDeclare(queue: "hello",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);

            var consumer = new EventingBasicConsumer(channel);
            consumer.Received += (model, ea) =>
            {
                var body = ea.Body;
                var message = Encoding.UTF8.GetString(body);
                Console.WriteLine(" [x] Received {0}", message);
            };
            channel.BasicConsume(queue: "hello",
                                 autoAck: true,
                                 consumer: consumer);

            Console.WriteLine(" Press [enter] to exit.");
            Console.ReadLine();
        }
    }
}
```
	cd Receive
	dotnet run

	cd Send
	dotnet run

## Work Queues

dotnet new console --name NewTask
mv NewTask/Program.cs NewTask/NewTask.cs
dotnet new console --name Worker
mv Worker/Program.cs Worker/Worker.cs
cd NewTask
dotnet add package RabbitMQ.Client
dotnet restore
cd ../Worker
dotnet add package RabbitMQ.Client
dotnet restore


```NewTask.cs
var message = GetMessage(args);
var body = Encoding.UTF8.GetBytes(message);

var properties = channel.CreateBasicProperties();
properties.Persistent = true;

channel.BasicPublish(exchange: "",
                     routingKey: "task_queue",
                     basicProperties: properties,
                     body: body);


private static string GetMessage(string[] args)
{
    return ((args.Length > 0) ? string.Join(" ", args) : "Hello World!");
}
```

```Worker.cs
var consumer = new EventingBasicConsumer(channel);
consumer.Received += (model, ea) =>
{
    var body = ea.Body;
    var message = Encoding.UTF8.GetString(body);
    Console.WriteLine(" [x] Received {0}", message);

    int dots = message.Split('.').Length - 1;
    Thread.Sleep(dots * 1000);						// Fake task. Just sleep here

    Console.WriteLine(" [x] Done");

	// Message acknowledgment: to prevent message lose
    // Note: it is possible to access the channel via ((EventingBasicConsumer)sender).Model here
    channel.BasicAck(deliveryTag: ea.DeliveryTag, multiple: false);
};
channel.BasicConsume(queue: "task_queue", autoAck: false, consumer: consumer);
//channel.BasicConsume(queue: "task_queue", autoAck: true, consumer: consumer); // Turn off autoAck to use Message acknowledgment

```

cd Worker
dotnet run

cd Worker
dotnet run

# shell 3
cd NewTask
dotnet run "First message."
dotnet run "Second message.."
dotnet run "Third message..."
dotnet run "Fourth message...."
dotnet run "Fifth message....."


- Debugging forgotten acknowledgment:
  > sudo rabbitmqctl list_queues name messages_ready messages_unacknowledged

- Message durability - even if the consumer dies, the task isn't lost -- queue won't be lost even if RabbitMQ restarts
```
channel.QueueDeclare(queue: "hello",
                     durable: true,			// declare queue as durable. NOTE that rabbitmq won't redefine an existing queue!!! You can simply rename as a new one.
                     exclusive: false,
                     autoDelete: false,
                     arguments: null);
```
```
var properties = channel.CreateBasicProperties();
properties.Persistent = true;				// mark our messages as persistent as well => message persistence. NOTE that  it tells RabbitMQ to save the message to disk, but not fully guaranteed. e.g. RabbitMQ don't do fsync(2) every time. For stronger guarantee see https://www.rabbitmq.com/confirms.html
```

- Fair dispatch
```
channel.BasicQos(prefetchSize: 0, prefetchCount: 1, global: false);		// tells RabbitMQ not to give more than one message to a worker at a time.
```





# Installation
yum install erlang
rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
rpm --import https://packagecloud.io/gpg.key


rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc
```
[bintray-rabbitmq-server]
name=bintray-rabbitmq-rpm
baseurl=https://dl.bintray.com/rabbitmq/rpm/rabbitmq-server/v3.8.x/el/8/
gpgcheck=0
repo_gpgcheck=0
enabled=1
```

rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc
OR
rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.3/rabbitmq-server-3.8.3-1.el8.noarch.rpm
yum install rabbitmq-server-3.8.3-1.el8.noarch.rpm

service rabbitmq-server start


rabbitmqctl status
cat /proc/$RABBITMQ_BEAM_PROCESS_PID/limits

ulimit -S -n 4096


checks if the local node is running and CLI tools can successfully authenticate with it
> sudo rabbitmq-diagnostics ping

prints enabled components (applications), TCP listeners, memory usage breakdown, alarms and so on
> sudo rabbitmq-diagnostics status

prints effective node configuration
> sudo rabbitmq-diagnostics environment

performs a more extensive health check of the local node
> sudo rabbitmq-diagnostics node_health_check



sudo journalctl --system | grep rabbitmq

