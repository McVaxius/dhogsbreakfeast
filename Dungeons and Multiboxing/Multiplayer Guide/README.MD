## Multiplayer guide

Few considerations.
- [x] Multibox Limit - You will need Either Simpletweaks or bossmod.  Either will remove the limit.  In Simpletweaks you need to find the config option.  In bossmod it's automatic without your intervention.
- [x] FRENRIDER -> its in this repo. try it out.
-----------------------

Changes to old setup for multi client launch.
Previously you would do something like this:
```start "" /d "%USERPROFILE%\AppData\Local\XIVLauncher" "%USERPROFILE%\AppData\Local\XIVLauncher\XIVLauncher.exe" --roamingPath="D:\FF14\!gil\Account4"```

Now it is like this (add the \current):
```start "" /d "%USERPROFILE%\AppData\Local\XIVLauncher\current" "%USERPROFILE%\AppData\Local\XIVLauncher\current\XIVLauncher.exe" --roamingPath="D:\FF14\!gil\Account4"```

-----------------------
Instructions for Multi Dalamud
Simply copy the ```%appData%\xivlauncher```  folder and then specify that path in the .bat file as above ```D:\FF14\!gil\Account4```

protip if you want it on the taskbar.
- rename the .bat to a .exe.
- drag it to the task bar
- rename it back to .bat in explorer.
- rename it back to .bat in the taskbar entry.

-----------------------
Instructions for Multi Game Config (so you can have different window settings etc)


Extra tip for multi game config if you want multi monitors to always "take"
-----------------------



Defunct guide from punish disc:
https://discord.com/channels/1001823907193552978/1147576996319219713/1239877613284229181
