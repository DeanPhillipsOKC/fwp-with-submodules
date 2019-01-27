#!/usr/bin/env bash
PLACE_ID="2751232980"

unix2dos ./FishingWithPets.rbxlx

RESULT=$(curl -v -X POST --data-binary @FishingWithPets.rbxlx \
    -H "COOKIE: .ROBLOSECURITY=$ROBLOXSECURITY" \
    -H "USER-AGENT: Roblox/WinInet" \
    -H "Requester: Client" \
    -H "CONTENT-TYPE: application/xml" \
    -H "ACCEPT: application/json" \
    "https://data.roblox.com/Data/Upload.ashx?assetid=$PLACE_ID")

if [ "$RESULT" != $PLACE_ID ]
then
    echo "$RESULT"
    echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo "# # #   E R R O R   U P L O A D I N G   T H E   P L A C E   F I L E !   # # #"
    echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    exit 100
fi