local pd <const> = playdate
local gfx <const> = pd.graphics
local diceImageMap = nil

function loadDiceImageMap()
  diceImageMap = {
    d4 = gfx.image.new(DICE_FILES["d4"]),
    d6 = gfx.image.new(DICE_FILES["d6"]),
    d8 = gfx.image.new(DICE_FILES["d8"]),
    d10 = gfx.image.new(DICE_FILES["d10"]),
    d12 = gfx.image.new(DICE_FILES["d12"]),
    d20 = gfx.image.new(DICE_FILES["d20"]),
    d100 = gfx.image.new(DICE_FILES["d100"]),
  }
end

function addDiceSprite(dice, x, y, centerAtZero)
  if type(centerAtZero) ~= "boolean" then centerAtZero = true end
  if not diceImageMap or not dice or not x or not y then return nil end

  local diceImage = diceImageMap[dice]
  if not diceImage then return nil end

  local diceSrpite = gfx.sprite.new(diceImage)
  if centerAtZero then diceSrpite:setCenter(0, 0) end
  diceSrpite:moveTo(x, y)
  diceSrpite:add()

  return diceSrpite
end

function addMenuDiceSprites()
  local menuDiceSpritesMap = {
    d4 = addDiceSprite("d4", DICE_MENU_POSITION["d4"].x, DICE_MENU_POSITION["d4"].y),
    d6 = addDiceSprite("d6", DICE_MENU_POSITION["d6"].x, DICE_MENU_POSITION["d6"].y),
    d8 = addDiceSprite("d8", DICE_MENU_POSITION["d8"].x, DICE_MENU_POSITION["d8"].y),
    d10 = addDiceSprite("d10", DICE_MENU_POSITION["d10"].x, DICE_MENU_POSITION["d10"].y),
    d12 = addDiceSprite("d12", DICE_MENU_POSITION["d12"].x, DICE_MENU_POSITION["d12"].y),
    d20 = addDiceSprite("d20", DICE_MENU_POSITION["d20"].x, DICE_MENU_POSITION["d20"].y),
    d100 = addDiceSprite("d100", DICE_MENU_POSITION["d100"].x, DICE_MENU_POSITION["d100"].y)
  }
  return menuDiceSpritesMap
end
