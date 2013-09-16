void main()
{
int iWinningSpot = Random(54)+1;
int iBet = GetLocalInt(OBJECT_SELF,"iBet");
int iSpot = 1;

if (iWinningSpot <= 24)
    {
    ActionSpeakString("It stopped on the 1 spot. Sorry, you lose.");
    }

if (iWinningSpot >= 25 && iWinningSpot <= 39)
    {
    ActionSpeakString("It stopped on the 2 spot. Sorry, you lose.");
    }

if (iWinningSpot >= 40 && iWinningSpot <= 46)
    {
    ActionSpeakString("It stopped on the 5 spot. Sorry, you lose.");
    }

if (iWinningSpot >= 47 && iWinningSpot <= 50)
    {
    ActionSpeakString("It stopped on the 10 spot. Sorry, you lose.");
    }

if (iWinningSpot == 51 || iWinningSpot == 52)
    {
    ActionSpeakString("It stopped on the 20 spot. Sorry, you lose.");
    }

if (iWinningSpot == 53)
    {
    ActionSpeakString("It stopped on the Joker spot. Sorry, you lose.");
    }

if (iWinningSpot == 54)
    {
    ActionSpeakString("It stopped on the Casino Bertix spot. You Win!");
    GiveGoldToCreature(GetPCSpeaker(),iBet*41);
    }
}
