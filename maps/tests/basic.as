#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(50, 750);

void onInit(CMap@ this) {
    RespawnAll(SpawnPos);
}
