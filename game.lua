util = require 'util'
require 'lsystem'
require 'lsystemtemplates'

Game = {}

function Game:new(config)
    local newGame = setmetatable(util.copy(config), {__index=Game})

    -- newGame.familyTypes = {}
    -- for k, _ in pairs(LSystemTemplates) do
    --     table.insert(newGame.familyTypes, k)
    -- end

    newGame.familyTypes = {
            "DerpCactus",
            "FractalPlant",
            "FractalTree",
            -- "SierpinskiTriangle",
            -- "SierpinskiArrowhead"
        }

    return newGame
end

function Game:init()
    self.canvas = love.graphics.newCanvas()
    self.rng = love.math.newRandomGenerator(util.seedTime())
    self:newFamily()
end

function Game:update(dt)

end

function Game:render()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.canvas)
end

function Game:placeItem(x, y)
    love.graphics.setCanvas(self.canvas)

    love.graphics.setColor(self.rng:random(1, 255), self.rng:random(1, 255), self.rng:random(1, 255))

    self.currentFamily:place(x, y)

    love.graphics.setCanvas()
end

function Game:clearCanvas()
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    love.graphics.setCanvas()
end

function Game:newFamily()
    local familyType = self.rng:random(1, #self.familyTypes)
    self.currentFamily = LSystem:new(LSystemTemplates[self.familyTypes[familyType]], self.rng:random(2147483647))
end

function Game:generateScene()
    love.graphics.setCanvas(self.canvas)

    love.graphics.clear()

    local w, h = love.graphics.getWidth(), love.graphics.getHeight()

    local families = {}
    local instancePoints = {}

    local familyCount = self.rng:random(2, 3)
    for i = 1, familyCount do
        local familyType = self.rng:random(1, #self.familyTypes)
        table.insert(families, LSystem:new(LSystemTemplates[self.familyTypes[familyType]], self.rng:random(2147483647)))

        local targetDensity = self.rng:randomNormal(0.00002, 0.00005)
        local targetCount = (w * h) * targetDensity

        for j = 1, targetCount do
            local x = self.rng:random(10, w - 10)
            local y = self.rng:random(0, h - 10)
            local point = {x, y, i}
            table.insert(instancePoints, point)
        end
    end

    table.sort(instancePoints, function(a, b) return a[2] < b[2] end)

    for _, point in pairs(instancePoints) do
       families[point[3]]:place(point[1], point[2])
    end

    love.graphics.setCanvas()
end
