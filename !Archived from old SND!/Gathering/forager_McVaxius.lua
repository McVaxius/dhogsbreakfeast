--[[
forager.lua

just a general idea of how a forager could work
maybe this should be done as a plugin once nvavmesh is done

pseudocode
********************************************************************************************************************************************************
load list of items from .ini file with what we want to gather.  we can come up with a way to use a "crafting as a service" export directly.
	we can probably generate missing data if we are going to pull in data from craftingasaservice.
	for reference the website is : https://ffxivcrafting.com
	we can generate and maintain offline a list of all the things we need to make that work so we can build a proper import tool within the lua script

alternatively can we get the list of stuff directly from artisan?
	we'd need an artisan api or ipc

mainloop
	list what is left with a x/y total on each loop
	item -> open gather log -> get flag
		we have an area name and a flag now.  the gather log shows a radius too but we'd need some more functions to grab that
		pass (area, flag, radius) to a function that will solve reaching a zone and just vnavmesh flies to the x,y,zone
	gather!

	gather solver of some kind. (it will pick a specific item and work on it till its done. except in a case of a legendary node)
		navmeshing to nearby nodes that have what we need
		can we target things within a certain radius of a x,y,z loc ?  otherwise we have to hack something together
		if our shit isnt visible. reveal it with the skill that does that for botanist/miner
		gather and getnumberofitems() to see how many we have until we have enough
		iterate to next item or stop everything if we need a legend item and the legendtime isnt null, go to that and do eet.
mainloop end

mainloop2
	fire up artisan
	craft the list you have made already for the items you need
mainloop2 end
turn multi back on
********************************************************************************************************************************************************
pseudocode end

missing tech to make this work:
	solving getting to an area with a function or a plugin
	targeting things with x,y,z,r  where r = radius
	vnavmesh still missing caching so its not really gonna be great
	artisan
		exporting list of needed items (does this exist yet?)
		running a crafting list via / command (this exists i think?)
	getting data from the gather log
		radius
		name or id of area? 
]]
