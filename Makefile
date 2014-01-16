LUA_DIR = /usr/local
LUA_VERSION = `lua -e 'print(_VERSION:sub(5,7))'`
LUA_SHARE = $(LUA_DIR)/share/lua/$(LUA_VERSION)

test:
	@./scripts/telescope/tsc spec/*.lua

install:
	@mkdir -p $(LUA_SHARE)/telescope
	cp scripts/telescope/telescope.lua $(LUA_SHARE)
	cp scripts/telescope/telescope/compat_env.lua $(LUA_SHARE)/telescope
	cp scripts/telescope/tsc $(LUA_DIR)/bin

play:
	lua t3.lua
