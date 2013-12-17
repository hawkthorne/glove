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



