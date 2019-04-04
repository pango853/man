

# MISC

## Branch merge

cd C:\DEV\WS\Temp\trySVN
svnadmin create ./my-repo

svn checkout file:///DEV/WS/Temp/trySVN/my-repo work1
cd work1
svn mkdir trunk branches tags
svn commit -m "First commit" --username admin --password (adminのパスワード) --no-auth-cache
svn list file:///DEV/WS/Temp/trySVN/my-repo
cd ..

svn checkout file:///DEV/WS/Temp/trySVN/my-repo/trunk work2
cd work2
echo dummy > script1.txt
svn add script1.txt
svn commit -m "add script1"

svn copy file:///DEV/WS/Temp/trySVN/my-repo/branches/v61 -m "create 6.1 branch"
OR
svn copy file:///DEV/WS/Temp/trySVN/my-repo/trunk file:///DEV/WS/Temp/trySVN/my-repo/branches/v61 -m "create 6.1 branch"

svn info
svn switch file:///DEV/WS/Temp/trySVN/my-repo/branches/v61
svn info
svn switch file:///DEV/WS/Temp/trySVN/my-repo/trunk

echo updated >> script1.txt
echo dummy > script2.txt
echo dummy > script3.txt
svn add script2.txt script3.txt
svn commit -m "Fix scirpt 1 and add 2 and 3"

svn update
svn switch file:///DEV/WS/Temp/trySVN/my-repo/branches/v61
svn merge --reintegrate file:///DEV/WS/Temp/trySVN/my-repo/trunk

svn merge file:///DEV/WS/Temp/trySVN/my-repo/trunk

svn log --use-merge-history file:///DEV/WS/Temp/trySVN/my-repo/branches/v61
svn log --use-merge-history file:///DEV/WS/Temp/trySVN/my-repo/trunk
svn log --use-merge-history


svn switch file:///DEV/WS/Temp/trySVN/my-repo/branches/v61


svn switch file:///DEV/WS/Temp/trySVN/my-repo/trunk




svn log -r 999:HEAD
svn log -l 10
svn log -v
svn log --diff  



svn sw {url}/branches/hoge
svn info URL_of_WC
svn switch [-r rev] URL PATH


svn merge [--dry-run] --force From_URL@revN To_URL@revM PATH


svnadmin create --fs-type fsfs PATH


### What the hell is "Include merged revisions"?
