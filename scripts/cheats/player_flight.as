void onTick(CBlob@ this) {
    if (this.isKeyJustPressed(key_pickup)) {
        if (this.hasTag("cheats")) {
            this.Untag("cheats");
            this.getShape().SetGravityScale(1.0f);
        } else {
            this.Tag("cheats");
        }
    }

    if (!this.hasTag("cheats")) {
        return;
    }
    
    this.Tag("invincible");
    this.server_SetHealth(1000.0f);
    this.setVelocity(Vec2f_zero);
    this.getShape().SetGravityScale(0.0f);

    if (isClient() && this.isKeyPressed(key_action1)) {
        this.setPosition(getDriver().getWorldPosFromScreenPos(getControls().getMouseScreenPos()));
    }
}