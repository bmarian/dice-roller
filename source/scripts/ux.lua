local pd <const> = playdate
local gfx <const> = pd.graphics

local diceOrder <const> = { "d4", "d6", "d8", "d10", "d12", "d20", "d100" }
local selectedDiceIndex = 1
local firtDie <const> = 1
local lastDie <const> = table.getsize(diceOrder)

local diceSelectedForRollMap = {
  d4 = { flagSprite = nil, textSprite = nil, ammount = 0 },
  d6 = { flagSprite = nil, textSprite = nil, ammount = 0 },
  d8 = { flagSprite = nil, textSprite = nil, ammount = 0 },
  d10 = { flagSprite = nil, textSprite = nil, ammount = 0 },
  d12 = { flagSprite = nil, textSprite = nil, ammount = 0 },
  d20 = { flagSprite = nil, textSprite = nil, ammount = 0 },
  d100 = { flagSprite = nil, textSprite = nil, ammount = 0 }
}

local menuDiceSpritesMap = nil
local selectorIndicatorSprite = nil
local resultsTextSprite = nil

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

  local previousSelectedDiceSprite = menuDiceSpritesMap[previousSelectedDiceName]
  local previousselectedDiceImage = previousSelectedDiceSprite:getImage()

  local selectedDicePosition = DICE_MENU_POSITION[selectedDiceName]
  local selectedDiceSprite = menuDiceSpritesMap[selectedDiceName]
  local selectedDiceImage = selectedDiceSprite:getImage()

  previousselectedDiceImage:setInverted(false)
  selectedDiceImage:setInverted(true)
  selectorIndicatorSprite:moveTo(selectedDicePosition.siX, selectedDicePosition.siY)
end

function changeDiceSelectedForRoll(modifier)
  local selectedDiceName = diceOrder[selectedDiceIndex]
  if diceSelectedForRollMap[selectedDiceName]["ammount"] + modifier < 0 or diceSelectedForRollMap[selectedDiceName]["ammount"] + modifier > 99 then return nil end

  local selectedDice = DICE_MENU_POSITION[selectedDiceName]

  local newAmmount = diceSelectedForRollMap[selectedDiceName]["ammount"] + modifier
  if newAmmount > 99 and diceSelectedForRollMap[selectedDiceName]["flagSprite"] and diceSelectedForRollMap[selectedDiceName]["textSprite"] then
    return nil
  end

  diceSelectedForRollMap[selectedDiceName]["ammount"] = newAmmount

  if newAmmount == 0 and diceSelectedForRollMap[selectedDiceName]["flagSprite"] and diceSelectedForRollMap[selectedDiceName]["textSprite"] then
    diceSelectedForRollMap[selectedDiceName]["flagSprite"]:remove()
    diceSelectedForRollMap[selectedDiceName]["textSprite"]:remove()

    diceSelectedForRollMap[selectedDiceName]["flagSprite"] = nil
    diceSelectedForRollMap[selectedDiceName]["textSprite"] = nil

    return nil
  end

  if newAmmount > 0 and diceSelectedForRollMap[selectedDiceName]["flagSprite"] and diceSelectedForRollMap[selectedDiceName]["textSprite"] then
    diceSelectedForRollMap[selectedDiceName]["textSprite"]:remove()

    local textSprite = gfx.sprite.spriteWithText(tostring(newAmmount), FLAG_INNER_SIZE.width, FLAG_INNER_SIZE.height)
    textSprite:setImageDrawMode(gfx.kDrawModeFillBlack)

    textSprite:moveTo(selectedDice.fX + FLAG_TEXT_OFFSET.x, selectedDice.fY + FLAG_TEXT_OFFSET.y)
    textSprite:add()

    diceSelectedForRollMap[selectedDiceName]["textSprite"] = textSprite
  end

  if newAmmount > 0 and not diceSelectedForRollMap[selectedDiceName]["flagSprite"] and not diceSelectedForRollMap[selectedDiceName]["textSprite"] then
    local flagImage = gfx.image.new(FLAG_FILE)
    local flagSprite = gfx.sprite.new(flagImage)

    flagSprite:setCenter(0, 0)
    flagSprite:moveTo(selectedDice.fX, selectedDice.fY)
    flagSprite:add()

    diceSelectedForRollMap[selectedDiceName]["flagSprite"] = flagSprite

    local textSprite = gfx.sprite.spriteWithText(tostring(newAmmount), FLAG_INNER_SIZE.width, FLAG_INNER_SIZE.height)
    textSprite:setImageDrawMode(gfx.kDrawModeFillBlack)

    textSprite:moveTo(selectedDice.fX + FLAG_TEXT_OFFSET.x, selectedDice.fY + FLAG_TEXT_OFFSET.y)
    textSprite:add()

    diceSelectedForRollMap[selectedDiceName]["textSprite"] = textSprite

    return nil
  end
end

function resetDice()
  for i = firtDie, lastDie do
    diceSelectedForRollMap[diceOrder[i]].ammount = 0

    if diceSelectedForRollMap[diceOrder[i]].flagSprite then
      diceSelectedForRollMap[diceOrder[i]].flagSprite:remove()
      diceSelectedForRollMap[diceOrder[i]].flagSprite = nil
    end

    if diceSelectedForRollMap[diceOrder[i]].textSprite then
      diceSelectedForRollMap[diceOrder[i]].textSprite:remove()
      diceSelectedForRollMap[diceOrder[i]].textSprite = nil
    end
  end
end

function rollDice()

end

function updateUx()
  if playdate.buttonJustReleased(playdate.kButtonUp) then
    changeDiceSelectedForRoll(1)
  end
  if playdate.buttonJustReleased(playdate.kButtonRight) then
    changeSelectedDice(1)
  end
  if playdate.buttonJustReleased(playdate.kButtonDown) then
    changeDiceSelectedForRoll(-1)
  end
  if playdate.buttonJustReleased(playdate.kButtonLeft) then
    changeSelectedDice(-1)
  end
  if playdate.buttonJustReleased(playdate.kButtonA) then
    rollDice()
  end
  if playdate.buttonJustReleased(playdate.kButtonB) then
    resetDice()
  end
end
