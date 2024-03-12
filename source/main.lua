import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "scripts/dice"
import "scripts/constants"
import "scripts/ux"

local pd <const> = playdate
local gfx <const> = pd.graphics
local menuDiceSpritesMap = nil

function initializeGameAssets()
    local backgroundImage = gfx.image.new("Images/GameWindow")
    gfx.sprite.setBackgroundDrawingCallback(function(x, y, width, height) backgroundImage:draw(0, 0) end)

    menuDiceSpritesMap = addMenuDiceSprites()
end

initializeGameAssets()
initializeUx(menuDiceSpritesMap)

function pd.update()
    updateUx()

    gfx.sprite.update()
    pd.timer.updateTimers()
end
