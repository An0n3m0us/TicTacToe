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
local fadeIn = 255
local fadeIn2 = 255
local buttonSpeed = {5, 10}
local winSound = 1

function love.load()
    if theme == 0 then
      bgboard = love.graphics.newImage("images/bgboard-white.png")
      playB = love.graphics.newImage("images/playButton-white.png")
    elseif theme == 1 then
      bgboard = love.graphics.newImage("images/bgboard-black.png")
      playB = love.graphics.newImage("images/playButton-black.png")
    end
    bgwidth, bgheight = bgboard:getWidth(), bgboard:getHeight()
    playBwidth, playBheight = playB:getWidth(), playB:getHeight()
end

function menu()
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("TIC TAC TOE", 0, 100, width, 'center')

    love.graphics.setColor(colors[3])
    love.graphics.draw(bgboard, width/2-bgwidth/2, 250)
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

function circle(x, y)
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)

    love.graphics.setColor(0, 0, 0)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.arc("line", "open", 0, 0, 25, math.rad(-90), circleAnim, 500)

    love.graphics.setLineWidth(4)
    love.graphics.circle("line", 0, -25, 1.5, 500)
    love.graphics.rotate(circleAnim-math.rad(-90))
    love.graphics.circle("line", 0, -25, 1.5, 500)
    love.graphics.pop()
end

function love.draw()
    if theme == 0 then
      colors[0] = {255, 255, 255}
      colors[1] = {255, 255, 255, fadeIn}
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

    menu()

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(5)

    love.graphics.setColor(colors[1])
    love.graphics.draw(playB, width/2-playBwidth/4, 375.5, 0, 0.5)
end

--[[ ANIMATION FOR CIRCLES AND CROSSES
local crossAnim = {0, 0}
local circleAnim = math.rad(-90)

if crossAnim[1] < 35 then
    crossAnim[1] = crossAnim[1] + 1.75
end

if crossAnim[1] == 35 and crossAnim[2] < 35 then
    crossAnim[2] = crossAnim[2] + 1.75
end

if circleAnim < math.rad(270) then
    circleAnim = circleAnim + math.rad(9)
end
]]
