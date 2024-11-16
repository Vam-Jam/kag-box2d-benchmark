#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(50, 50);

void onInit(CMap@ this) {
    RespawnAll(SpawnPos);
}

void onTick(CRules@ this) {
    CBlob@ arrow = server_CreateBlob("arrow", 0, Vec2f(XORRandom(400) * 1.0f, 10));
}
