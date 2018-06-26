width, height = love.graphics.getDimensions( )
font = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 75)
font2 = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 50)
font3 = love.graphics.newFont("DejaVuSans-Bold.ttf", 50)

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
    love.graphics.rectangle("line", width/2-50, 250, 1, 300, 0.5, 0.5)
    love.graphics.rectangle("line", width/2+50, 250, 1, 300, 0.5, 0.5)

    love.graphics.rectangle("line", width/2-150, 300+50, 300, 1, 0.5, 0.5)
    love.graphics.rectangle("line", width/2-150, 300+150, 300, 1, 0.5, 0.5)

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
    love.graphics.setLineWidth(8)

    love.graphics.setColor(colors[3])
    love.graphics.rectangle("line", width/2-50, 250, 1, 300, 0.5, 0.5)
    love.graphics.rectangle("line", width/2+50, 250, 1, 300, 0.5, 0.5)

    love.graphics.rectangle("line", width/2-150, 300+50, 300, 1, 0.5, 0.5)
    love.graphics.rectangle("line", width/2-150, 300+150, 300, 1, 0.5, 0.5)

    if theme == 0 then
      love.graphics.setColor(colors[0][1], colors[0][2], colors[0][3], 255-fadeIn2)
    elseif theme == 1 then
      love.graphics.setColor(colors[0][1], colors[0][2], colors[0][3], 255-fadeIn2)
    end
    love.graphics.rectangle("fill", width/2-155, 300-55, 310, 310)
end

local Circle = {}
Circle.__index = Circle

function Circle:new(x, y)
    local self = setmetatable({}, Circle)
    self.x = x
    self.y = y
    self.anim = math.rad(-90)
    return self
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

local Cross = {}
Cross.__index = Cross

function Cross:new(x, y)
    local self = setmetatable({}, Cross)
    self.x = x
    self.y = y
    self.l1 = -35
    self.l2 = -35
    return self
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

local Button = {}
Button.__index = Button

function Button:new(x, y, w, h, draw, action)
    local self = setmetatable({}, Button)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.draw = draw
    self.action = action
    return self
end

function Button:isClicked()
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()

    if mouseX >= self.x - self.w/2 and mouseX <= self.x + self.w/2 and mouseY >= self.y - self.h/2 and mouseY <= self.y + self.h/2 then
        self.action()
    end
end

function themeB(self)
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(5)

    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.setColor(colors[4])
    love.graphics.rectangle("line", -self.w/2, -self.h/2, self.w, self.h, 2.7, 2.7)
    love.graphics.rectangle("fill", -self.w/2+25, -self.h/2+25, self.w-50, self.h-50, 3, 3)
    love.graphics.setColor(colors[5])
    if theme == 0 then
        love.graphics.setColor(255, 255, 255)
    elseif theme == 1 then
        love.graphics.setColor(0, 0, 0)
    end
    love.graphics.rectangle("line", -self.w/8, -self.h/2+35, 25, 1, 2.7, 2.7)
    love.graphics.rectangle("line", -self.w/8, -self.h/2+50, 25, 1, 2.7, 2.7)
    love.graphics.rectangle("line", -self.w/8, -self.h/2+65, 25, 1, 2.7, 2.7)
    love.graphics.pop()
end

function playB(self)
    love.graphics.setFont(font2)

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(5)

    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.setColor(colors[1])
    love.graphics.rectangle("line", -self.w/2, -self.h/2, self.w, self.h, 2.7, 2.7)
    love.graphics.printf("PLAY", -width/2+75-self.w/2, -2.5-self.h/2, width, 'center')
    love.graphics.pop()
end

themeButton = Button:new(width-55, 55, 100, 100, themeB,
    function()
        theme = theme + 1
        if theme > 1 then
            theme = 0
        end
    end
)
playButton = Button:new(width/2, 400, 150, 50, playB,
    function()
        titleScreen = 0
    end
)

function love.load()
    turn = love.math.random(1, 2)
end

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

    -- Menu screen
    if titleScreen == 1 or fadeIn > 1 then
        menu()
        playButton:draw()
    end

    -- Play screen
    if titleScreen == 0 and fadeIn == 0 then
        love.graphics.setFont(font3)

        board();
        if fadeIn2 < 255 and win == 0 then
            fadeIn2 = fadeIn2 + 5
        end
        play = 1
    end

    themeButton:draw()

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

function love.mousepressed(x, y, button, istouch)
   if button == 1 then
      playButton:isClicked()
      themeButton:isClicked()
   end
end
