
 "🤓"
# Tutorials

### The Mojifier - Create a Slack bot that replaces people's faces with emojis matching their emotion
REF: https://docs.microsoft.com/en-us/learn/modules/replace-faces-with-emojis-matching-emotion/

- Prerequisites
  - Euclidian distance, https://www.npmjs.com/package/euclidean-distance
  - Face API
    e.g. https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=false&returnFaceLandmarks=false&returnFaceAttributes=emotion
    header: Ocp-Apim-Subscription-Key: <your-subscription-key>
    body: {"url":"<path-to-image>"}
  - Mojifier code repo, https://github.com/MicrosoftDocs/mslearn-the-mojifier/blob/master/shared/faceapi/index.ts?
- Requirements & Specifications
  - /mojify <image to mojify>
  - use TypeScript, Azure Functions and Azure Cognitive Services
- Setup
  - Go to Azure Cognitive Services Face Service > Try Face > Sign In > Azure Portal >
    Create Face, fill in the information, F0 for pricing tier.
  > git clone https://github.com/MicrosoftDocs/mslearn-the-mojifier.git
  > cd mslearn-the-mojifier
  > npm install
  > npm run build
  ! Tested on Node.js v8
- Create an Azure Function project to run local Azure Functions
  Install VS Code with Azure Account extension and Azure Functions extension
  Command Palette > Azure Functions: Create New Project...., JavaScript as language
  Command Palette > Azure Functions: Create Function..., HTTP Trigger as function template, MojifyImage as function name, Anonymous as authentication level
  > npm i -g azure-cli
  > npm i -g azure-functions-core-tools --unsafe-perm true
  Terminal > `$Env:Path += ";D:\DEV\node"` > `func host start`
		Http Functions:
		      MojifyImage: [GET,POST] http://localhost:7071/api/MojifyImage
  Open http://localhost:7071/api/MojifyImage
  Edit settings.json
	{
		...
		"terminal.integrated.env.windows": {
			"PATH": "${env:PATH};${workspaceRoot}\\node_modules\\.bin;D:\\DEV\\node"
		}
	}
  Debug > Attach to JavaScript Functions to try the debugger.
- Create the MojifyImage Azure function


TODO: https://docs.microsoft.com/en-us/learn/modules/replace-faces-with-emojis-matching-emotion/5-create-the-mojifyimage-azure-function





https://codingbat.com/prob/p145416



https://api.slack.com/slack-apps
Create a new Slack app using Botkit Studio and Glitch - …

https://x-team.com/blog/create-slack-app-in-3-minutes/
https://yosiakatsuki.net/blog/create-slack-app-github/