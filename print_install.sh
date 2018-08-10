
files=($(find . -maxdepth 1 -type f -not -path '*/\.*' ! -path './make.sh' ! -path './README.md' ! -path './print_install.sh' ! -path './install.sh' ! -path './install_list.sh' -printf "%f\n"))
directories=($(find . -maxdepth 1 -type d -not -path '*/\.*' ! -path . ! -path './zsh' ! -path './config' -printf "%f\n"))

for f in "${files[@]}"
do
    echo "ln -sfn $(pwd)/$f ~/.$f"
done

for d in "${directories[@]}"
do
    echo "ln -sfn $(pwd)/$d ~/.$d"
done

files=($(find ./config -maxdepth 1 -type f -printf "%f\n"))
directories=($(find ./config -maxdepth 1 ! -path . -type d -printf "%f\n"))

for f in "${files[@]}"
do
    echo "ln -sfn $(pwd)/config/$f ~/.config/$f"
done

for d in "${directories[@]}"
do
    echo "ln -sfn $(pwd)/config/$d ~/.config/$d"
done

#Install themes
echo "ln -sfn $(pwd)/zsh/dracula.zsh-theme ./oh-my-zsh/themes/dracula.zsh-theme"

