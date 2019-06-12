
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