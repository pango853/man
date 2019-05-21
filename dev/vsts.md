
# Install the VSTS CLI

https://aka.ms/vsts-cli-windows-installer (vsts-cli-0.1.4.msi)
OR
`curl -L https://aka.ms/install-vsts-cli > cli-install` for Linux
>  sha256sum cli-install
	9ade887a96afeb50ee1ed5e8efa24aac679865b5ae393be8445276734ae82885
> chmod 775 cli-install
> ./cli-install

OR
docker pull microsoft/vsts-cli
docker run -it microsoft/vsts-cli


First, create a personal access token if you don't have one.
Profile icon > Security > personal access tokens > add
> vsts login --token xxxxxxxxxx 
> vsts configure --defaults instance=https://dev.azure.com/myorganization  project=myproject



# Configure

> vsts configure --use-git-aliases yes



> SET HTTPS_PROXY=http://username:passwd@127.0.0.1:8080

> vsts login --instance https://xxxxxxxxxxxxxxxxxxxxx/ --token yyyyyyyyyyyyyyyyyyyyyyyyy
> vsts build list -p devcloud --debug
OR
> vsts configure --defaults instance=https://xxxxxxxxxxxxxxxxxxxxx/ project=myproject
> vsts login --token yyyyyyyyyyyyyyyyyyyyyyyyy
> vsts build list



# MISC

## vs Git

Creating a pull request:
> vsts code pr create --target-branch {branch_name}
> git pr create --target-branch {branch_name}

Add reviewers to a pull request:
> vsts code pr reviewers add --id # --reviewers {name}
> git pr reviewers add --id # --reviewers {name} 

Set a pull request to auto-complete:
> vsts code pr update --id # --auto-complete on
> git pr update --id # --auto-complete on 


