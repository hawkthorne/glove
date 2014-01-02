local glove = require "glove"

function test_setTitle()
  glove.window.setTitle("test window.setTitle")
  assert_equal("test window.setTitle", glove.window.getTitle("foo"))
end

function test_setCaption()
  glove.graphics.setCaption("test graphics.setCaption")
  assert_equal("test graphics.setCaption", glove.graphics.getCaption("foo"))
end

function test_getWidth()
  assert_equal(800, glove.graphics.getWidth())
  assert_equal(800, glove.window.getWidth())
end

function test_getHeight()
  assert_equal(600, glove.graphics.getHeight())
  assert_equal(600, glove.window.getHeight())
end

function test_getDimensions()
  local width, height = glove.graphics.getDimensions()
  assert_equal(800, width)
  assert_equal(600, height)

  local width, height = glove.window.getDimensions()
  assert_equal(800, width)
  assert_equal(600, height)
end
