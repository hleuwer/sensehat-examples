#!/usr/bin/env lua

local sense = require "sensehat"
local sleep = require("socket").sleep
local abs = math.abs

local function printf(fmt, ...)
   print(string.format(fmt, ...))
end

local debug = true
local accel_thresh = 0.4
local shake_timer = 3

local b = {0,0,0}
local g = {0,255,0}
local r = {255,0,0}

one = {
b,b,b,b,b,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,g,g,b,b,b,
b,b,b,g,g,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,b,b,b,b,b,
}

two = {
b,b,b,b,b,b,b,b,
b,g,g,b,b,b,b,b,
b,g,g,b,b,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,b,g,g,b,b,
b,b,b,b,g,g,b,b,
b,b,b,b,b,b,b,b,
}

three = {
g,g,b,b,b,b,b,b,
g,g,b,b,b,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,g,g,b,b,b,
b,b,b,g,g,b,b,b,
b,b,b,b,b,b,b,b,
b,b,b,b,b,b,g,g,
b,b,b,b,b,b,g,g,
}

four = {
b,b,b,b,b,b,b,b,
b,g,g,b,b,g,g,b,
b,g,g,b,b,g,g,b,
b,b,b,b,b,b,b,b,
b,b,b,b,b,b,b,b,
b,g,g,b,b,g,g,b,
b,g,g,b,b,g,g,b,
b,b,b,b,b,b,b,b,
}

five = {
g,g,b,b,b,b,g,g,
g,g,b,b,b,b,g,g,
b,b,b,b,b,b,b,b,
b,b,b,g,g,b,b,b,
b,b,b,g,g,b,b,b,
b,b,b,b,b,b,b,b,
g,g,b,b,b,b,g,g,
g,g,b,b,b,b,g,g,
}

six = {
r,r,b,b,b,b,r,r,
r,r,b,b,b,b,r,r,
b,b,b,b,b,b,b,b,
r,r,b,b,b,b,r,r,
r,r,b,b,b,b,r,r,
b,b,b,b,b,b,b,b,
r,r,b,b,b,b,r,r,
r,r,b,b,b,b,r,r,
}

local map = {
   one, two, three, four, five, six
}
local function rollDice()
   local r = math.random(6)
   sense.setPixels(map[r])
end

local intro = {
   "Setting dice.lua ver 1.0",
   "------------------------",
   string.format("debug = %s", tostring(debug)),
   string.format("accel_thresh = %.3f G (delta)", accel_thresh),
   string.format("shake_timer = %d seconds (show die)", shake_timer),
   "------------------------",
   "Loading ..."
}

local function main(...)
   printf("%s", table.concat(intro, "\n"))
   sense.clear()
   sense.showMessage("Shake ...", 0.1)
   printf("Shake to roll the die.")
   local start_time = os.time()
   while true do
      local t = sense.getAccelerometerRaw()
      local x, y, z = t.x, t.y, t.z
      local x1, y1, z1 = abs(x), abs(y), abs(z)
      sleep(0.1)
      local t = sense.getAccelerometerRaw()
      local x, y, z = t.x, t.y, t.z
      local dx = abs(abs(x1) - abs(x))
      local dy = abs(abs(y1) - abs(y))
      local dz = abs(abs(z1) - abs(z))
      if dx > accel_thresh or dy > accel_thresh or dz > accel_thresh then
         if next_roll == true then
            rollDice()
            next_roll = false
            start_time = os.time()
            if debug == true then
               printf("accel base  x1=%.3f y1=%.3f z1=%.3f", x1, y1, z1)
               printf("accel delta dx=%.3f dy=%.3f dz=%.3f", dx, dy, dz)
            end
            printf("Shake ...")
         end
      end
      if os.time() - start_time > shake_timer then
         next_roll = true
         sense.clear()
      end
   end
end

main(...)

