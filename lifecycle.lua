#!/usr/bin/env lua

local sense = require "sensehat"

local accel_thresh = 0.4

local GameOfLife = {
   init = function(self, width, height)
	     self.size = {width, height}
	     self.random_world()
          end,
   str = function(self)
	    
         end	
}
