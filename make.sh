
files=($(find . -maxdepth 1 -type f -not -path '*/\.*' ! -path './make.sh' ! -path './README.md' ! -path './install.sh' -printf "%f\n"))
directories=($(find . -maxdepth 1 -type d -not -path '*/\.*' ! -path . -printf "%f\n"))

for f in "${files[@]}"
do
   echo "ln -sf $(pwd)/$f ~/.$f"
done

for d in "${directories[@]}"
do
    echo "ln -sf $(pwd)/$d ~/.$d"
done

#Install themes
echo "ln -sf $(pwd)/zsh/dracula.zsh-theme $(pwd)/oh-my-zsh/themes/dracula.zsh-theme"

