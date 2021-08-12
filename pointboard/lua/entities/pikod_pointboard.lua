--[[

  ____  _ _             _ 
 |  _ \(_) | _____   __| |
 | |_) | | |/ / _ \ / _  |
 |  __/| |   < (_) | (_| |
 |_|   |_|_|\_\___/ \____| tarafından yapılmıştır.

]]--

AddCSLuaFile()

ENT.PrintName = "Point Board"

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.ClassName = "pikod_pointboard"
ENT.Category =  "Pikod Hogwarts"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.IconOverride = "pikod_pointboard.png"

function ENT:Initialize()

	self:SetModel("models/props_c17/Frame002a.mdl")
	self:SetModelScale(5.2)

	self:SetAngles(Angle(0, 180, 90))

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phy = self:GetPhysicsObject()
	if (phy:IsValid()) then
		phy:Wake()
	end

end

local function GetPercent(num, percent)
		return (num * percent) / 100
end

local function GetMax(num1, num2, num3, num4)
		if num1 > num2 and num1 > num3 and num1 > num4 then
			return num1
		end
		if num2 > num1 and num2 > num3 and num2 > num4 then
			return num2
		end
		if num3 > num1 and num3 > num2 and num3 > num4 then
			return num3
		end
		if num4 > num1 and num4 > num2 and num4 > num3 then
			return num4
		end
		return 1
end

local startX = -350
local startY = -250

local width = 700
local height = 500

function ENT:Draw()

	self:DrawModel()

	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(), 270)
	
	cam.Start3D2D( self:GetPos(), ang, 0.2 )
		local gryffindorPuan = GetGlobalInt("puan_gryffindor", 0)
		local hufflepuffPuan = GetGlobalInt("puan_hufflepuff", 0)
		local slytherinPuan = GetGlobalInt("puan_slytherin", 0)
		local ravenclawPuan = GetGlobalInt("puan_ravenclaw", 0)

		if PointBoard then
			if PointBoard.BACKGROUND then
				--> Background image
				surface.SetMaterial(PointBoard.BACKGROUND)
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawTexturedRect(startX, startY, width, height)
			end

			--> Opacity
			draw.RoundedBox(0, startX, startY, width, height, PointBoard.OPACITY)

			--> Server name
			draw.DrawText(PointBoard.SERVER_NAME, "PointBoard_8", startX + width / 2, startY + GetPercent(height, 10), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)

			--> House logo (settings)
			local centerX = startX + GetPercent(width, 50)
			local logoY = startY + GetPercent(height, 75)

			local space = 6
			local boxHeightPercent = 40
			local sizePercent = 12

			--> House logo (prepare)
			local size = GetPercent(width, sizePercent)
			local boxHeight = GetPercent(height, boxHeightPercent)

			--> House logo (print)
			local firstX = centerX - size - GetPercent(width, space) - size - GetPercent(width, space / 2)
			surface.SetMaterial(PointBoard.GRYFFINDOR)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(firstX, logoY, size, size)

			local secondX = centerX - size - GetPercent(width, space / 2)
			surface.SetMaterial(PointBoard.HUFFLEPUFF)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(secondX, logoY, size, size)

			local thirthX = centerX + GetPercent(width, space / 2)
			surface.SetMaterial(PointBoard.RAVENCLAW)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(thirthX, logoY, size, size)

			local forthX = centerX + GetPercent(width, space) + size + GetPercent(width, space / 2)
			surface.SetMaterial(PointBoard.SLYTHERIN)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(forthX, logoY, size, size)

			local max = GetMax(gryffindorPuan, hufflepuffPuan, ravenclawPuan, slytherinPuan)

			--> House box
			local boxY = logoY - size - (boxHeight / 2) - GetPercent(height, 8)
			local gryffindorBoxHeight = GetPercent(boxHeight, (gryffindorPuan/max) * 100)
			local hufflepuffBoxHeight = GetPercent(boxHeight, (hufflepuffPuan/max) * 100)
			local ravenclawBoxHeight = GetPercent(boxHeight, (ravenclawPuan/max) * 100)
			local slytherinBoxHeight = GetPercent(boxHeight, (slytherinPuan/max) * 100)

			local gryffindorBoxY = boxY + (boxHeight - gryffindorBoxHeight)
			local hufflepuffBoxY =  boxY + (boxHeight - hufflepuffBoxHeight)
			local ravenclawBoxY = boxY + (boxHeight - ravenclawBoxHeight)
			local slytherinBoxY = boxY + (boxHeight - slytherinBoxHeight)
			draw.RoundedBoxEx(10, firstX, gryffindorBoxY, size, gryffindorBoxHeight, Color(201, 48, 48), true, true, false, false)
			draw.RoundedBoxEx(10, secondX, hufflepuffBoxY, size, hufflepuffBoxHeight, Color(219, 240, 31), true, true, false, false)
			draw.RoundedBoxEx(10, thirthX, ravenclawBoxY, size, ravenclawBoxHeight, Color(39, 78, 232), true, true, false, false)
			draw.RoundedBoxEx(10, forthX, slytherinBoxY, size, slytherinBoxHeight, Color(39, 232, 55), true, true, false, false)
			
			--> Line
			draw.RoundedBox(0, firstX, logoY - GetPercent(height, 5), (size * 4) + (GetPercent(width, space) * 3), 2, Color(255, 255, 255))
		
			--> Score texts

			surface.SetFont("PointBoard_3")
			_, textHeight = surface.GetTextSize( gryffindorPuan )

			draw.DrawText(gryffindorPuan, "PointBoard_3", firstX + size / 2, gryffindorBoxY + (gryffindorBoxHeight / 2) - textHeight / 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
			draw.DrawText(hufflepuffPuan, "PointBoard_3", secondX + size / 2, hufflepuffBoxY + (hufflepuffBoxHeight / 2) - textHeight / 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
			draw.DrawText(ravenclawPuan, "PointBoard_3", thirthX + size / 2, ravenclawBoxY + (ravenclawBoxHeight / 2) - textHeight / 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
			draw.DrawText(slytherinPuan, "PointBoard_3", forthX + size / 2, slytherinBoxY + (slytherinBoxHeight / 2) - textHeight / 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
		end
	cam.End3D2D()

end