#!/usr/bin/env bash
curl -H "COOKIE: .ROBLOXSECURITY=$ROBLOXSECURITY" -H "USER_AGENT: Roblox/WinInet" -H "Requester: Client" -H "CONTENT_TYPE: application/xml" -H "ACCEPT: application/json" -X POST -d @FishingWithPets.rbxlx https://data.roblox.com/Data/Upload.ashx?assetid=2751232980

#    let url = format!("", options.asset_id);

# -H "Accept-Charset: utf-8"

#    let client = reqwest::Client::new();
#    let mut response = client.post(&url)
#        .header(COOKIE, format!(".ROBLOSECURITY={}", &options.security_cookie))
#        .header(USER_AGENT, "Roblox/WinInet")
#        .header("Requester", "Client")
#        .header(CONTENT_TYPE, "application/xml")
#        .header(ACCEPT, "application/json")
#        .body(contents)
#        .send()?;