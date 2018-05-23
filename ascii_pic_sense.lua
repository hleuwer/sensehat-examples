#!/usr/bin/env lua

sense = require "sensehat"
socket = require "socket"

sense.setRotation(180)
local height, width = 8, 8

local ASCIIPIC={
   "  XXXX  ",
   " X    X ",
   "X X  X X",
   "X      X",
   "X X  X X",
   "X  XX  X",
   " X    X ",
   "  XXXX  "	
}

local ASCIIPIC={
   "  XXXX  ",
   " XXXXXX ",
   "XX-XX-XX",
   "XXXXXXXX",
   "XXXXXXXX",
   "XX-XX-XX",
   " XX--XX ",
   "  XXXX  ",	
   "        ",
   "        ",
   "        ",
   "        ",
   "        ",
   "        ",
   "        ",
   "        "
}
local i = -1

local function step()
   if i >= 100 * #ASCIIPIC then
      i = 0
   else
      i = i + 1
   end
   for h = 0, height - 1 do
      for w = 0, width - 1 do
         local hPos = (i + h) % #ASCIIPIC
         chr = string.sub(ASCIIPIC[hPos+1], w+1, w+1)
         if chr == " " then
            sense.setPixel(w, h, 0, 0, 0)
         elseif chr == "-" then
            sense.setPixel(w, h, 255, 255, 255)
         else
            sense.setPixel(w, h, 255, 255, 0)
         end
      end
   end   
end

while true do
   step()
   socket.sleep(0.2)
end
