-----------------------------------------------------------------------------------------
-----------------------Interface et inventaire-------------------------------------------
-----------------------------------------------------------------------------------------
local interface = {}
interface.dial = {}
interface.dial.x = 0
interface.dial.y = 0
interface.dial.l = 0
interface.dial.h = 0

interface.inventaire = {}
interface.inventaire.x = 360/3
interface.inventaire.y = 30/3
interface.inventaire.l = 24
interface.inventaire.h = 20
-- Centre de l'inventaire
interface.inventaire.cx = interface.inventaire.x + interface.inventaire.l/2
interface.inventaire.cy = interface.inventaire.y + interface.inventaire.h/2
-- Item actuel
interface.inventaire.item = nil

function suppInventaire ()
  interface.inventaire.item.suppr = true
  interface.inventaire.item = nil
end
--
function newItem (pItem)
  --print("Item ajouté à l'inventaire")
  interface.inventaire.item = pItem
  pItem.x = interface.inventaire.cx
  pItem.y = interface.inventaire.cy
  pItem.vx = 0
  pItem.vy = 0
end
--
interface.update = function(dt)
end
--
function interface.draw ()
  local n
  local x,y
  -- Position de la liste des vies
  x = 450/3
  y = 30/3
 
  -- Dessine l'item porté actuellement
  love.graphics.rectangle("line", interface.inventaire.x, interface.inventaire.y, interface.inventaire.l, interface.inventaire.h)
end
--
return interface
