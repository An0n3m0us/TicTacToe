width, height = love.graphics.getDimensions( )
font = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 50)

local colors = {}
local crossAnim = {0, 0}
local circleAnim = math.rad(-90)

function love.load()
   bgboard = love.graphics.newImage("bgboard.png")
   bgwidth = bgboard:getWidth()
   bgheight = bgboard:getHeight()
end

function menu()
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("TIC TAC TOE", 0, 100, width, 'center')

    love.graphics.setColor(1, 1, 1, 0.1)
    love.graphics.draw(bgboard, width/2, 350, math.rad(90), 1, 1, bwidth / 2, bheight / 2)
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
    love.graphics.setBackgroundColor(1, 1, 1)

    love.graphics.setFont(font)

    menu()
end

--[[ ANIMATION FOR CIRCLES AND CROSSES
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
