width, height = love.graphics.getDimensions( )
font = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 75)
font2 = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 50)

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

function menu()
    love.graphics.setColor(colors[1])
    love.graphics.printf("TIC TAC TOE", 0, titleY[1], width, 'center')

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)

    love.graphics.setColor(colors[3])
    love.graphics.rectangle("line", width/2-50, 250, 1, 300, 1, 1, 500)
    love.graphics.rectangle("line", width/2+50, 250, 1, 300, 1, 1, 500)

    love.graphics.rectangle("line", width/2-150, 300+50, 300, 1, 1, 1, 500)
    love.graphics.rectangle("line", width/2-150, 300+150, 300, 1, 1, 1, 500)

    love.graphics.arc("line", "open", width/2-100, 300, 25, 0, 360, 500)
    love.graphics.arc("line", "open", width/2+100, 300, 25, 0, 360, 500)
    love.graphics.arc("line", "open", width/2, 300+100, 25, 0, 360, 500)
    love.graphics.arc("line", "open", width/2-100, 300+200, 25, 0, 360, 500)
    love.graphics.arc("line", "open", width/2+100, 300+200, 25, 0, 360, 500)

    love.graphics.push()
    love.graphics.translate(width/2, 300)
    love.graphics.rotate(math.rad(-45))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.rotate(math.rad(90))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.translate(width/2-100, 300+100)
    love.graphics.rotate(math.rad(-45))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.rotate(math.rad(90))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.translate(width/2+100, 300+100)
    love.graphics.rotate(math.rad(-45))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.rotate(math.rad(90))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.pop()

    love.graphics.push()
    love.graphics.translate(width/2, 300+200)
    love.graphics.rotate(math.rad(-45))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.rotate(math.rad(90))
    love.graphics.rectangle("line", 0, -35, 1, 70, 1, 1, 500)
    love.graphics.pop()

    if theme == 0 then
      love.graphics.setColor(colors[0][1], colors[0][2], colors[0][3], 255-fadeIn/10)
    elseif theme == 1 then
      love.graphics.setColor(colors[0][1], colors[0][2], colors[0][3], 255-fadeIn/3)
    end
    love.graphics.rectangle("fill", width/2-155, 300-55, 310, 310)
end

function board()
    love.graphics.setColor(colors[2])
    love.graphics.draw(board, width/2-boardWidth/2, 250)
end

Circle = {}

function Circle:new(o, x, y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x
    self.y = y
    self.anim = math.rad(-90)
    return o
end

function Circle:draw()
    if self.anim < math.rad(270) then
        self.anim = self.anim + math.rad(5)
    end

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

Cross = {}

function Cross:new(o, x, y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x
    self.y = y
    self.l1 = -35
    self.l2 = -35
    return o
end

function Cross:draw()
    if self.l1 < 35 then
        self.l1 = self.l1 + 2
    end
    if self.l1 == 35 and self.l2 < 35 then
        self.l2 = self.l2 + 2
    end
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)

    love.graphics.setColor(0, 0, 0)

    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(math.rad(-45))
    if self.l1 > 0 then
        love.graphics.rectangle("line", 0, -35, 1, self.l1*2, 1, 1, 500)
    end

    love.graphics.rotate(math.rad(90))
    if self.l2 > 0 then
        love.graphics.rectangle("line", 0, -35, 1, self.l2*2, 1, 1, 500)
    end
    love.graphics.pop()
end

function playButton(x, y)
    -- Play Button
    love.graphics.setFont(font2)

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(5)

    love.graphics.setColor(colors[1])
    love.graphics.rectangle("line", width/2-75, 375, 150, 50, 2.7, 2.7)
    love.graphics.printf("PLAY", 0, 372.5, width, 'center')
end

--circle = Circle:new(nil, 300, 300)
--circle:draw()

function love.draw()
    -- Theme choice
    if theme == 0 then
      colors[0] = {255, 255, 255}
      colors[1] = {0, 0, 0, fadeIn}
      colors[2] = {0, 0, 0, fadeIn2}
      colors[3] = {0, 0, 0}
      colors[4] = {0, 0, 0}
      colors[5] = {255, 255, 255}
    elseif theme == 1 then
      colors[0] = {0, 0, 0}
      colors[1] = {255, 255, 255, fadeIn}
      colors[2] = {255, 255, 255, fadeIn2}
      colors[3] = {255, 255, 255}
      colors[4] = {255, 255, 255}
      colors[5] = {0, 0, 0}
    end

    love.graphics.setBackgroundColor(colors[0])

    love.graphics.setFont(font)

    if titleScreen == 1 then
        menu()

        playButton()
    end

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
