#!/usr/bin/env lua

local sense = require "sensehat"
local socket = require "socket"

local sleep = socket.sleep
sense.clear()

sense.setPixel(0, 0, 255, 0, 0)
sense.setPixel(0, 1, 255, 0, 0)
sleep(1)
sense.setPixel(1, 1, 0, 255, 0)
sense.setPixel(1, 2, 0, 255, 0)
sleep(1)
sense.setPixel(2, 2, 0, 0, 255)
sense.setPixel(2, 3, 0, 0, 255)
