void onInit(CBlob@ this) {
    this.Tag("invincible");
    this.server_SetHealth(1000.0f);
}

void onTick(CBlob@ this) {
    this.setKeyPressed(key_up, true);
    this.setKeyPressed(key_left, true);
}