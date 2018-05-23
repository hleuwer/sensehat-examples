local sense = require "sensehat"
local sleep = require("socket").sleep

sense.setRotation(0)
sense.setLowLight(true)
local width, height = 8, 8

sense.clear()
local y = 0
for x = 0, width -1 do
   sense.setPixel(x, y, 0, 255, 0)
   sleep(0.05)
end	

y = height - 1
for x = 0, width - 1 do
   sense.setPixel(x, y, 0, 0, 255)
   sleep(0.05)
end

for y = 1,3 do
   for x = 0, y - 1 do
      sense.setPixel(x, y, 255, 0, 0)
      sleep(0.05)
   end
end

sleep(10)
