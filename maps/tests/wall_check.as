#include "shared_map_funcs.as"

Vec2f SpawnPos = Vec2f(30, 360);

void onInit(CMap@ this) {
    RespawnAll(SpawnPos);

    SpawnSlidingBlob("builder", 1, Vec2f(100, 360));
    SpawnSlidingBlob("knight", 2, Vec2f(150, 360));
    SpawnSlidingBlob("archer", 3, Vec2f(200, 360));

    SpawnSlidingBlob("builder", 2, Vec2f(257, 360));
    SpawnJumpingBlob("builder", 3, Vec2f(330, 300));
}

void SpawnSlidingBlob(string &in name, int team, Vec2f &in pos) 
{
    CBlob@ blob = server_CreateBlob(name, team, pos);
    blob.AddScript("jump_slide.as");
}

void SpawnJumpingBlob(string &in name, int team, Vec2f &in pos) 
{
    CBlob@ blob = server_CreateBlob(name, team, pos);
    blob.AddScript("jump_jump_jump.as");
}