#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(30, 360);

void onInit(CMap@ this) {
    RespawnAll(SpawnPos);

    SpawnJumpingBlob("builder", 1, Vec2f(130, 360));
    SpawnJumpingBlob("knight", 2, Vec2f(170, 360));
    SpawnJumpingBlob("archer", 3, Vec2f(230, 360));

    SpawnJumpingBlob("builder", 2, Vec2f(350, 360));
    SpawnJumpingBlob("builder", 3, Vec2f(350, 300));
}

void SpawnJumpingBlob(string &in name, int team, Vec2f &in pos) 
{
    CBlob@ blob = server_CreateBlob(name, team, pos);
    blob.AddScript("jump_jump_jump.as");
}