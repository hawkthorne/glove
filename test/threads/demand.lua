local glove = require "glove"

local thread = glove.thread.getThread()

local bar = thread:demand('foo')
thread:set('foo2', bar)
