![glove](http://i.imgur.com/ziiJIX6.png)

[![Build Status](https://travis-ci.org/stackmachine/glove.png?branch=master)](https://travis-ci.org/stackmachine/glove)

Glove is a LOVE 0.8 and 0.9 compatibility library. It provides utility
functions for smoothing over the differences between the LOVE versions with the
goal of writing Lua and LOVE code that is compatible on both versions.

## Migrating to Glove

Glove is a single Lua file, so it's easy to integrate. Once you've download the
file, migrating involves only a few changes. First, load the module.

```lua
local glove = require 'glove'
```

Next, replace calls to backward-incompatible methods by change `love` to
`glove`. For example, `love.filesystem.mkdir` no longer works in LOVE 0.9. 

Change this code:

```lua
love.filesystem.mkdir('foo')
```

to

```lua
glove.filesystem.mkdir('foo')
```

The second code snipper will now work in across both LOVE versions.

## Documentation

See the [documentation](https://github.com/stackmachine/glove/wiki/Supported-Methods-and-Modules) for supported methods.

## Developing

Glove is tested against both LOVE 0.8 and 0.9. To run these tests locally:

    make test
