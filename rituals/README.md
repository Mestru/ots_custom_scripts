# Rituals
Script let's you create a monster spawning ritual. It requires player to put certain items at predetermined locations and spill blood from vial to summon a monster. It can be used to spawn bosses from gathered materials or summon demons from the underworld.

# Requirements
Script was tested using TFS 1.4, might or might not work with different versions. Refer to troubleshooting guide below for possible solutions

# How to use
1. Add *'rituals.lua'* file to *'data/actions/scripts/other'* directory
2. Add `require 'data/actions/scripts/other/rituals'` at the top of *'data/actions/scripts/other/fluids.lua'*
3. Create rituals by calling either `monsterSpawningRitualCrossPattern(itemTopLeft, itemTopRight, itemBottomLeft, itemBottomRight, bloodPosition, monster, playerActionPosition)` if you want to create a simple cross pattern ritual with blood in the middle or `monsterSpawningRitual(positionsAndItems, bloodPosition, monster, playerActionPosition)` if you want to create custom combination of items, their placements and where to spill blood at.

Summoning functions from point 3 have to be called in *fluids.lua* file after line 83: `item:transform(item:getId(), 0)` or in case you're using TFS 1.5, after line 79: `item:transform(item:getId(), FLUID_NONE)`. 

# Examples
1. `monsterSpawningRitualCrossPattern(2472, 2470, 2471, 2646, Position(94, 126, 7), "Demon", toPosition)`

https://user-images.githubusercontent.com/12278194/160024500-a7147f11-832d-417c-98b8-3594b5eaee3e.mp4

2. 
```
monsterSpawningRitual({ 
	{pos = Position(92, 124, 7), itemId = 2152},
	{pos = Position(93, 122, 7), itemId = 2148},
	{pos = Position(98, 122, 7), itemId = 2148}
}, Position(93, 123, 7), "Rat", toPosition)
 ```

https://user-images.githubusercontent.com/12278194/160024768-bc7be56d-6741-4021-b03e-e60a46a7c31b.mp4

# Troubleshooting
**Problem**: Nil issue in distillery part of fluids.lua
```
Lua Script Error: [Action Interface]
data/actions/scripts/other/fluids.lua:onUse
data/global.lua:101: bad argument #1 to 'pairs' (table expected, got nil)
stack traceback:
        [C]: at 0x7ff6b09c1af0
        [C]: in function 'pairs'
        data/global.lua:101: in function 'contains'
        data/actions/scripts/other/fluids.lua:66: in function <data/actions/scripts/other/fluids.lua:27>
```
Your Tibia version doesn't support distilling rum and because of that it crashes the script when trying to spill fluid on the floor.

**Solution**:
In *fluids.lua* change your line 66 (or 65 if you didn't include rituals yet) from  
`elseif table.contains(distillery, target.itemid) then`  
to  
`elseif distillery and table.contains(distillery, target.itemid) then`
