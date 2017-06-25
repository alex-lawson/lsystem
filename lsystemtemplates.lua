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
        familyColorCount = 2,
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColors[1]))
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
                    love.graphics.setColor(unpack(self.familyColors[2]))
                    love.graphics.circle("fill", x + sx, y + sy, self.instanceVars.bloomRadius)
                    love.graphics.setColor(unpack(self.familyColors[1]))
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
        familyColorCount = 1,
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColors[1]))
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
        familyColorCount = 1,
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColors[1]))
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
    },
    FractalPlant = {
        axiom = 'X',
        rules = {
            ['X'] = 'F[-X][X]F[-X]+FX',
            ['F'] = 'FF'
        },
        varsFamilyRange = {
            iterations = {3, 6},
            baseAngle = -math.pi / 2,
            branchAngle = {10 / 57.3, 50 / 57.3},
            segmentLength = {25, 35},
            lineWidth = 1
        },
        varsInstanceStdev = {
            branchAngle = 0.1,
            segmentLength = 3
        },
        familyColorCount = 1,
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColors[1]))
            love.graphics.setLineWidth(self.instanceVars.lineWidth)

            local x, y = baseX, baseY
            local angle = self.instanceVars.baseAngle

            local segLen = self.instanceVars.segmentLength / 2 ^ (self.instanceVars.iterations - 1)

            local stack = {}
            for c in self.instanceSequence:gmatch(".") do
                if c == 'F' then
                    local sx, sy = math.cos(angle) * segLen, math.sin(angle) * segLen
                    love.graphics.line(x, y, x + sx, y + sy)
                    x, y = x + sx, y + sy
                elseif c == '+' then
                    angle = angle + self.instanceVars.branchAngle
                elseif c == '-' then
                    angle = angle - self.instanceVars.branchAngle
                elseif c == '[' then
                    table.insert(stack, {x, y, angle})
                elseif c == ']' then
                    x, y, angle = unpack(table.remove(stack))
                end
            end
        end
    },
    DerpCactus = {
        proto = {
            ['S'] = {
                choose = 2,
                from = {'BT', '[-BT]BT', 'BT[+BT]', '[-BT]BT[+BT]', '[-BT][+BT]'}
            },
            ['B'] = {
                choose = 2,
                from = {'BB', 'B-B', 'B+B', 'BB[+T]', '[-T]BB'}
            },
            ['T'] = {
                choose = 2,
                from = {'[-BT][+BT]', 'BT', '[-BT]BT', 'BT[+BT]'}
            }
        },
        axiom = 'S',
        rules = {
            ['-'] = '--',
            ['+'] = '++'
        },
        varsFamilyRange = {
            iterations = {3, 5},
            baseAngle = -math.pi / 2,
            branchAngle = {0.05, 0.15},
            segmentSize = {20, 30},
            lineWidth = 2
        },
        varsInstanceStdev = {
            baseAngle = 0.1,
            branchAngle = 0,
            segmentSize = 2
        },
        familyColorCount = 2,
        render = function(self, baseX, baseY)
            love.graphics.setColor(unpack(self.familyColors[1]))
            love.graphics.setLineWidth(self.instanceVars.lineWidth)

            local x, y = baseX, baseY
            local angle = self.instanceVars.baseAngle

            local segSize = self.instanceVars.segmentSize / 2 ^ (self.instanceVars.iterations - 1)

            local stack = {}
            for c in self.instanceSequence:gmatch(".") do
                if c == 'B' then
                    local sx, sy = math.cos(angle) * segSize, math.sin(angle) * segSize
                    love.graphics.setColor(unpack(self.familyColors[1]))
                    love.graphics.circle("fill", x + 0.5 * sx, y + 0.5 * sy, 0.5 * segSize + self.instanceVars.lineWidth)
                    x, y = x + sx, y + sy
                elseif c == 'T' then
                    local sx, sy = math.cos(angle) * segSize, math.sin(angle) * segSize
                    love.graphics.setColor(unpack(self.familyColors[2]))
                    love.graphics.circle("fill", x + 0.5 * sx, y + 0.5 * sy, 0.5 * segSize + self.instanceVars.lineWidth)
                    x, y = x + sx, y + sy
                elseif c == '+' then
                    angle = angle + self.instanceVars.branchAngle
                elseif c == '-' then
                    angle = angle - self.instanceVars.branchAngle
                elseif c == '[' then
                    table.insert(stack, {x, y, angle})
                elseif c == ']' then
                    x, y, angle = unpack(table.remove(stack))
                end
            end
        end
    }
}
