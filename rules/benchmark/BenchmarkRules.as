#include "MapWrapper.as"

void onInit(CRules@ this) {
    this.addCommandID("LoadMap");
    this.addCommandID("SubStep");
}

void onCommand(CRules@ this, u8 cmd, CBitStream @params) {
    if (cmd == this.getCommandID("LoadMap")) {
        string nextMap; 
		if (!params.saferead_string(nextMap)) return;

        LoadMapWrapper(nextMap);
    }
    else if (cmd == this.getCommandID("SubStep")) {
        u8 substep;
        if (!params.saferead_u8(substep)) return;

        getMap().set_u8("BOX2D_SUBSTEP", substep);
    }
}

void onRender(CRules@ this) {
    if (!ImGui::Begin("Map Loader")) {
        ImGui::End();
        return;
    }


    ImGui::TextColored(SColor(255, 243, 48, 48),"Stress test");
    ImGui::Separator();
    AddMap("Raining Kegs", "raining_kegs");
    AddMap("Ladders", "ladders");
    AddMap("Doors", "doors");
    AddMap("Dirt Spikes", "spikes_dirt");
    AddMap("Stone Spikes", "spikes_stone");
    AddMap("Tiles", "tiles_bedrock");
    AddMap("Overlaps", "overlaps");

    ImGui::Separator();
    ImGui::TextColored(SColor(255, 100, 255, 50), "Test Maps");
    ImGui::Separator();
    AddMap("Basic", "basic");
    AddMap("Water Test", "water_test");
    AddMap("Jump Spam", "jump_spam");
    AddMap("Wall Slide", "wall_check");
    AddMap("Arrow Spam", "arrow_spam");

    ImGui::End();

    if (!ImGui::Begin("Debug Stats")) {
        ImGui::End();
        return;
    }
    ImGui::TextColored(SColor(255, 243, 48, 48),"Engine Stats");
    
    ImGui::TextColored(SColor(255, 243, 48, 48),"Other Crap");
    ImGui::Separator();
    Vec2f pos = Vec2f_zero;
    if (getControls() != null) {
        pos = getControls().getMouseWorldPos();
    }
    ImGui::Text("Mouse Pos: " + pos.x + "," + pos.y);

    ImGui::End();

    if (!ImGui::Begin("Test Menu")) {
        ImGui::End();
        return;
    }

    ImGui::TextColored(SColor(255, 50, 100, 255), "Settings");
    ImGui::Separator();
    
    int newLimit = ImGui::SliderInt("Box2d SubStep", getMap().get_u8("BOX2D_SUBSTEP"), 0, 32);

    if (newLimit != getMap().get_u8("BOX2D_SUBSTEP")) {
        getMap().set_u8("BOX2D_SUBSTEP", newLimit);

        CBitStream bit;
        bit.write_u8(newLimit);

        this.SendCommand(this.getCommandID("SubStep"), bit);
    }

    ImGui::Separator();
    ImGui::TextColored(SColor(255, 255, 120, 120), "Explosion Settings");
    ImGui::Separator();
    // Local host only for now
    this.set_f32("explosion_radius", ImGui::SliderFloat("Radius", this.get_f32("explosion_radius"), 0.0f, 100.0f));
    this.set_f32("explosion_falloff", ImGui::SliderFloat("Falloff", this.get_f32("explosion_falloff"), 0.0f, 100.0f));
    this.set_f32("explosion_strength", ImGui::SliderFloat("Strength", this.get_f32("explosion_strength"), -100.0f, 100.0f));

    ImGui::End();
}


void AddMap(string &in text, string &in map_name) {
    ImGui::SameLine();
    if (ImGui::Button(text)) {
        SendLoadNextMap(map_name);
    }
}