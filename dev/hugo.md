
# HUGO
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



# TOGO

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



