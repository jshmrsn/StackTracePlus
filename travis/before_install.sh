if [ $LUA = "luajit" ]; then
	if [ $LUAJIT_VER = "2.0" ]; then
		sudo add-apt-repository ppa:mwild1/ppa -y && sudo apt-get update -y;
	fi
	if [ $LUAJIT_VER = "2.1" ]; then
		sudo add-apt-repository ppa:neomantra/luajit-v2.1 -y && sudo apt-get update -y;
	fi
fi

if [ $LUA = "lua5.1" ] || [ $LUA = "lua5.2" ]; then
	sudo apt-get install $LUA
	sudo apt-get install $LUA_DEV

elif [[ $LUA = "lua5.3" ]]; then
	#statementselif
	LUA_V="5.3.0"
	wget "http://www.lua.org/ftp/lua-${LUA_V}.tar.gz"
	tar xf "lua-${LUA_V}.tar.gz"
	pushd "lua-${LUA_V}"
		make linux
		make install
	popd
fi
lua$LUA_SFX -v
# Install a recent luarocks release
wget http://luarocks.org/releases/$LUAROCKS_BASE.tar.gz
tar zxvpf $LUAROCKS_BASE.tar.gz
pushd $LUAROCKS_BASE
	./configure --lua-version=$LUA_VER --lua-suffix=$LUA_SFX --with-lua-include="$LUA_INCDIR"
	make build && sudo make install
popd
cd $TRAVIS_BUILD_DIR
