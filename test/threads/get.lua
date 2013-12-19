local glove = require "glove"

local thread = glove.thread.getThread()

thread:set("foo", "bar")
