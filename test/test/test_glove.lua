local glove = require "glove"

function test_mkdir()
  glove.filesystem.mkdir("mkdir")
  assert_true(love.filesystem.isDirectory("mkdir"))
end

function test_createDirectory()
  glove.filesystem.createDirectory("createDirectory")
  assert_true(love.filesystem.isDirectory("createDirectory"))
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

function test_threads_get()
  local thread = glove.thread.newThread("threads_get", "threads/get.lua")
  thread:start()

  love.timer.sleep(0.001)

  local result = thread:get("foo")

  assert_equal("bar", result)
end

function test_threads_wait()
  local thread = glove.thread.newThread("threads_wait", "threads/get.lua")
  thread:start()
  thread:wait()
  assert_true(true)
end
