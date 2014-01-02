local glove = require "glove"

function test_setTitle()
  glove.window.setTitle("test window.setTitle")
  assert_equal("test window.setTitle", glove.window.getTitle("foo"))
end

function test_setCaption()
  glove.graphics.setCaption("test graphics.setCaption")
  assert_equal("test graphics.setCaption", glove.graphics.getCaption("foo"))
end
