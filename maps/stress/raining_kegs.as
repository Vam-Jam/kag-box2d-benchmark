#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(50, 780);
// Does not matter that it's global
// There is only ever 1 of this script, and both client and server are in sync
int kegCount = 0;

void onInit(CRules@ this) {
    kegCount = 0;
    RespawnAll(SpawnPos);
    this.set_s32("kegLimit", 0);

    if (!this.hasCommandID("kegSyncLimit")) {
        this.addCommandID("kegSyncLimit");
    }
}

void onTick(CRules@ this) {
    int kegLimit = this.get_s32("kegLimit");
    if (kegLimit == 0 || kegCount >= kegLimit) {
        return;
    }

    CBlob@ blob = server_CreateBlob("keg", XORRandom(6), Vec2f(10 + XORRandom(900), 0));
    blob.server_SetHealth(1000.0f);
    blob.Tag("invincible");
    kegCount += 1;
}

void onBlobDie(CRules@ this, CBlob@ blob) {
    if (blob.getName() == "keg") {
        kegCount -= 1;
    }
}

void onCommand(CRules@ this, u8 cmd, CBitStream @params) {
    if (cmd == this.getCommandID("kegSyncLimit") && isServer()) {
        s32 limit; 
		if (!params.saferead_s32(limit)) return;

        this.set_s32("kegLimit", limit);
    }
}

void onRender(CRules@ this) {
    if (!ImGui::Begin("Keg Stats")) {
        ImGui::End();
        return;
    }
    ImGui::Text("Settings: ");
    ImGui::Separator();


    int newLimit = ImGui::SliderInt("Keg Limit", this.get_s32("kegLimit"), 0, 5000);

    // Sync
    if (newLimit != this.get_s32("kegLimit")) {
        this.set_s32("kegLimit", newLimit);

        CBitStream bit;
        bit.write_s32(newLimit);

        getRules().SendCommand(getRules().getCommandID("syncLimit"), bit);
    }

    ImGui::Separator();
    ImGui::Text("Stats:");
    ImGui::Separator();

    ImGui::Text("Keg Count: " + kegCount);


    ImGui::End();
}