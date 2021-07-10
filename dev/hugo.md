

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

