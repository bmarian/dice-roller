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

  local selectedDiceName = diceOrder[selectedDiceIndex]
  local selectedDice = DICE_MENU_POSITION[selectedDiceName]
  local selectedDiceSprite = menuDiceSpritesMap[selectedDiceName]
  local selectedDiceImage = selectedDiceSprite:getImage()

  selectedDiceImage:setInverted(true)
  selectorIndicatorSprite:moveTo(selectedDice.siX, selectedDice.siY)
  selectorIndicatorSprite:add()
end

function changeSelectedDice(movePositionBy)
  if not selectorIndicatorSprite or not menuDiceSpritesMap or type(movePositionBy) ~= "number" then return nil end

  local previousSelectedDiceIndex = selectedDiceIndex
  selectedDiceIndex += movePositionBy

  if selectedDiceIndex < firtDie then selectedDiceIndex = lastDie end
  if selectedDiceIndex > lastDie then selectedDiceIndex = firtDie end

  local previousSelectedDiceName = diceOrder[previousSelectedDiceIndex]
  local selectedDiceName = diceOrder[selectedDiceIndex]

  local previousSelectedDicePosition = DICE_MENU_POSITION[previousSelectedDiceName]
  local previousSelectedDiceSprite = menuDiceSpritesMap[previousSelectedDiceName]
  local previousselectedDiceImage = previousSelectedDiceSprite:getImage()

  local selectedDicePosition = DICE_MENU_POSITION[selectedDiceName]
  local selectedDiceSprite = menuDiceSpritesMap[selectedDiceName]
  local selectedDiceImage = selectedDiceSprite:getImage()

  previousselectedDiceImage:setInverted(false)
  selectedDiceImage:setInverted(true)
  selectorIndicatorSprite:moveTo(selectedDicePosition.siX, selectedDicePosition.siY)
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
