
# HelloWorld

https://download.visualstudio.microsoft.com/download/pr/33b3cfa9-905d-4386-8854-ef05010efb25/d54f0d42b92d2e4079013ae5faac7745/dotnet-sdk-3.1.102-win-x64.zip
https://download.visualstudio.microsoft.com/download/pr/6cc3f6a7-3a0f-441c-82a2-104fa93ef8b6/3c1395461545eb5321eb2816d4b3fecf/aspnetcore-runtime-3.1.2-win-x64.zip
https://download.visualstudio.microsoft.com/download/pr/12c4e2f0-eda2-42ca-908e-fcdb68550a5f/ca19066eba7c09b8c781ae7a84a7ba8d/dotnet-runtime-3.1.2-win-x64.zip


dotnet new console -o myApp
cd myApp
```Program.cs
using System;

namespace myApp
{
    class Program
    {
        static void Main(string[] args)
        {
Console.WriteLine("Hello World!");
Console.WriteLine("The current time is " + DateTime.Now);
        }
    }
}
```
dotnet run
cd ..

mkdir numbers-quickstart
cd numbers-quickstart
dotnet new console -n NumbersInCSharp -o .
```https://github.com/dotnet/samples/blob/master/csharp/numbers-quickstart/Program.cs#L104-L106
int a = 18;
int b = 6;
int c = a + b;
Console.WriteLine(c);
```



https://dotnet.microsoft.com/download/dotnet-core/3.0

https://github.com/dotnet/core-setup
https://github.com/dotnet/core-sdk

dotnet new winforms
OR
dotnet new wpf

dotnet run


# How to port desktop applications to .NET Core 3.0 | .NET Blog
@ref https://www.youtube.com/watch?v=upVQEUc_KwU
@ref https://github.com/OliaG/matching-game


# Getting Started with .NET Core 3
Create a WPF Application

https://github.com/dotnet/core-setup

https://github.com/dotnet/core-sdk

```MyCore3App.csproj
    <Project Sdk="Microsoft.NET.Sdk.WindowsDesktop">
      <PropertyGroup>
        <OutputType>WinExe</OutputType>
        <TargetFramework>netcoreapp3.0</TargetFramework>
        <UseWPF>true</UseWPF>
        <AssemblyName>MyCore3App</AssemblyName>
      </PropertyGroup>
      <ItemGroup>
      
      <ItemGroup>
    </Project>
```