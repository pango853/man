

# For VSCode

Mojibake problem solution:
- "plantuml.commandArgs": ["-Dfile.encoding=UTF-8"] 
- "plantuml.jarArgs": ["-charset", "UTF-8"]

Equals to
> java -Dfile.encoding=UTF-8 -jar plantuml.jar -charset UTF-8 <実行するファイル>
