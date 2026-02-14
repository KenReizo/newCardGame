local love = require("love")
function Button(text, func, w, h)
    return {
        x = 0,
        y = 0,
        width = w,
        height = h,
        text = text,
        func = func or function() print("This button has no function") end,

        draw = function(self, x, y)
            self.x = x
            self.y = y
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print(self.text, self.x + 10, self.y + (self.height / 2 - 8))
            love.graphics.setColor(1, 1, 1)
        end
    }
end

return Button
