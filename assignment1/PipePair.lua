--[[
    PipePair Class

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Used to represent a pair of pipes that stick together as they scroll, providing an opening
    for the player to jump through in order to score a point.
]]

PipePair = Class{}

-- ****************************************************************************** --
-- size of the gap between pipes
-- local GAP_HEIGHT = 90
math.randomseed(os.time()) -- needed to get random num list based on run time
local GAP_HEIGHT = math.random(96, 144) -- modified so rand num in range 96 < y < 144

-- ****************************************************************************** --

function PipePair:init(y)
    -- flag to hold whether this pair has been scored (jumped through)
    self.scored = false
	
-- ****************************************************************************** --
    -- initialize pipes past the end of the screen
    -- self.x = VIRTUAL_WIDTH + 32
    self.x = VIRTUAL_WIDTH + math.random(8, 64) -- gap can now be 0.5sec < t < 4sec apart
	
-- ****************************************************************************** --

    -- y value is for the topmost pipe; gap is a vertical shift of the second lower pipe
    self.y = y

    -- instantiate two pipes that belong to this pair
	
	-- *********************************************** --
	GAP_HEIGHT =  math.random(96, 144) --pseudorandom gapheights
	-- *********************************************** --

    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    -- whether this pipe pair is ready to be removed from the scene
    self.remove = false
end

function PipePair:update(dt)
    -- remove the pipe from the scene if it's beyond the left edge of the screen,
    -- else move it from right to left
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for l, pipe in pairs(self.pipes) do
        pipe:render()
    end
end