scoreboard objectives add timer dummy
scoreboard players add effect timer 1
execute if score effect timer matches 110 run scoreboard players reset effect timer

team add default
execute as @a[team=] run team join default @s
team modify default nametagVisibility hideForOtherTeams
team modify default seeFriendlyInvisibles false
team modify default friendlyFire true

team modify afkDis.afk nametagVisibility hideForOtherTeams

team add hideNames
team modify hideNames nametagVisibility hideForOwnTeam
team modify hideNames friendlyFire true
team modify hideNames seeFriendlyInvisibles false
scoreboard objectives add hidenametags trigger
scoreboard players enable @a hidenametags
execute as @a if score @s hidenametags matches 1 run team join hideNames @s
execute as @a if score @s hidenametags matches 1 run scoreboard players reset @s hidenametags

scoreboard objectives add shownametags trigger
scoreboard players enable @a shownametags
execute as @a if score @s shownametags matches 1 run team leave @s
execute as @a if score @s shownametags matches 1 run scoreboard players reset @s shownametags

#execute if score effect timer matches 5 run execute as @a if entity @s[nbt={Inventory:[{Slot:103b,id:"deeperdarker:warden_helmet"},{Slot:102b,id:"deeperdarker:warden_chestplate"},{Slot:101b,id:"deeperdarker:warden_leggings"},{Slot:100b,id:"deeperdarker:warden_boots"}]}] run effect give @s resistance 7 0 true
#execute if score effect timer matches 5 run execute as @a if entity @s[nbt={Inventory:[{Slot:103b,id:"deeperdarker:warden_helmet"},{Slot:102b,id:"deeperdarker:soul_elytra"},{Slot:101b,id:"deeperdarker:warden_leggings"},{Slot:100b,id:"deeperdarker:warden_boots"}]}] run effect give @s resistance 7 0 true

execute if score effect timer matches 5 run execute as @a if entity @s[nbt={Inventory:[{Slot:103b,id:"enderitemod:enderite_helmet"},{Slot:102b,id:"enderitemod:enderite_chestplate"},{Slot:101b,id:"enderitemod:enderite_leggings"},{Slot:100b,id:"enderitemod:enderite_boots"}]}] run effect give @s resistance 7 0 true
execute if score effect timer matches 5 run execute as @a if entity @s[nbt={Inventory:[{Slot:103b,id:"enderitemod:enderite_helmet"},{Slot:102b,id:"enderitemod:enderite_elytra"},{Slot:101b,id:"enderitemod:enderite_leggings"},{Slot:100b,id:"enderitemod:enderite_boots"}]}] run effect give @s resistance 7 0 true

execute if score effect timer matches 5 run execute as @a if entity @s[nbt={Inventory:[{Slot:103b,id:"betterend:aeternium_helmet"},{Slot:102b,id:"betterend:aeternium_chestplate"},{Slot:101b,id:"betterend:aeternium_leggings"},{Slot:100b,id:"betterend:aeternium_boots"}]}] run effect give @s strength 7 0 true
execute if score effect timer matches 5 run execute as @a if entity @s[nbt={Inventory:[{Slot:103b,id:"betterend:aeternium_helmet"},{Slot:102b,id:"betterend:elytra_armored"},{Slot:101b,id:"betterend:aeternium_leggings"},{Slot:100b,id:"betterend:aeternium_boots"}]}] run effect give @s strength 7 0 true

execute if score effect timer matches 5 run execute as @a if entity @s[nbt={Inventory:[{Slot:103b,id:"adventurez:gilded_netherite_helmet"},{Slot:102b,id:"adventurez:gilded_netherite_chestplate"},{Slot:101b,id:"adventurez:gilded_netherite_leggings"},{Slot:100b,id:"adventurez:gilded_netherite_boots"}]}] run effect give @s strength 7 0 true

