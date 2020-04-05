width, height = love.graphics.getDimensions()
font = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 75)
font2 = love.graphics.newFont("DejaVuSansMono-Bold.ttf", 50)
font3 = love.graphics.newFont("DejaVuSans-Bold.ttf", 50)
font4 = love.graphics.newFont("DejaVuSans-Bold.ttf", 100)

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
local fadeIn3 = 0
local buttonSpeed = {5, 10}

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

    -- Bigger board
    -- love.graphics.push()
    -- love.graphics.translate(width/2, height/2)
    -- love.graphics.rectangle("line", -100, -300, 1, 600, 0.5, 0.5)
    -- love.graphics.rectangle("line", 100, -300, 1, 600, 0.5, 0.5)
    --
    -- love.graphics.rectangle("line", -300, -100, 600, 1, 0.5, 0.5)
    -- love.graphics.rectangle("line", -300, 100, 600, 1, 0.5, 0.5)
    -- love.graphics.pop()

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
        self.anim = self.anim + math.rad(15)
    end

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)

    love.graphics.setColor(colors[3])
    love.graphics.push()
    love.graphics.translate(490+100*self.x+50, 250+100*self.y+50)
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
    self.l1 = 0
    self.l2 = 0
    return self
end

function Cross:draw()
    if self.l1 < 35 then
        self.l1 = self.l1 + 3.5
    end
    if self.l1 == 35 and self.l2 < 35 then
        self.l2 = self.l2 + 3.5
    end

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)

    love.graphics.setColor(colors[3])

    love.graphics.push()
    love.graphics.translate(490+100*self.x+50, 250+100*self.y+50)
    love.graphics.rotate(math.rad(-45))
    if self.l1 > 1 then
        love.graphics.rectangle("line", 0, -35, 1, self.l1*2, 1, 1, 500)
    end

    love.graphics.rotate(math.rad(90))
    if self.l2 > 1 then
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

function restartB(self)
    love.graphics.setFont(font2)
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(5)

    love.graphics.setColor(colors[4])

    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rectangle("line", -self.w/2, -self.h/2, self.w, self.h, 2.7, 2.7)
    love.graphics.printf("RESTART", -width/2+125-self.w/2, -2.5-self.h/2, width, 'center')
    love.graphics.pop()
end

themeButton = Button:new(width+70, 55, 100, 100, themeB,
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
restartButton = Button:new(width/2, height+50, 250, 50, restartB,
    function()
        play = 0
        clicks = 0
        win = 0
        titleScreen = 1
        titleY = {-50, 0}
        fadeIn = 0
        fadeIn2 = 0
        fadeIn3 = 0
        buttonSpeed = {5, 10}
        grid = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}}
        circles = {}
        crosses = {}
        themeButton.x = width+70
        restartButton.y = height+50

        for i = 0, 2, 1 do
            table.insert(circles, Circle:new(i, 0))
            table.insert(crosses, Cross:new(i, 0))
        end
        for i = 0, 2, 1 do
            table.insert(circles, Circle:new(i, 1))
            table.insert(crosses, Cross:new(i, 1))
        end
        for i = 0, 2, 1 do
            table.insert(circles, Circle:new(i, 2))
            table.insert(crosses, Cross:new(i, 2))
        end
    end
)

for i = 0, 2, 1 do
    table.insert(circles, Circle:new(i, 0))
    table.insert(crosses, Cross:new(i, 0))
end
for i = 0, 2, 1 do
    table.insert(circles, Circle:new(i, 1))
    table.insert(crosses, Cross:new(i, 1))
end
for i = 0, 2, 1 do
    table.insert(circles, Circle:new(i, 2))
    table.insert(crosses, Cross:new(i, 2))
end

-- Random turn
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

    -- Buttons
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

    -- Slide-buttons animation
    if themeButton.x > width-55 then
        themeButton.x = themeButton.x - buttonSpeed[1]
    end
    if win == 1 or win == 2 or win == 3 then
        restartButton.y = restartButton.y - buttonSpeed[2]
    end
    if buttonSpeed[1] > 0 then
        buttonSpeed[1] = buttonSpeed[1] - 0.1
    end
    if win == 1 and buttonSpeed[2] > 0 or win == 2 and buttonSpeed[2] > 0 or win == 3 and buttonSpeed[2] > 0 then
        buttonSpeed[2] = buttonSpeed[2] - 0.196
    end
    if buttonSpeed[1] > -0.5 and buttonSpeed[1] < 0.5 then
        buttonSpeed[1] = 0
        themeButton.x = width-55
    end
    if buttonSpeed[2] > -0.5 and buttonSpeed[2] < 0.5 then
        buttonSpeed[2] = 0
        restartButton.y = height/2+150
    end

    -- Fade-in animation
    if titleScreen == 1 and fadeIn < 255 then
        fadeIn = fadeIn + 5
    elseif titleScreen == 0 and fadeIn > 1 then
        fadeIn = fadeIn - 5
    end

    -- Draw circles or crosses
    for i = 0, 3, 1 do
        if grid[1][i] == 1 then
            circles[i]:draw()
        end
        if grid[1][i] == 2 then
            crosses[i]:draw()
        end
        if grid[2][i] == 1 then
            circles[i+3]:draw()
        end
        if grid[2][i] == 2 then
            crosses[i+3]:draw()
        end
        if grid[3][i] == 1 then
            circles[i+6]:draw()
        end
        if grid[3][i] == 2 then
            crosses[i+6]:draw()
        end
    end

    -- Win fade
    love.graphics.setColor(colors[0][1], colors[0][2], colors[0][3], fadeIn3)
    love.graphics.rectangle("fill", width/2-155, 300-55, 310, 310)

    -- Win check
    -- Horizontal
    for i = 1, 3, 1 do
        if grid[i][1] == 1 and grid[i][2] == 1 and grid[i][3] == 1 then
            win = 1
        elseif grid[i][1] == 2 and grid[i][2] == 2 and grid[i][3] == 2 then
            win = 2
        end
    end

    for i = 1, 3, 1 do
        if grid[1][i] == 1 and grid[2][i] == 1 and grid[3][i] == 1 then
            win = 1
        elseif grid[1][i] == 2 and grid[2][i] == 2 and grid[3][i] == 2 then
            win = 2
        end
    end

    --Diagonal
    if grid[1][1] == 1 and grid[2][2] == 1 and grid[3][3] == 1 then
        win = 1
    elseif grid[3][1] == 1 and grid[2][2] == 1 and grid[1][3] == 1 then
        win = 1
    end
    if grid[1][1] == 2 and grid[2][2] == 2 and grid[3][3] == 2 then
        win = 2
    elseif grid[3][1] == 2 and grid[2][2] == 2 and grid[1][3] == 2 then
        win = 2
    end

    -- Win scenes
    if win == 0 and clicks == 9 then
        win = 3
    end

    if win == 1 or win == 2 or win == 3 then
        love.graphics.setFont(font4)
        if fadeIn3 < 225 then
            fadeIn3 = fadeIn3 + 5
        end
        love.graphics.setColor(colors[1][1], colors[1][2], colors[1][3])
        if win == 1 then
            love.graphics.setColor(colors[1][1], colors[1][2], colors[1][3])
            love.graphics.printf("O wins!", width/2-width/2, height/2-20, width, 'center')
        elseif win == 2 then
            love.graphics.setColor(colors[1][1], colors[1][2], colors[1][3])
            love.graphics.printf("X wins!", width/2-width/2, height/2-20, width, 'center')
        elseif win == 3 and clicks == 9 then
            love.graphics.printf("Draw!", width/2-width/2, height/2-20, width, 'center')
        end
        play = 0
        restartButton:draw()
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        if play == 0 then
            playButton:isClicked()
        end
        themeButton:isClicked()
        if win == 1 or win == 2 or win == 3 then
            restartButton:isClicked()
        end

        if play == 1 then
          for i = 0, 300, 100 do
              if x >= 390+i and x <= (390+i)+100 and y >= 250 and y <= 250+100 and grid[1][i/100] == 0 then
                  clicks = clicks + 1
                  if turn == 1 then
                      grid[1][i/100] = 1
                      turn = 2
                  elseif turn == 2 then
                      grid[1][i/100] = 2
                      turn = 1
                  end
              end
              if x >= 390+i and x <= (390+i)+100 and y >= 350 and y <= 350+100 and grid[2][i/100] == 0 then
                  clicks = clicks + 1
                  if turn == 1 then
                      grid[2][i/100] = 1
                      turn = 2
                  elseif turn == 2 then
                      grid[2][i/100] = 2
                      turn = 1
                  end
              end
              if x >= 390+i and x <= (390+i)+100 and y >= 450 and y <= 450+100 and grid[3][i/100] == 0 then
                  clicks = clicks + 1
                  if turn == 1 then
                      grid[3][i/100] = 1
                      turn = 2
                  elseif turn == 2 then
                      grid[3][i/100] = 2
                      turn = 1
                  end
              end
          end
       end
    end
end
