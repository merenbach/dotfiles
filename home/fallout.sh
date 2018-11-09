#! /bin/sh

    #gdiplus_dir: "{{ home_dir }}/.cache/winetricks/gdiplus"
    #gdiplus_exe: "{{ home_dir }}/games/patches/NDP1.0sp2-KB830348-X86-Enu.exe"
    #wine_base: "{{ home_dir }}/games/wine/fallout2"
    #game_base: "{{ wine_base }}/dosdevices/c:/GOG Games/Fallout 2" 
    #setup_exe: "{{ home_dir }}/Dropbox/FalloutGog/Fallout2/setup_fallout2_2.0.0.12.exe"
    #patch_exe: "{{ home_dir }}/games/patches/F2_Restoration_Project_2.3.2.exe"
    #f2_res_pixel_width: 1600
    #f2_res_pixel_height: 900
  #tasks:
    ##- name: ensure winetricks is installed
    ##  apt: pkg=winetricks state=latest update_cache=yes

MY_WINEROOT="${HOME}/games/wine"
MY_WINEPREFIX="${MY_WINEROOT}/fallout2"
MY_GAMEDIR="${MY_WINEPREFIX}/drive_c/GOG Games/Fallout 2"
MY_ARCHIVE="${HOME}/games/gog-installed/fallout2_2.0.0.12.tgz"

run_wine() {
	/usr/bin/env WINEARCH=win32 WINEPREFIX="${MY_WINEPREFIX}" wine "$@"
}

run_winetricks() {
	/usr/bin/env WINEARCH=win32 WINEPREFIX="${MY_WINEPREFIX}" winetricks "$@"
}

# ensure wine root is present
/bin/mkdir -p "${MY_WINEROOT}"

# ensure wine prefix is present

    #- name: ensure gdiplus directory is present
    #  file: path="{{ gdiplus_dir }}" state=directory
    #- name: ensure gdiplus patch is present
    #  copy: src="{{ gdiplus_exe }}" dest="{{ gdiplus_dir }}"
    #- name: ensure gdiplus patch is installed
    #  command: /usr/bin/env WINEPREFIX="{{ wine_base }}" winetricks --force gdiplus
    #  #command: /usr/bin/env WINEPREFIX="{{ wine_base }}" winetricks --force gdiplus creates="{{ wine_base }}/dosdevices/c:/windows/temp/_gdiplus"

# WINEDLLOVERRIDES="ddraw.dll=n" wine FALLOUT2.EXE
run_wine wineboot

## install from exe
# /usr/bin/env WINEPREFIX="${MY_WINEPREFIX}" winetricks dotnet40
# /usr/bin/env WINEPREFIX="${MY_WINEPREFIX}" winetricks gdiplus

# This step could also just entail unzipping an archive
# ensure game is installed
run_wine "${HOME}/games/gog/fallout_2_classic/setup_fallout2_2.0.0.12.exe"

# tar xf "${MY_ARCHIVE}" -C "${MY_WINEPREFIX}/drive_c"

# ensure game patch is installed
run_wine "${HOME}/games/patches/fallout2/F2_Restoration_Project_2.3.3.exe"
#run_wine "${HOME}/games/patches/fallout2/unofficialFO2patch.exe"
      
# ensure wine overrides ddraw.dll
# this should come after installation
# Don't specify .dll after ddraw!
#/usr/bin/env WINEPREFIX="${MY_WINEPREFIX}" winetricks ddraw=native

# ensure game prototypes are read-only
# chmod 0444 "${MY_GAMEDIR}/[dD]ata/[pP]roto/[iI]tems/*" "${MY_GAMEDIR}/[dD]ata/[pP]roto/[cC]ritters/*"


    #- name: ensure game is not UAC aware
    #  lineinfile: dest="{{ game_base }}/f2_res.ini"
    #              line='UAC_AWARE=0'
    #              regexp='^UAC_AWARE='
    #- name: ensure game uses DirectX 9
    #  lineinfile: dest="{{ game_base }}/f2_res.ini"
    #              line='GRAPHICS_MODE=2'
    #              regexp='^GRAPHICS_MODE='
    ###- name: ensure Ddraw9 mode 4 (dx9, fullscreen) is set
    ###  lineinfile: dest="{{ game_base }}/ddraw.ini"
    ###              line='Mode=4'
    ###              regexp='^Mode='
    ##- name: ensure game has proper pixel width
    ##  lineinfile: dest="{{ game_base }}/f2_res.ini"
    ##              line='SCR_WIDTH={{ f2_res_pixel_width }}'
    ##              regexp='^SCR_WIDTH='
    ##- name: ensure game has proper pixel height
    ##  lineinfile: dest="{{ game_base }}/f2_res.ini"
    ##              line='SCR_HEIGHT={{ f2_res_pixel_height }}'
    ##              regexp='^SCR_HEIGHT='
    ##- name: ensure game hides background during dialog
    ##  lineinfile: dest="{{ game_base }}/f2_res.ini"
    ##              line='DIALOG_SCRN_BACKGROUND=1'
    ##              regexp='^DIALOG_SCRN_BACKGROUND='
    ##- name: ensure game NPCs spend all AP
    ##  lineinfile: dest="{{ game_base }}/ddraw.ini"
    ##              line='NPCsTryToSpendExtraAP=1'
    ##              regexp='^NPCsTryToSpendExtraAP='
