void main()
{
    object oDead=OBJECT_SELF;
    location lLoc=GetLocation(oDead);
    object oPort=CreateObject(OBJECT_TYPE_PLACEABLE,"ave_d2_port04",lLoc);
    DestroyObject(oPort,1800.0);
    effect eVis=EffectVisualEffect(1932);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,lLoc);
}
