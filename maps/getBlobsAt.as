#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(0, 0);

void onInit(CMap@ this) {
    RespawnAll(SpawnPos);

    for (int a = 0; a < 100; a++) {
        server_CreateBlob("mat_gold", 0, Vec2f(200, 200));
    }
}


void onTick(CRules@ this) {

}