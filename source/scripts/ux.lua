local pd <const> = playdate
local gfx <const> = pd.graphics
local diceOrder <const> = { "d4", "d6", "d8", "d10", "d12", "d20", "d100" }
local selectedDiceIndex = 1
local firtDie <const> = 1
local lastDie <const> = table.getsize(diceOrder)

local menuDiceSpritesMap = nil
local selectorIndicatorSprite = nil

function initializeUx(initialDiceSpritesMap)
  menuDiceSpritesMap = initialDiceSpritesMap

  local selectorIndicatorImage = gfx.image.new(SELECT_INDITAOR_FILE)
  selectorIndicatorSprite = gfx.sprite.new(selectorIndicatorImage)
  selectorIndicatorSprite:setCenter(0, 0)

  local selectedDice = DICE_MENU_POSITION[diceOrder[selectedDiceIndex]]
  selectorIndicatorSprite:moveTo(selectedDice.siX, selectedDice.siY)
  selectorIndicatorSprite:add()
end

function changeSelectedDice(movePositionBy)
  if not selectorIndicatorSprite or type(movePositionBy) ~= "number" then return nil end

  selectedDiceIndex += movePositionBy
  if selectedDiceIndex < firtDie then selectedDiceIndex = lastDie end
  if selectedDiceIndex > lastDie then selectedDiceIndex = firtDie end

  local selectedDice = DICE_MENU_POSITION[diceOrder[selectedDiceIndex]]
  selectorIndicatorSprite:moveTo(selectedDice.siX, selectedDice.siY)
end

function updateUx()
  if playdate.buttonJustReleased(playdate.kButtonUp) then

  end
  if playdate.buttonJustReleased(playdate.kButtonRight) then
    changeSelectedDice(1)
  end
  if playdate.buttonJustReleased(playdate.kButtonDown) then

  end
  if playdate.buttonJustReleased(playdate.kButtonLeft) then
    changeSelectedDice(-1)
  end
end
