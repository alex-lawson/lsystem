LSystemTemplates = {
    FractalTree = {
        axiom = '0',
        rules = {
            ['0'] = '1[0]0',
            ['1'] = '11'
        },
        varsFamilyRange = {
            iterations = {2, 6},
            baseAngle = -math.pi / 2,
            branchAngle = {0.1, 2.0},
            segmentLength = {8, 18},
            bloomRadius = {1, 5},
            lineWidth = {1, 3}
        },
        varsInstanceStdev = {
            branchAngle = 0.05,
            segmentLength = 0.4,
            bloomRadius = 0.2,
            baseAngle = 0.02
        },
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColor))
            love.graphics.setLineWidth(self.instanceVars.lineWidth)

            local x, y = baseX, baseY
            local angle = self.instanceVars.baseAngle

            -- normalize height
            local segLen = self.instanceVars.segmentLength / 2 ^ (self.instanceVars.iterations - 3)

            local stack = {}
            for c in self.instanceSequence:gmatch(".") do
                if c == '0' then
                    local sx, sy = math.cos(angle) * segLen, math.sin(angle) * segLen
                    love.graphics.line(x, y, x + sx, y + sy)
                    love.graphics.circle("fill", x + sx, y + sy, self.instanceVars.bloomRadius)
                    x, y = x + sx, y + sy
                elseif c == '1' then
                    local sx, sy = math.cos(angle) * segLen, math.sin(angle) * segLen
                    love.graphics.line(x, y, x + sx, y + sy)
                    x, y = x + sx, y + sy
                elseif c == '[' then
                    table.insert(stack, {x, y, angle})
                    angle = angle + self.instanceVars.branchAngle
                elseif c == ']' then
                    x, y, angle = unpack(table.remove(stack))
                    angle = angle - self.instanceVars.branchAngle
                end
            end
        end
    },
    SierpinskiTriangle = {
        axiom = 'F-G-G',
        rules = {
            ['F'] = 'F-G+F+G-F',
            ['G'] = 'GG'
        },
        varsFamilyRange = {
            iterations = {1, 4},
            baseAngle = 0,
            branchAngle = math.pi / 1.5,
            segmentLength = {10, 25},
            lineWidth = 1
        },
        varsInstanceStdev = {

        },
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColor))
            love.graphics.setLineWidth(self.instanceVars.lineWidth)

            local x, y = baseX, baseY
            local angle = self.instanceVars.baseAngle

            local segLen = self.instanceVars.segmentLength / 2 ^ (self.instanceVars.iterations - 1)

            local stack = {}
            for c in self.instanceSequence:gmatch(".") do
                if c == 'F' or c == 'G' then
                    local sx, sy = math.cos(angle) * segLen, math.sin(angle) * segLen
                    love.graphics.line(x, y, x + sx, y + sy)
                    x, y = x + sx, y + sy
                elseif c == '+' then
                    angle = angle + self.instanceVars.branchAngle
                elseif c == '-' then
                    angle = angle - self.instanceVars.branchAngle
                end
            end
        end
    },
    SierpinskiArrowhead = {
        axiom = 'A',
        rules = {
            ['A'] = '+B-A-B+',
            ['B'] = '-A+B+A-'
        },
        varsFamilyRange = {
            iterations = {3, 5},
            baseAngle = math.pi,
            branchAngle = math.pi / 3,
            segmentLength = {15, 25},
            lineWidth = 1
        },
        varsInstanceStdev = {

        },
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColor))
            love.graphics.setLineWidth(self.instanceVars.lineWidth)

            local x, y = baseX, baseY
            local angle = self.instanceVars.baseAngle

            local segLen = self.instanceVars.segmentLength / 2 ^ (self.instanceVars.iterations - 2)

            local stack = {}
            for c in self.instanceSequence:gmatch(".") do
                if c == 'A' or c == 'B' then
                    local sx, sy = math.cos(angle) * segLen, math.sin(angle) * segLen
                    love.graphics.line(x, y, x + sx, y + sy)
                    x, y = x + sx, y + sy
                elseif c == '+' then
                    angle = angle + self.instanceVars.branchAngle
                elseif c == '-' then
                    angle = angle - self.instanceVars.branchAngle
                end
            end
        end
    }
}
