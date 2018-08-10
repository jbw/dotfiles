
# Create symbolic links for zsh
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/oh-my-zsh ~/.oh-my-zsh
ln -s $(pwd)/i3 ~/.i3
ln -s $(pwd)/config/polybar ~/.config/polybar
ln -s $(pwd)/config/redshift.conf ~/.config/redshift.conf


# Install themes
ln -s $(pwd)/zsh/dracula.zsh-theme $(pwd)/oh-my-zsh/themes/dracula.zsh-theme
