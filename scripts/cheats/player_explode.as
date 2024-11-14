// THIS FUNC WILL FAIL ON 2.3
// THIS IS ON PURPOSE

void onTick(CBlob@ this) {
    if (!this.hasTag("cheats")) {
        return;
    }

    if (this.isKeyPressed(key_action2) && isClient()) {
        Vec2f pos = getDriver().getWorldPosFromScreenPos(getControls().getMouseScreenPos());
        float radius = getRules().get_f32("explosion_radius");
        float falloff = getRules().get_f32("explosion_falloff");
        float strength = getRules().get_f32("explosion_strength");
        getMap().Explode(pos, radius, falloff, strength);
    }
}