-- function spawns monster at bloodPosition if player spilled blood on it. Usage:
-- Call it in fluids.lua after line 83, before end of else statement. Parameters:
-- positionsAndItems (array with objects [pos = Position(), itemId = 1234])
-- bloodPosition (position of where blood needs to be spilled)
-- monster (name of monster to be spawned)
-- playerActionPosition (pass action position)
function monsterSpawningRitual(positionsAndItems, bloodPosition, monster, playerActionPosition) 
	if bloodPosition ~= playerActionPosition then
		return false
	end

	-- check if items are present at designated positions
	for _,obj in ipairs(positionsAndItems) do
		local tile = Tile(obj.pos)

		if not tile then
			return false
		end

		if tile:getTopVisibleThing():getId() ~= obj.itemId then
			return false
		end
	end

	-- remove items and create flame effects
	for _,obj in ipairs(positionsAndItems) do
		local tile = Tile(obj.pos)
		tile:getPosition():sendMagicEffect(CONST_ME_HITBYFIRE)
		tile:getTopVisibleThing():remove()
	end

	-- summon monster
	Game.createMonster(monster, bloodPosition)

	return true
end

-- example of how to use monsterSpawningRitual to create a cross pattern with 4 items and blood in the middle
function monsterSpawningRitualCrossPattern(itemTopLeft, itemTopRight, itemBottomLeft, itemBottomRight, bloodPosition, monster, playerActionPosition)
	return monsterSpawningRitual({ 
		{pos = Position(bloodPosition.x - 1, bloodPosition.y - 1, bloodPosition.z), itemId = itemTopLeft},
		{pos = Position(bloodPosition.x + 1, bloodPosition.y - 1, bloodPosition.z), itemId = itemTopRight},
		{pos = Position(bloodPosition.x - 1, bloodPosition.y + 1, bloodPosition.z), itemId = itemBottomLeft},
		{pos = Position(bloodPosition.x + 1, bloodPosition.y + 1, bloodPosition.z), itemId = itemBottomRight}
	}, bloodPosition, monster, playerActionPosition)
end
