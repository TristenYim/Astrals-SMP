summon item ~ ~ ~ {Glowing:1b,Item:{id:"minecraft:amethyst_shard",Count:1b,tag:{display:{Name:'{"text":"Sagacity Focus","color":"yellow","bold":false}',Lore:['{"text":"Soul Cost: 10","color":"white"}']},HideFlags:122,Unbreakable:1b,CustomModelData:17,hexbladeid:0}},Tags:["target"]}

execute as @e[type=item,tag=target] store result entity @s Item.tag.hexbladeid double 1 run scoreboard players get @p hexbladeid