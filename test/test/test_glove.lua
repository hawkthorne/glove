local glove = require "glove"

function test_mkdir()
  glove.filesystem.mkdir("mkdir")
  assert_true(love.filesystem.isDirectory("mkdir"))
end

function test_createDirectory()
  glove.filesystem.createDirectory("createDirectory")
  assert_true(love.filesystem.isDirectory("createDirectory"))
end

function test_os()
  assert_equal(glove.system.getOS(), glove._os)
end

function test_get_font()
  assert_false(glove.graphics.getFont() == nil)
end


function test_enumerate()
  glove.filesystem.createDirectory("foo")
  love.filesystem.write("foo/foo.txt", "FOO")

  for _, name in ipairs(glove.filesystem.enumerate("foo")) do
    assert_equal(name, "foo.txt")
  end
end

function test_getDirectoryItems()
  glove.filesystem.createDirectory("foo")
  love.filesystem.write("foo/foo.txt", "FOO")

  for _, name in ipairs(glove.filesystem.getDirectoryItems("foo")) do
    assert_equal(name, "foo.txt")
  end
end


function test_isFused()
  assert_false(glove.filesystem.isFused("foo"))
end


function test_threads_get()
  local thread = glove.thread.newThread("threads_get", "threads/get.lua")
  thread:start()
  thread:wait()
  assert_equal("bar", thread:get("foo"))
end

function test_threads_demand()
  local thread = glove.thread.newThread("threads_demand", "threads/get.lua")
  thread:start()
  thread:wait()
  assert_equal("bar", thread:demand("foo"))
end

function test_threads_peek()
  local thread = glove.thread.newThread("threads_peek", "threads/get.lua")
  thread:start()
  thread:set("foo", "bar")

  assert_equal("bar", thread:peek("foo"))
  assert_equal("bar", thread:get("foo"))
  assert_equal(nil, thread:peek("foo"))

  thread:wait()
end

function test_threads_error()
  local thread = glove.thread.newThread("threads_error", "threads/error.lua")
  thread:start()
  thread:wait()

  local err = thread:get("error")
  assert_true(string.find(err, "attempt to perform arithmetic on global 'c'"))
end

function test_threads_demand_trip()
  local thread = glove.thread.newThread("threads_demand_trip", "threads/demand.lua")
  thread:start()
  thread:set("foo", "bar")
  thread:wait()
  assert_equal("bar", thread:get("foo2"))
end
