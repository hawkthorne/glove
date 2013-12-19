-- Glove is a compatibility layer
-- So that you can write LOVE modules
-- That work on both 0.8.0 and 0.9.0
--
-- The local functions are named after 0.8.0

local glove = {}

-- Features
local love9 = love._version == "0.9.0"
local love8 = love._version == "0.8.0"

glove.filesystem = {}
glove.thread = {}

-- http://www.love2d.org/wiki/love.filesystem.enumerate
local function enumerate(dir)
  if love.filesystem.enumerate then
    return love.filesystem.enumerate(dir)
  else
    return love.filesystem.getDirectoryItems(dir)
  end
end

glove.filesystem.enumerate = enumerate
glove.filesystem.getDirectoryItems = enumerate

-- http://www.love2d.org/wiki/love.filesystem.mkdir
local function mkdir(name)
  if love.filesystem.mkdir then
    return love.filesystem.mkdir(name)
  else
    return love.filesystem.createDirectory(name)
  end
end

glove.filesystem.mkdir = mkdir
glove.filesystem.createDirectory = mkdir


-- The NamedThread class provides the Love 0.8.0
-- thread interface in Love 0.9.0
local NamedThread = {}
NamedThread.__index = NamedThread

function NamedThread:init(name, filedata)
  self.thread = love.thread.newThread(filedata)
  self.name = name
end

function NamedThread:start()
  return self.thread:start()
end

function NamedThread:wait()
  return self.thread:wait()
end

function NamedThread:set(name, value)
  local channel = love.thread.getChannel(name)
  return channel:push(value) 
end

function NamedThread:peek(name)
  local channel = love.thread.getChannel(name)
  return channel:peek()
end

function NamedThread:get(name)
  if name == "error" then
    return self.thread:getError()
  end
  local channel = love.thread.getChannel(name)
  return channel:pop()
end


function NamedThread:demand(name)
  local channel = love.thread.getChannel(name)
  return channel:demand()
end

local _threads = {}

-- http://www.love2d.org/wiki/love.thread.newThread 
local function newThread(name, filedata)
  if love8 then
    return love.thread.newThread(name, filedata)
  end

  if _threads[name] then
    error("A thread with that name already exists.")
  end
  
  local thread = {}
  setmetatable(thread, NamedThread)
  thread:init(name, filedata)

  -- Mark this name as taken
  _threads[name] = true

  return thread
end

local function getThread()
  if love.thread.getThread then
    return love.thread.getThread()
  end
  local thread = {}
  setmetatable(thread, NamedThread)
  return thread
end

glove.thread.newThread = newThread
glove.thread.getThread = getThread

return glove
