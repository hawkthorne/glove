local lovetest = require "test/lovetest"

function love.load(arg)
  love.filesystem.setIdentity('glove')
  lovetest.run()
  love.event.push("quit")
end
