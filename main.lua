require 'game'

WindowSize = {800, 600}

function love.load()
    love.window.setMode(unpack(WindowSize))
    love.window.setTitle("L-System Scratchproject")

    GuiFont = love.graphics.newFont("cour.ttf", 16)
    love.graphics.setFont(GuiFont)

    game = Game:new({})

    game:init()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:render()

    if game.currentFamily and game.currentFamily.seed then
        love.graphics.print(string.format("Seed: %d", game.currentFamily.seed), 10, 5)
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        game:placeItem(x, y)
    else
        game:newFamily()
    end
end

function love.mousereleased(x, y, button)

end

function love.keypressed(key)
    if key == "space" then
        game:clearCanvas()
    elseif key == "return" then
        game:generateScene()
    end
end

function love.keyreleased(key)

end

function love.focus(f)

end

function love.quit()

end

