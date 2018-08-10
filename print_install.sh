
files=($(find . -maxdepth 1 -type f -not -path '*/\.*' ! -path './make.sh' ! -path './README.md' ! -path './install.sh' -printf "%f\n"))
directories=($(find . -maxdepth 1 -type d -not -path '*/\.*' ! -path . ! -path './zsh' ! -path './config' -printf "%f\n"))

for f in "${files[@]}"
do
    echo "ln -sf $(pwd)/$f ~/.$f"
done

for d in "${directories[@]}"
do
    echo "ln -sf $(pwd)/$d ~/.$d"
done

files=($(find ./config -maxdepth 1 -type f -printf "%f\n"))
directories=($(find ./config -maxdepth 1 ! -path . -type d -printf "%f\n"))

for f in "${files[@]}"
do
    echo "ln -sf $(pwd)/config/$f ~/.config/$f"
done

for d in "${directories[@]}"
do
    echo "ln -sf $(pwd)/config/$d ~/.config/$d"
done

#Install themes
echo "ln -sf $(pwd)/zsh/dracula.zsh-theme ./oh-my-zsh/themes/dracula.zsh-theme"

