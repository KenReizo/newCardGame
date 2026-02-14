local Object = require("lib.classic")
local Site = Object:extend()

function Site:new(type, floor)
    self.super.new(self)
    self.type = type or Game.SiteType.NormalCombat
    self.floor = floor or 1
    self.x = 0
    self.y = 0
    self.size = 50
end

function Site:draw(x, y, size)
    self.size = size or self.size
    self.x = x or (Screen.width / 2) - (self.size / 2)
    self.y = y or (Screen.height * 0.8) - (self.floor * 100)
    if self.type == Game.SiteType.NormalCombat then
        love.graphics.setColor(1, 0, 0)
    end
    if self.type == Game.SiteType.EliteCombat then
        love.graphics.setColor(1, 0, 0.5)
    end
    if self.type == Game.SiteType.BossCombat then
        love.graphics.setColor(1, 0, 1)
    end
    if self.type == Game.SiteType.NormalCombat then
        love.graphics.setColor(0, 1, 0)
    end
    love.graphics.circle("fill", self.x, self.y, 50)
    love.graphics.setColor(1, 1, 1)
end

return Site
