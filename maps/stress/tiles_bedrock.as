#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(0, 0);

void onInit(CMap@ this) {
    RespawnAll(SpawnPos);
}