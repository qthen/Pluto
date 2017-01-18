--Some requires in order to compare
RoadObject = require("RoadObject")

--The in game memory map used to compare the hidden map inside the code and the rendered map, also for collision checking
--Should be used as a singelton

InGameMemoryMap = {}
InGameMemoryMap.__index = InGameMemoryMap

function InGameMemoryMap.new()
	inGameGrid = {}
	print("instantiating")
	print(love.window.toPixels(768))
	--Set the 1366 x 768 bit mask
	for i=1,1536 do
		inGameGrid[i] = {}
		for j=1,2732 do
			inGameGrid[i][j] = 0
		end
	end

	--Set its metatable
	return setmetatable({ grid = inGameGrid }, InGameMemoryMap)
end


printed = false
--Put some GameObject into the InGameMemoryMap
function InGameMemoryMap:put(inGameObject)
	if getmetatable(inGameObject) == RoadObject then
		--Put it into the map
		local refI, refJ = inGameObject.referencePoint.y, inGameObject.referencePoint.x
		if not printed then
			print(refI)
			print(refJ)
			print(love.window.toPixels(refI) + inGameObject.height)
			print(love.window.toPixels(refJ) +inGameObject.width)
			print(love.window.toPixels(768))
			print(love.window.toPixels(1366))
			printed = true
			print(self.grid[769])
		end

		for i=love.window.toPixels(refI), love.window.toPixels(refI) + inGameObject.height do
			for j=love.window.toPixels(refJ),love.window.toPixels(refJ) +inGameObject.width do
				self.grid[i][j] = inGameObject
			end
		end
	end
end

setmetatable(InGameMemoryMap, { __call = function(_, ...) return InGameMemoryMap.new(...) end})
return InGameMemoryMap
