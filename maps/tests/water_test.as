#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(10, 120);

void onInit(CMap@ this) {
    RespawnAll(SpawnPos);
}