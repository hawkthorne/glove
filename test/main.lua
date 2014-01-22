local lovetest = require "test/lovetest"

function love.load(arg)
  love.filesystem.setIdentity('glove')
  lovetest.run()
  
  if love._os ~= "Windows" then
    love.event.push("quit")
  end
end
