
# GraalVM
https://github.com/oracle/graal

> docker pull oracle/graalvm-ce:19.0.2
docker run -it oracle/graalvm-ce:19.0.2 bash
	bash-4.2# java -version
	# node
		> 1 + 1
		2
		> process.exit()
	bash-4.2# lli --version
	bash-4.2# gu install ruby		// currently experimental
	bash-4.2# gu install python		// currently experimental

docker run -it -v /absolute/path/to/dir/no/trailing/slash:/path/inside/container oracle/graalvm-ce:19.0.2 bash

```Dockerfile
FROM oracle/graalvm-ce:19.0.2
RUN gu install ruby
WORKDIR /workdir
RUN echo 'puts "Hello from Truffleruby!\nVersion: #{RUBY_DESCRIPTION}"' > app.rb
CMD ruby app.rb
```
docker build -t truffleruby-demo .
docker run -it --rm truffleruby-demo

```HelloWorld.java
public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("Hello, World!");
  }
}
```
$ javac HelloWorld.java
$ native-image HelloWorld
$ ./helloworld

```rettyPrintJSON.java
import java.io.*;
import java.util.stream.*;
import org.graalvm.polyglot.*;

public class PrettyPrintJSON {
  public static void main(String[] args) throws java.io.IOException {
    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
    String input = reader.lines().collect(Collectors.joining(System.lineSeparator()));
    try (Context context = Context.create("js")) {
      Value parse = context.eval("js", "JSON.parse");
      Value stringify = context.eval("js", "JSON.stringify");
      Value result = stringify.execute(parse.execute(input), null, 2);
      System.out.println(result.asString());
    }
  }
}
```
$ javac PrettyPrintJSON.java
$ native-image --language:js --initialize-at-build-time PrettyPrintJSON
$ ./prettyprintjson <<EOF
{"GraalVM":{"description":"Language Abstraction Platform","supports":["combining languages","embedding languages","creating native images"],"languages": ["Java","JavaScript","Node.js", "Python", "Ruby","R","LLVM"]}}
EOF




for Windows:
	Windows GraalVM Early Adopter, https://www.oracle.com/technetwork/graalvm/downloads/index.html




# Tutorials

## Creating Your First Application

### Architecture:
	(BROWSER) --> GREETING RESOURCE --> GREETING SERVICE

### Bootstrapping a project
```
mvn io.quarkus:quarkus-maven-plugin:0.18.0:create \
    -DprojectGroupId=org.acme \
    -DprojectArtifactId=getting-started \
    -DclassName="org.acme.quickstart.GreetingResource" \
    -Dpath="/hello"
```
OR
`git clone https://github.com/quarkusio/quarkus-quickstarts.git` and the solutoin is in getting-started directory.

Dockerfile for native mode can be found at .\src\main\docker\Dockerfile.native

### Creating a JAX-RS endpoint

You can find one example of the JAX-RS resources at src/main/java/org/acme/quickstart/GreetingResource.java.

TIPS: Different with vanilla JAX-RS, with Quarkus, there is no need to create an Application class.
      Only one instance of the resource is created and not one per request by default, but it can be configured using different *Scoped annotations (ApplicationScoped, RequestScoped, etc).


Run the applicaion as below.
`./mvnw compile quarkus:dev`

TIPS: **quarkus:dev** runs Quarkus in development mode which enables hot deployment. This will also listen for a debugger on port 5005. Use -Ddebug=false to disable it if you don't want it at all.

### Injecting beans
Dependency injection is based on ArC, which is a CDI-based dependency injection solution tailored for Quarkus architecture.
ArC comes as a dependency of quarkus-resteasy.

src/main/java/org/acme/quickstart/GreetingService.java
src/main/java/org/acme/quickstart/GreetingResource.java

curl http://localhost:8080/hello/greeting/quarkus to check if "hello quarkus" is shown.

TODO: Contexts and Dependency Injection guide, https://quarkus.io/guides/cdi-reference.html.

### Functional tests
test dependencies:
- quarkus-junit5
- io.rest-aaured:rest-assured

TIPS: If you are using JUnit 5, the version of the Surefire Maven Plugin must be set as the default version does not support JUnit 5.
```pom.xml
<plugin>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>${surefire-plugin.version}</version>
    <configuration>
       <systemProperties>
          <java.util.logging.manager>org.jboss.logmanager.LogManager</java.util.logging.manager>
       </systemProperties>
    </configuration>
</plugin>
```

`./mvnw test`

See src/test/java/org/acme/quickstart/GreetingResourceTest.java for test cases.
By using the QuarkusTest runner, JUnit will actually start the application before the tests.

### Packaging of the application

`./mvnw package`
- getting-started-1.0-SNAPSHOT.jar
- getting-started-1.0-SNAPSHOT-runner.jar // Executable jar but not fat jar. Its dependencies are in target/lib directory.

### Others
For an async version, use CompletionStage as return type to handle asynchronous actions in the resource. See getting-started-async subfolder.

## Build a native executable

@prereq
- GraalVM installed from the GraalVM web site. Using the community edition is enough. Version 19.0.2 is required.
- `export GRAALVM_HOME=$HOME/DEV/graalvm/`
- `gu install native-image` to install native-image tool
- C development env. `dnf install gcc glibc-devel zlib-devel` or `apt-get install build-essential libz-dev`
- Use source at https://quarkus.io/guides/getting-started-guide.html








TODO: tooling guide, https://quarkus.io/guides/tooling.html


# Dictionary

- Quarkus BOM (io.quarkus:quarkus-bom)	Import in pom.xml to omit the version on the different Quarkus dependencies.
- quarkus-maven-plugin	responsible of the packaging of the application and also providing the development mode.

# TODO
- With Java 9 and specifically the JEP 295, the JDK got an ahead-of-time compiler jaotc which uses the OpenJDK project Graal for backend code-generation.
	jaotc --output libHelloWorld.so HelloWorld.class
	jaotc --output libjava.base.so --module java.base
	java -XX:AOTLibrary=./libHelloWorld.so,./libjava.base.so HelloWorld

