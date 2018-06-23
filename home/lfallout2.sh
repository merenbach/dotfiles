# /usr/bin/env WINEPREFIX="${HOME}/games/wine/fallout2" wine $@
MYWINEPREFIX=$HOME/games/wine/fallout2
cd "$MYWINEPREFIX/drive_c/GOG Games/Fallout 2"
env WINEPREFIX=$MYWINEPREFIX WINEDLLOVERRIDES="ddraw.dll=n" wine FALLOUT2.EXE

# env WINEPREFIX=$HOME/games/wine/fallout2 wine FALLOUT2.EXE
