// Wrapper around LoadMap to Load the correct map scripts
void LoadMapWrapper(string name) {
    // Get the current map name without path or extension
    string[] mapNames = getMap().getMapName().split('/');
    string mapName = mapNames[mapNames.length() - 1];
    mapName = getFilenameWithoutExtension(mapName);

    // Remove the current script (if it exists)
    getMap().RemoveScript(mapName);
    getRules().RemoveScript(mapName);

    if (isServer()) {
        // Load the next map
        LoadMap(name + ".png");
    }


    // Add the related map script
    getMap().AddScript(name + ".as");
    getRules().AddScript(name + ".as");
}

void SendLoadNextMap(string name) {
    CBitStream bit;
    bit.write_string(name);

    getRules().SendCommand(getRules().getCommandID("LoadMap"), bit);
}