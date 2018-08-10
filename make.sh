
files=($(find . -maxdepth 1 -type f -not -path '*/\.*' -printf "%f\n"))
directories=($(find . -maxdepth 1 -type d -not -path '*/\.*' ! -path . -printf "%f\n"))

for f in "${files[@]}"
do
   echo "ln -s $(pwd)/$f ~/$f"
done

for d in "${directories[@]}"
do
    echo "ln -s $(pwd)/$d ~/$d"
done

#Install themes
echo "ln -s $(pwd)/zsh/dracula.zsh-theme $(pwd)/oh-my-zsh/themes/dracula.zsh-theme"

