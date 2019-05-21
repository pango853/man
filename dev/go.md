
# Statement

## The blank identifier

import _ "log"

_, execFile := filepath.Split("/opt/data/bigdata.txt")


## Built-in identifiers

Types:
- Numeric: byte, int, int8, int16, int32, int64, rune, uint, uint8, uint16, uint32, uint64, float32, float64, complex64, complex128, uintptr
- String: string
- Boolean: bool
- Error: error
Values:
- Boolean constants: true, false
- Constant counter: iota
- Uninitialized value: nil
Functions:
- Initialization: make(), new()
- Collections: append(), cap(), copy(), delete()
- Complex numbers: complex(), imag(), real()
- Error Handling: panic(), recover()

## Variable declaration block
```go
var (
  name string = "Earth"
  desc string = "Planet"
  radius int32 = 6378
  mass float64 = 5.972E+24
  active bool = true
  satellites []string
)
```

## Constant declaratoin block
```go
const (
  a1, a2 string        = "Mastering", "Go"
  b      rune          = 'G'
  c      bool          = false
  d      int32         = 111009
  e      float32       = 2.71828
  f      float64       = math.Pi * 2.0e+3
  g      complex64     = 5.0i
  h      time.Duration = 4 * time.Second
...
)
```

## Constant enumeration
```go
const (
  StarHyperGiant = iota
  StarSuperGiant
  StarBrightGiant
  StarGiant
  StarSubGiant
  StarDwarf
  StarSubDwarf
  StarWhiteDwarf
  StarRedDwarf
  StarBrownDwarf
)
```

## Variadic parameters
```go
func sum(numbers ...int) float64{return 0.0}

numbers = []int{1, 2, 3, 4, 5}
sum(numbers...)
```

## Anonymous Functions
```go
var (
	mul = func(a,b int) int { return a*b }
	sqr = func(a, int) int {return mul(a,a)}
)
```

```go
fmt.Printf("a x b = %d\n",
	func(a, b int) int{ return a*b }(1, 2)
)
```

## Closures
```go
rad := func() int{
	return i_non_local_variable * math.Pi / 180
}()
```

## Objects
- Object
- Composition
- Subtype via interface
- Modularity and encapsulation
- Type inheritance: NOT SUPPORTED
- Classes: NOT SUPPORTED

# Test
$> cd PACKAGENAME
$> go test .

# Documentation
$> godoc -http=":6001"
http://localhost:6001/pkg/github.com/vladimirvivien/learning-go/ch01/testexample/

# Toolchain
- fmt: Reformats source code to adhere to the standard
- vet: Reports improper usage of source code constructs
- lint: Another source code tool that reports flagrant style infractions
- goimports: Analyzes and fixes package import references in source code
- godoc: Generates and organizes source code documentation
- generate: Generates Go source code from directives stored in source code
- get: Remotely retrieves and installs packages and their dependencies
  go get github.com/
- build: Compiles code in a specified package and its dependencies
- run: Provides the convenience of compiling and running your Go program
- test: Performs unit tests with support for benchmark and coverage reports
- oracle static analysis tool: Queries source code structures and elements
- cgo: Generates source code for interoperability between Go and C

# Packages
- bufio
- bytes
- errors
- flag
- fmt
- io/ioutil
- math/rand
- os
- unsafe

# Data types
- string
- rune
- byte, int, int8/16/32/64, rune, uint, uint8/16/32/64, uintptr
- float32/64
- complex64/128
- bool
- *T: pointer to type T
- Composite Types
  - Array [n]T
  - Slice[]T
  - struct{}
  - map[K]T
- interface{}
- func (T) R
- chan T

# fmt
- %T: type
- %v: value?
- %d: digits

# Workspace
/*$HOME*/Go/
- bin
  - circ
  - golint
  ...
- pkg
  - linux_amd64
    - github.com
      - golang
        - lint.a
      - *$USER*
        - learning-go
          - ch06
            - current.a
            ...
    ...
- src
  - github.com
    - golang
      - lint
        - golint
          - golint.go
  ...
  - *$USER*
    - learning-go
...

# Build and Package

$> cd $GOPATH/src/github.com/*$USER*/*$PROJECT*/*SUB*/*SUBSUB*
$> go build .
OR
$> cd $GOPATH/src
$> go build github.com/*$USER*/*$PROJECT*/*SUB*/*SUBSUB*


$> cd $GOPATH/src/github.com/*$USER*/*$PROJECT*/*SUB*
$> go install ./*SUBSUB*

=> $GOPATH/pkg/linux_amd64/github.com/*$USER*/*$PROJECT*/*SUB*/*SUBSUB*.a

# Concurrency
- Goroutines
  > go func(){...}()
- Channels
  > ch := make(chan int, 4) // buffered
  > ch := make(chan int)    // unbuffered
  > close(ch)
  > val, opened := <-ch
- The sync package
- Detecting race conditions
- Parallelism in Go

# MISC
- math.Pi
- time.Millisecond
- time.Now().UnixNano()
- rand.New(rand.NewSource(123456)).Intn(100)
- strings.Contains(str, "abc")
- i := val.(type)
- unsafe.Sizeof(i)
- defer file.Close()
- http://golang.org/src/os/error.go
- file, err := os.OpenFile(fname, os.O_WRONLY+os.O_CREATE+os.O_EXCL, 0644)
- os.Args
- func init()
- panic(fmt.Sprintf("Slot %d taken", val))
- fmt.Errorf("Key not found!")

# MEMO
FIXME:
	Table of Contents
	1: A First Step in Go
	2: Go Language Essentials
	3: Go Control Flow
	4: Data Types							178/2030
	5: Functions in Go						215
	6: Go Packages and Programs			260
	7: Composite Types					311
	8: Methods, Interfaces, and Objects	375
	9: Concurrency						410/2030 = 20.19%
10: Data IO in Go					462
11: Writing Networked Services		517
12: Code Testing					567

13: Ready... Steady... Go!			616
14: Creational Patterns - Singleton, Builder, Factory, Prototype, and Abstract Factory Design Patterns
15: Structural Patterns - Composite, Adapter, and Bridge Design Patterns
16: Structural Patterns - Proxy, Facade, Decorator, and Flyweight Design Patterns
17: Behavioral Patterns - Strategy, Chain of Responsibility, and Command Design Patterns
18: Behavioral Patterns - Template, Memento, and Interpreter Design Patterns
19: Behavioral Patterns - Visitor, State, Mediator, and Observer Design Patterns
20: Introduction to Gos Concurrency
21: Concurrency Patterns - Barrier, Future, and Pipeline Design Patterns
22: Concurrency Patterns - Workers Pool and Publish/Subscriber Design Patterns
23: Chat Application with Web Sockets			
24: Adding User Accounts						
25: Three Ways to Implement Profile Pictures	
26: Command-Line Tools to Find Domain Names		
27: Building Distributed Systems and Working with Flexible Data
28: Exposing Data and Functionality through a RESTful Data Web Service API
29: Random Recommendations Web Service
30: Filesystem Backup
31: Building a Q&A Application for Google App Engine
32: Micro-services in Go with the Go kit Framework
33: Deploying Go Applications Using Docker
