--[[

  ____  _ _             _ 
 |  _ \(_) | _____   __| |
 | |_) | | |/ / _ \ / _  |
 |  __/| |   < (_) | (_| |
 |_|   |_|_|\_\___/ \____| tarafından yapılmıştır.

]]--

AddCSLuaFile()
AddCSLuaFile("board_config.lua")
resource.AddWorkshop("2572932664")

PointBoard = {}

function PointBoard:ConfigLoad()
	self.BACKGROUND = Material(self.BACKGROUND)

	self.GRYFFINDOR = Material(self.GRYFFINDOR)
	self.HUFFLEPUFF = Material(self.HUFFLEPUFF)
	self.RAVENCLAW = Material(self.RAVENCLAW)
	self.SLYTHERIN = Material(self.SLYTHERIN)

	self.OPACITY = Color(0, 0, 0, self.OPACITY)

	if CLIENT then
		for i = 1, 10 do
			surface.CreateFont( "PointBoard_"..i, {
				font = self.FONT,
				extended = true,
				size = (i + 3) * 6,
				weight = 200
			} )
		end
	end
end

include("board_config.lua")