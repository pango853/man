

- try.fsharp.org
- tryfsharp.fsbolero.io
- https://fsharp.org/learn/
- https://hub-binder.mybinder.ovh/user/dotnet-interactive-guh2pxgc/lab

Run F# Interactive in console
	.\dotnet\sdk\sdk\5.0.103\FSharp\fsi.exe
```
> let i = 1 // fsi prompt, declare i
- let j = 2 // declare j
- i+j // compose expression
- ;; // execute commands

val i : int = 1 // fsi output started, this gives the value of i
val j : int = 2 // the value of j
val it : int = 3 // computed expression

> #help;; // for help
> #quit;; // quit fsi
```

https://fsharp.org/use/windows/

```hello.fsx
printfn "Hello World from F#"
```
dotnet fsi hello.fsx

dotnet new console --language F#
dotnet run




dotnet new sln -o FSNetCore

dotnet new classlib -lang "F#" -o src/Library
dotnet add src/Library/Library.fsproj package Newtonsoft.Json
dotnet sln add src/Library/Library.fsproj

dotnet new console -lang "F#" -o src/App
```Program.fs
open System
open Library

[<EntryPoint>]
let main argv =
    printfn "Nice command-line arguments! Here's what JSON.NET has to say about them:"

    for arg in argv do
        let value = getJsonNetJson arg
        printfn $"{value}"

    0 // return an integer exit code
```
dotnet add src/App/App.fsproj reference src/Library/Library.fsproj
dotnet sln add src/App/App.fsproj

cd src/App
dotnet run Hello World




# Dict

- `let mutable ...`
- `printf $"\n{sampleTableOfSquares}"`
- `let string3 = @"use @ to create a verbatim string literal like C:\Program Files\"`
