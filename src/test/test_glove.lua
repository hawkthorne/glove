local glove = require "glove"

function test_mkdir()
  glove.filesystem.mkdir("mkdir")
  assert_true(love.filesystem.isDirectory("mkdir"))
end

function test_createDirectory()
  glove.filesystem.createDirectory("createDirectory")
  assert_true(love.filesystem.isDirectory("createDirectory"))
end


