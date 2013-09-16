const string DEST_TAG = "dest_tag";
const float PORT_DELAY = 1.0;

void main() {
    object oSelf = OBJECT_SELF;

    string sTag = GetLocalString(oSelf, DEST_TAG);

    object oPC = GetPCSpeaker();
    object oDest = GetObjectByTag(sTag);

    DelayCommand(PORT_DELAY, AssignCommand(oPC, JumpToObject(oDest)));
}
