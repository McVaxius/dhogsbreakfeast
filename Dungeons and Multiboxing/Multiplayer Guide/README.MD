## Multiplayer guide

Few considerations.
- [x] Multibox Limit - You will need Either Simpletweaks or bossmod.  Either will remove the limit.  In Simpletweaks you need to find the config option.  In bossmod it's automatic without your intervention.
- [x] FRENRIDER -> its in this repo. try it out.
-----------------------

Changes to old setup for multi client launch:<br>
Previously you would do something like this:<br>
```start "" /d "%USERPROFILE%\AppData\Local\XIVLauncher" "%USERPROFILE%\AppData\Local\XIVLauncher\XIVLauncher.exe" --roamingPath="D:\FF14\!gil\Account4"```

Now it is like this (add the \current):<br>
```start "" /d "%USERPROFILE%\AppData\Local\XIVLauncher\current" "%USERPROFILE%\AppData\Local\XIVLauncher\current\XIVLauncher.exe" --roamingPath="D:\FF14\!gil\Account4"```

-----------------------
Instructions for Multi Dalamud<br>
Simply copy the ```%appData%\xivlauncher```  folder and then specify that path in the .bat file as above ```D:\FF14\!gil\Account4```<br>

Protip if you want it on the taskbar:<br>
- rename the .bat to a .exe.
- drag it to the task bar
- rename it back to .bat in explorer.
- rename it back to .bat in the taskbar entry.

-----------------------
Instructions for Multi Game Config (so you can have different window settings etc)<br>
- Fire up the launcher from your .bat file
- Click on the Gear Icon
- Additional Launch Arguments -> ```UserPath=D:\FF14\!gil\Account4\```
- Click the Checkmark
- now you will have a separate folder for that dalamud client for all configs etc.

Extra tip for multi game config if you want multi monitors to always "take"<br>
- load into the game on the dalamud client you want to setup
- once in game go to system config
- switch to WINDOWED MODE
- hit apply.
- move the game client to the monitor you want to anchor it to
- go to system config
- switch to windowed borderless mode
- hit apply.
- done. exit and reload it should alwys load on the preferred monitor.

-----------------------



Defunct guide from punish disc:<br>
https://discord.com/channels/1001823907193552978/1147576996319219713/1239877613284229181
