work_path="/tmp/stromate-book"

# build the book
mdbook build

# create or clear the worktree
if [ ! -d "$work_path" ];then
  mkdir $work_path && echo "create dir $work_path"
else
  rm -rf $work_path+"/*" && echo "remove file in $work_path"
fi

git worktree add -f $work_path

# copy book to worktree
cp -rp book/* $work_path
cd $work_path
git add -A
git commit -m 'deploy new book'
git push origin stromate-book:book
