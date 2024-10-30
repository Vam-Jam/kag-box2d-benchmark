void onPlayerRequestSpawn(CRules@ this, CPlayer@ player)
{
	Respawn(this, player, SpawnPos);
}

void RespawnAll(Vec2f pos) {
    for (int i = 0; i < getPlayerCount(); i++) {
        Respawn(getRules(), getPlayer(i), pos);
    }
}


CBlob@ Respawn(CRules@ this, CPlayer@ player, Vec2f pos)
{
	if (player !is null)
	{
		// remove previous players blob
		CBlob @blob = player.getBlob();

		if (blob !is null)
		{
			CBlob @blob = player.getBlob();
			blob.server_SetPlayer(null);
			blob.server_Die();
		}

		CBlob @newBlob = server_CreateBlob("builder", 0, pos);
		newBlob.server_SetPlayer(player);

		newBlob.AddScript("player_flight.as");
		if (getMap().get_u8("BOX2D_SUBSTEP") > 0) {
			newBlob.AddScript("player_explode.as");
		}
		return newBlob;
	}

	return null;
}
