/* User-defined event script to reset a secret item after a delay of
 * 20 seconds.
 * This is edited to make the reset time to 10 minutes
 * (who in the hells thought 20 secs was good?)
 */

#include "x0_i0_secret"

void main()
{
    if (GetUserDefinedEventNumber() == EVENT_SECRET_REVEALED)
    {
        DelayCommand(600.0, ResetSecretItem());
    }
}
