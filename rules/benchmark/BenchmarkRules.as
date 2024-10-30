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
    if (!ImGui::Begin("Benchmark Menu")) {
        ImGui::End();
        return;
    }

    ImGui::TextColored(SColor(255, 243, 48, 48),"Simple Benchmarks");
    ImGui::Separator();
    if (ImGui::Button("Raining Kegs (Empty)")) {
        SendLoadNextMap("raining_kegs");
    }
    ImGui::SameLine();
    if (ImGui::Button("Ladders")) {
        SendLoadNextMap("ladders");
    }
    ImGui::SameLine();
    if (ImGui::Button("Doors")) {
        SendLoadNextMap("doors");
    }
    ImGui::SameLine();
    if (ImGui::Button("Spikes (Dirt)")) {
        SendLoadNextMap("spikes_dirt");
    }
    ImGui::SameLine();
    if (ImGui::Button("Spikes (Stone)")) {
        SendLoadNextMap("spikes_stone");
    }
    ImGui::SameLine();
    if (ImGui::Button("Tile Body")) {
        SendLoadNextMap("tiles_bedrock");
    }
    ImGui::SameLine();
    if (ImGui::Button("Get Blobs")) {
        SendLoadNextMap("getBlobsAt");
    }


    ImGui::Separator();
    ImGui::TextColored(SColor(255, 100, 255, 50), "Dev Maps");
    ImGui::Separator();
    if (ImGui::Button("Basic")) {
        SendLoadNextMap("basic");
    }

    ImGui::Separator();
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


    if (!ImGui::Begin("Debug")) {
        ImGui::End();
        return;
    }

    ImGui::Text("New overlapping shapes: " + getMap().get_u32("OVERLAPPING_BLOBS_STARTED"));
    ImGui::Text("End overlapping shapes: " + getMap().get_u32("OVERLAPPING_BLOBS_ENDED"));
    ImGui::Text("Active proximity shapes: " + getMap().get_s32("ACTIVE_BLOBS"));
    ImGui::Text("Sleeping proximity shapes: " + getMap().get_s32("SLEEP_BLOBS"));

    ImGui::End();
}