@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install hugo -confirm
OR
https://github.com/gohugoio/hugo/releases/download/v0.72.0/hugo_0.72.0_Windows-64bit.zip


hugo new site mysite

config.toml
	baseURL = "https://your-username.github.io/"

git init

See themes.gohugo.io for a list of themes to consider.
git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
git submodule add https://github.com/nodejh/hugo-theme-cactus-plus themes/cactusplus
git submodule add https://github.com/halogenica/beautifulhugo.git themes/beautifulhugo


config.toml
	theme = "cactusplus"

hugo new posts/my-first-post.md

hugo server -D

config.toml
	publishDir = ".."
hugo
OR
hugo -D ..


# config.toml
RelativeURLs=true
CanonifyURLs=true

# GITHUB


For YOUACCOUNT.github.io
https://github.com/YOUACCOUNT/YOUACCOUNT.github.io/settings
config.toml
	baseURL = "https://YOUACCOUNT.github.io/"

For YOUACCOUNT.github.io/subblog
https://github.com/YOUACCOUNT/subblog/settings
	In `GitHub Pages` section, specify `Source`
config.toml
	baseURL = "https://YOUACCOUNT.github.io/subblog"



# TODO

https://goparker.com/post/2018-05-08-github-pages-and-hugo/




git clone https://github.com/DavidParkerDr/yourblog.git .
git commit --allow-empty -m "Initial commit on master branch"

git push origin master

git checkout -B source

git commit --allow-empty -m "Initial commit on source branch"

git push origin source


git worktree add -B master public origin/master


hugo new site . --force

git submodule add https://github.com/halogenica/beautifulhugo.git themes/beautifulhugo



# TODO


DOSKEY hugo=__WHERE_YOU_EXTRACED_HUGO__\hugo.exe $*

mkdir $HOME/src
cd $HOME/src
git clone https://github.com/gohugoio/hugo.git
cd hugo
go install --tags extended


2 projects
    <blog-name>-hugo
    <github username>.github.io

git clone git@github.com:<username>/<blog-name>-hugo.git
git submodule add git@github.com:<username>/<username>.github.io.git

hugo new site <site name>
cd <site name>

vim config.toml

hugo new about.md 

hugo server

browse http://localhost:1313 and http://localhost:1313/about


git push --recurse-submodules=on-demand




# add theme

cd mysite
cd themes
git clone https://github.com/vjeantet/hugo-theme-casper


```config.toml
baseurl = "https://[your github username].github.io/"
languageCode = "en-us"
title = "the website title shown on the tab"
theme = "the same as theme name (exactly the folder name) in your themes folder"
paginate = 2
Copyright = "© Yuanyuan GE 2020"
canonifyurls = true[params]
description = "Enter your personal description"
authorlocation = "authorlocation"
cover = "images/cover.png"
## save the image you want to use as background picture in directory "./static/images"author = "author name"(delete this line when editing)
logo = "images/logo.png"
## save the image you want to use as website logo in directory "./static/images"(delete this line when editing)githubName = "your github name"
linkedinName = "your linkedin name"
email = "your email"
instagramName = "your ins name"
hideHUGOSupport = false[[menu.main]]  # here are the buttons on the menu
name = "Home" # Button will display as "Home"
weight = 100 # the weight decides the position of the button (higher or lower)
identifier = "home"
pre = "<br />"
url = "/"[[menu.main]]
name = "Contact"
weight = 0
identifier = "contact" # this button will refer to a markdown file named "contact" in the content folder
pre = "<br />"
url = "/contact"[[menu.main]]
name = "Blog"
identifier = "blog" # this page will refer to a markdown file named "blog" in the content folder
pre = "<br />"
url = "/post"
weight = 40[permalinks]
post = "/:slug/"​[sitemap]
ChangeFreq = ""
Filename = "sitemap.xml"
Priority = "-1"
```

hugo new about.md
hugo server


hugo
dir public


git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo theme = \"ananke\" >> config.toml

hugo new posts/my-first-post.md
vim posts/my-first-post.md
draft: false

hugo server -D

hugo -D

