tree_branch="stromate-book"
work_path="/tmp/$tree_branch"

# build the book
mdbook build

# create or clear the worktree
if [ ! -d "$work_path" ];then
  mkdir $work_path && echo "create dir $work_path"
else
  rm -rf "$work_path/*" && echo "remove file in $work_path"
fi

# delete old tree_branch
git branch -D $tree_branch

# add worktree
git worktree add -f $work_path

# copy book to worktree
cp -rp book/* $work_path
cd $work_path
git add -A
git commit -m 'deploy new book'
git push -f origin $tree_branch:book

# remove worktree
git worktree remove -f $work_path
