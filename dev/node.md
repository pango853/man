


# Express

TODO ...


# Real-time App with Feathers
$ npm install -g @feathersjs/cli

$ mkdir featherApp01
$ cd featherApp01
$ feathers generate app
$ npm start


# Cross-platform Apps
## NW.js

```package.json
{
  "name": "helloworld",
  "main": "index.html"
  }
}
```

```index.html
<!DOCTYPE html>
<html>
  <head>
    <title>Hello World!</title>
  </head>
  <body>
    <h1>Hello World!</h1>
  </body>
</html>
```

> nw .

> npm install nwjs-builder-phoenix --save-dev
> node_modules\.bin\build --win --x86 .


## Electron

> git clone https://github.com/electron/electron-quick-start
> cd electron-quick-start
> npm install

> npm start

> npm i -D electron-packager
> ./node_modules/.bin/electron-packager --platform=win32 --arch=ia32 --prune --asar=true --out=releases .
OR
> npx electron-packager . FirstApp --platform=win32 --arch=x64 --overwrite
> npx electron-packager . FirstApp --platform=darwin --arch=x64 --overwrite

```package.json
{
  "scripts": {
    "start": "electron ./src",
    "build-macOS": "electron-packager ./src FirstApp --platform=darwin --arch=x64 --overwrite",
    "build-windows": "electron-packager ./src FirstApp --platform=win32 --arch=x64 --overwrite"
  },
  "devDependencies": {
    "electron": "^4.0.0",
    "electron-packager": "^13.0.1"
  },
  "private": true
}
```


### With Next.js

REF: https://leo.im/2017/electron-next
REF: https://github.com/zeit/next.js

> git clone https://github.com/electron/electron-quick-start
> cd electron-quick-start
> npm install

> npm install next@beta react react-dom --save-dev
> npm install electron-next electron-is-dev --save

> npm start

> mkdir renderer && cd renderer
> vim pages\start.js
```
export default () => (
  <span>This is Next.js speaking</span>
)
```

> vim next.config.js
```
module.exports = {
  webpack(config) {
    // Allows you to load Electron modules and
    // native Node.js ones into your renderer
    config.target = 'electron-renderer'
    return config
  },
  exportPathMap() {
    // Let Next.js know where to find the entry page
    // when it's exporting the static bundle for the use
    // in the production version of your app
    return {
      '/start': { page: '/start' }
    }
  }
}
```

## Meteor

> choco install meteor

> meteor create simple-todos

cd simple-todos
npm install
meteor

git clone git@github.com:meteor/simple-todos-react.git
cd simple-todos-react
meteor npm install
meteor


meteor create --react new-react-app
cd new-react-app
meteor



### Meteor + Eletron

REF: https://github.com/electron-webapps/meteor-electron

// https://packages.meteor.com/bootstrap-link?arch=os.windows.x86_64
// %TEMP%\chocolatey\meteor\0.0.2\
// %ALLUSERSPROFILE%\chocolatey\extensions

TODO...

## Proton Native

REF: https://proton-native.js.org/#/quickstart

First may need to install windows-build-tools to compile libui-node correctly.
Run as Administrator:
> npm install --global --production windows-build-tools

> npm install -g node-gyp

Install the cli app
> npm install -g create-proton-app

Create your project
> create-proton-app app01

Move to your project directory and run the project
> cd app01
> npm run start
OR
> npx app01