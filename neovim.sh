sudo apt install npm  git cmake ninja-build libtool libtool-bin autoconf automake  unzip gettext -y  && sudo  rm -rf /var/lib/apt/lists/*

git clone https://github.com/neovim/neovim.git

cd neovim

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

make distclean
