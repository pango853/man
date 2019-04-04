
# Linux x86-64
sudo wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
sudo chmod +x /usr/local/bin/gitlab-runner

OR

curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
sudo yum list --enablerepo=runner_gitlab-runner gitlab-runner --showduplicates | sort -r
sudo yum install --enablerepo=runner_gitlab-runner gitlab-runner-11.9.0-1

sudo systemctl disable gitlab-runner
sudo gitlab-runner register
	http://gitlab.private:8081/
	GiTlAbT0ken
	test-runner
	hihi,test
	shell


# .gitlab-ci.yml

test:
  script: cat file1.txt file2.txt | grep -q 'Hello world'
package:
  script: cat file1.txt file2.txt | gzip > packaged.gz
  artifacts:
    paths:
    - packaged.gz


stages:
  - compile
  - test
  - package			# package will be done only if tests are successful.

compile:
  stage: compile
  script: cat file1.txt file2.txt > compiled.txt
  artifacts:
    paths:
    - compiled.txt
    expire_in: 20 minutes
test:
  stage: test
  script: cat file1.txt file2.txt | grep -q 'Hello world'

package-a:
  stage: package
  script: cat file1.txt file2.txt | gzip > packaged.gz
  artifacts:
    paths:
    - packaged.gz
package-b:
  stage: package		# Then package-a and package-b will be run in parallel.
  ...


## only/except (basic)
- branches 	When a git reference of a pipeline is a branch.
- tags 	When a git reference of a pipeline is a tag.
- api 	When pipeline has been triggered by a second pipelines API (not triggers API).
- external 	When using CI services other than GitLab.
- pipelines 	For multi-project triggers, created using the API with CI_JOB_TOKEN.
- pushes 	Pipeline is triggered by a git push by the user.
- schedules 	For scheduled pipelines.
- triggers 	For pipelines created using a trigger token.
- web 	For pipelines created using Run pipeline button in GitLab UI (under your project’s Pipelines).
- merge_requests 	When a merge request is created or updated


## tags
windows job:
  stage:
    - build
  tags:
    - windows
  script:
    - echo Hello, %USERNAME%!

osx job:
  stage:
    - build
  tags:
    - osx
  script:
    - echo "Hello, $USER!"




windows_job:
  stage:
    - build
  tags:
    - windows
  script:
    - echo Hello, %USERNAME%!

osx job:
  stage:
    - build
  tags:
    - osx
  script:
    - echo "Hello, $USER!"
    

# Variables

https://docs.gitlab.com/ee/ci/variables/

CI_COMMIT_REF_NAME
CI_MERGE_REQUEST_ID
CI_MERGE_REQUEST_SOURCE_BRANCH_NAME
CI_MERGE_REQUEST_TARGET_BRANCH_NAME

デプロイ名:
  stage: master
  script:
  - if [ $CI_COMMIT_REF_NAME = 'master' ]; then
  - echo 'masterブランチですのでデプロイ処理を実行'
  - else
  - echo 'master以外のブランチですので何もしない'
  - fi

  tags:
  - tag_name

# custom_hooks

cd /var/opt/gitlab/git-data/repositories/<group>/<project>.git
sudo -u git mkdir custom_hooks
cd custom_hooks
sudo -u git vi pre-receive
chmod u+x pre-receive

hooks:
- pre-receive
- post-receive
- update

```
	#!/bin/bash

	while read oldrev newrev refname
	do
	 # when new branch created
	 if [ "$oldrev" == "0000000000000000000000000000000000000000" ]; then
	   if [[ "$refname" == refs/heads/feature/RM* ]]; then
	     from="refs/heads/development"
	   elif [[ "$refname" == refs/heads/fix/RM* ]]; then
	     from="refs/heads/master"
	   elif [[ "$refname" == refs/heads/release* ]]; then
	     continue;
	   elif [[ "$refname" == refs/heads/master || "$refname" == refs/heads/development ]]; then
	     # should not reach here.
	     echo "[ERROR] Cannot push to $refname directly." 1>&2
	     exit 1
	   else
	     echo "[ERROR] Branch name (other than 'master' and 'development') must start with 'feature/RM', 'fix/RM' or 'release'." 1>&2
	     exit 1
	   fi

	   # get latest ref from the branch from which this new branch must have been created in accordance with team rules.
	   oldrev=`git show-ref --hash --verify "$from"`
	 fi

	 # when branch deleted
	 if [ "$newrev" == "0000000000000000000000000000000000000000" ]; then
	   continue
	 fi

	 # check refs in commit messages
	 git log --oneline --format=%s "$oldrev".."$newrev" | grep -v '^Merge .*' | awk '{if (! / refs #[0-9]+$/ ) exit 1}'
	 ret=$?
	 if [ $ret -eq 1 ]; then
	   echo "[ERROR] Reference to ticket number is required. Include 'refs #NNN' at the end of a commit message." 1>&2
	   exit 1
	 fi

	 # check tag in commit messages
	 git log --oneline --format=%s "$oldrev".."$newrev" | grep -v '^Merge .*' | awk '{if (! /^\[(fix|feature)\]/ ) exit 1}'
	 ret=$?
	 if [ $ret -eq 1 ]; then
	   echo "[ERROR] Tag is required. Include '[fix] or [feature]' at the beginning of a commit message." 1>&2
	   exit 1
	 fi
	done
```