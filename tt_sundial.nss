/*****************************
Script: Sundial Script v1.5
Created By: Jaden Wagener
Created On: 09/01/02
*****************************/
//Acts like a working sundial, giving the approximate time.
//This script assumes that it is too dark from 9pm-6am
//Should be put into the OnUsed slot of the sundial
//V1.5 CHANGE: Did not realize that minutes were only
//measured 0 and 1. Made change for that.
void main()
{
  //Declare variables
  int xHour, xMinute;
  string xTime;
  //Populate variables
  xHour = GetTimeHour();
  xMinute = GetTimeMinute();
  xTime = "It appears to be ";
  //Check if it's night time. If it's night, say so.
  if ((GetIsNight()) || (xHour > 20))
    xTime = xTime + "too dark to read";
  else
  {
    //Check for minute approximation
    if (xMinute == 0)
      xTime = xTime + "about ";
    if (xMinute == 1)
      xTime = xTime + "about half past ";
    //Check the hour
    switch(xHour)
    {
      case 6: xTime = xTime + "six in the morning"; break;
      case 7: xTime = xTime + "seven in the morning"; break;
      case 8: xTime = xTime + "eight in the morning"; break;
      case 9: xTime = xTime + "nine in the morning"; break;
      case 10: xTime = xTime + "ten in the morning"; break;
      case 11: xTime = xTime + "eleven in the morning"; break;
      case 12: xTime = xTime + "noontime"; break;
      case 13: xTime = xTime + "one in the afternoon"; break;
      case 14: xTime = xTime + "two in the afternoon"; break;
      case 15: xTime = xTime + "three in the afternoon"; break;
      case 16: xTime = xTime + "four in the afternoon"; break;
      case 17: xTime = xTime + "five in the afternoon"; break;
      case 18: xTime = xTime + "six in the afternoon"; break;
      case 19: xTime = xTime + "seven in the evening"; break;
      case 20: xTime = xTime + "eight in the evening"; break;
    }
  }
  //Now let's say the time
  SpeakString(xTime);
}
