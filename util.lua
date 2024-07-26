-- Retourne la distance entre 2 points
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Retourne l'angle entre les 2 coordonnées
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

-- Teste la collision entre 2 sprites rectangulaires
function collide(a1, a2)
  local x1,y1,x2,y2
  x1 = a1.x-a1.l/2
  x2 = a2.x-a2.l/2
  y1 = a1.y-a1.h/2
  y2 = a2.y-a2.h/2
  if a1.offsetY ~= nil then y1 = y1 - a1.offsetY end
  if a2.offsetY ~= nil then y2 = y2 - a2.offsetY end
  return x1 < x2+a2.l and
         x2 < x1+a1.l and
         y1 < y2+a2.h and
         y2 < y1+a1.h
end