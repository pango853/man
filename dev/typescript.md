

TypeScriptはCoffeeScrtiptなどと同様に「altJS」と呼ばれるJavaScriptの代替となるプログラミング言語です。JavaScriptの弱い部分を補うように設計されていて、JavaScriptにコンパイルして使用します。Microsoftによって開発が進められています。

$ npm install -g typescript
OR
$ npm install typescript --save-dev

$ tsc helloworld.ts

# Use with Grunt

// $ npm install -g grunt-cli

$ npm install grunt-typescript --save-dev
$ npm install grunt-contrib-watch --save-dev
$ mkdir ts && cd mkdir && touch function.ts

```Gruntfile.js
module.exports = function (grunt) {

  grunt.initConfig({

    // typescriptタスクの定義
    typescript: {
      // tsターゲットの定義
      ts: {
        // ファイルの設定
        files: {
          // コンパイル後のjsファイル: コンパイル前のtsファイル
          'ts/function.js': 'ts/function.ts'
        }
      }
    },

    // watchタスクの定義
    watch: {
      // tsターゲットの定義
      ts: {
        files: ['ts/*.ts'], // 監視するファイル
        tasks: ['typescript'] // 実行するタスク
      }
    }

  });

  // 使用するGruntプラグインを読み込む
  grunt.loadNpmTasks('grunt-typescript');
  grunt.loadNpmTasks('grunt-contrib-watch');
```

$ grunt watch

As another alternative, you can also use gulp.


```ts/function.js
/// <reference path="../lib/jquery.d.ts" />
// FROM https://github.com/borisyankov/DefinitelyTyped/tree/master/jquery
// 型定義ファイルを入手したら、プロジェクト内の任意のフォルダ内にファイルを置き、tsファイルの1行目に以下のように記述し、型定義ファイルを読み込むようにします。

$(document).ready(() => {
  alert("jQuery!!");
});
```

`ts/function.js` will be generate after converted.

# Type definition

$ npm install tsd -g

$ tsd init
$ tsd query jquery --action install --resolve --save

Then just:
```*.ts
	/// <reference path="../typings/tsd.d.ts" />
```

# Syntax check

$ npm install tslint -g

$ tslint -f ts/function.ts

Rules:
$ cd ~
$ wget https://github.com/palantir/tslint/blob/master/tslint.json

$ tslint -f ts/function.ts

# Automation with grunt

$ npm install grunt-tslint --save-dev

```Gruntfile.js
module.exports = function (grunt) {

  grunt.initConfig({

    // typescriptタスクの定義
    typescript: {
      // tsターゲットの定義
      ts: {
        // ファイルの設定
        files: {
          // コンパイル後のjsファイル: コンパイル前のtsファイル
          'ts/function.js': 'ts/function.ts'
        }
      }
    },

    // tslintタスクを定義
    tslint: {
      // tsターゲットを定義
      ts: {
        // tslint.jsonファイルの読み込み
        options: {
          configuration: grunt.file.readJSON('tslint.json')
        },
        // 構文チェックするファイルの設定
        files: {
          src: ['ts/function.ts']
        }
      }
    },

    // watchタスクの定義
    watch: {
      // tsターゲットの定義
      ts: {
        files: ['ts/*.ts'], // 監視するファイル
        tasks: ['typescript', 'tslint'] // 実行するタスク
      }
    }

  });

  // 使用するGruntプラグインを読み込む
  grunt.loadNpmTasks('grunt-typescript');
  grunt.loadNpmTasks('grunt-tslint');
  grunt.loadNpmTasks('grunt-contrib-watch');
};
```

$ grunt watch


