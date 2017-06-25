util = require 'util'

LSystem = {}

function LSystem:new(config, seed)
    local newLSystem = setmetatable(util.copy(config), {__index=LSystem})

    newLSystem.rng = love.math.newRandomGenerator()

    if seed then
        newLSystem:setSeed(seed)
    end

    return newLSystem
end

function LSystem:setSeed(seedValue)
   self.seed = seedValue
   self.rng:setSeed(seedValue)
   self:generateFamilyVars()
   self:generateFamilyColor()
end

function LSystem:generateFamilyVars()
    self.familyVars = {
        iterations = 1 -- required, so defaulted
    }
    for k, range in pairs(self.varsFamilyRange) do
        if type(range) == "number" then
            self.familyVars[k] = range
        else
            self.familyVars[k] = self.rng:random() * (range[2] - range[1]) + range[1]
        end
    end
end

function LSystem:generateFamilyColor()
    self.familyColor = {self.rng:random(1, 255), self.rng:random(1, 255), self.rng:random(1, 255)}
end

function LSystem:generateInstanceVars()
    self.instanceVars = util.copy(self.familyVars)
    for k, stdev in pairs(self.varsInstanceStdev) do
       self.instanceVars[k] = self.instanceVars[k] + self.rng:randomNormal(stdev)
    end
end

function LSystem:generateInstanceSequence()
    self.instanceSequence = self.axiom
    local instanceIterations = math.floor(self.instanceVars.iterations + 0.5)
    for i = 1, instanceIterations do
        self.instanceSequence = self:iterate(self.instanceSequence)
    end
end

function LSystem:iterate(sequence)
    return sequence:gsub(".", function(c)
        return self.rules[c] or c
    end)
end

function LSystem:place(baseX, baseY)
    self:generateInstanceVars()
    self:generateInstanceSequence()
    self:render(baseX, baseY)
end
