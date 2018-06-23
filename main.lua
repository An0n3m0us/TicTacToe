width, height = love.graphics.getDimensions( )
font = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 75)

local play = 0
local turn = 1
local clicks = 0
local win = 0

local theme = 0
local sound = 0
local colors = {}

local titleScreen = 1
local titleY = {-50, 0}
local fadeIn = 0
local fadeIn2 = 0
local buttonSpeed = {5, 10}
local winSound = 1

local grid = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}}
local circles = {}
local crosses = {}

Circle = {}

function love.load()
    if theme == 0 then
      bg = love.graphics.newImage("images/bgboard-white.png")
      board = love.graphics.newImage("images/board-white.png")
      playB = love.graphics.newImage("images/playButton-white.png")
    elseif theme == 1 then
      bg = love.graphics.newImage("images/bgboard-black.png")
      board = love.graphics.newImage("images/board-black.png")
      playB = love.graphics.newImage("images/playButton-black.png")
    end
    bgWidth, bgHeight = bg:getWidth(), bg:getHeight()
    boardWidth, boardHeight = board:getWidth(), board:getHeight()
    playWidth, playHeight = playB:getWidth(), playB:getHeight()
end

function menu()
    love.graphics.setColor(colors[1])
    love.graphics.printf("TIC TAC TOE", 0, titleY[1], width, 'center')

    love.graphics.setColor(colors[3])
    love.graphics.draw(bg, width/2-bgWidth/2, 250)
end

function board()
    love.graphics.setColor(colors[2])
    love.graphics.draw(board, width/2-boardWidth/2, 250)
end

function Circle:new(o, x, y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x
    self.y = y
    self.anim = 0
    return o
end

function Circle:draw()
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)

    love.graphics.setColor(0, 0, 0)
    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.arc("line", "open", 0, 0, 25, math.rad(-90), self.anim, 500)

    love.graphics.setLineWidth(4)
    love.graphics.circle("line", 0, -25, 1.5, 500)
    love.graphics.rotate(self.anim-math.rad(-90))
    love.graphics.circle("line", 0, -25, 1.5, 500)
    love.graphics.pop()
end

function cross(x, y)
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)

    love.graphics.setColor(0, 0, 0)

    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(math.rad(-45))
    if crossAnim[1] > 0 then
        love.graphics.rectangle("line", 0, -35, 1, crossAnim[1]*2, 1, 1, 500)
    end

    love.graphics.rotate(math.rad(90))
    if crossAnim[2] > 0 then
        love.graphics.rectangle("line", 0, -35, 1, crossAnim[2]*2, 1, 1, 500)
    end
    love.graphics.pop()
end

circle = Circle:new(nil, 50, 50)

function love.draw()
    -- Theme choice
    if theme == 0 then
      colors[0] = {255, 255, 255}
      colors[1] = {0, 0, 0, fadeIn}
      colors[2] = {0, 0, 0, fadeIn2}
      colors[3] = {255, 255, 255, fadeIn/10}
      colors[4] = {0, 0, 0}
      colors[5] = {255, 255, 255}
    elseif theme == 1 then
      colors[0] = {0, 0, 0}
      colors[1] = {255, 255, 255, fadeIn}
      colors[2] = {255, 255, 255, fadeIn2}
      colors[3] = {255, 255, 255, fadeIn/5}
      colors[4] = {255, 255, 255}
      colors[5] = {0, 0, 0}
    end

    love.graphics.setBackgroundColor(colors[0])

    love.graphics.setFont(font)

    if titleScreen == 1 then
        menu()

        love.graphics.setColor(colors[1])
        love.graphics.draw(playB, width/2-playWidth/4, 375.5, 0, 0.5)
    end

    circle:draw()

    -- Title animation
    titleY[1] = titleY[1] + titleY[2]
    if titleY[1] < 8 then
        titleY[2] = 4.5;
    elseif titleY[1] > 8 then
        titleY[2] = titleY[2] - 0.1;
        if titleY[2] > -0.2 and titleY[2] < 0.2 then
            titleY[2] = 0
        end
    end

    -- Fade-in animation
    if titleScreen == 1 and fadeIn < 255 then
        fadeIn = fadeIn + 5
    elseif titleScreen == 0 and fadeIn > 1 then
        fadeIn = fadeIn - 5
    end
end
