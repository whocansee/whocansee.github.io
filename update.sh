info=$1
if ["$info" = ""];
then info="okok"
fi
git add -A
git commit -m "$info"
git push origin hexo