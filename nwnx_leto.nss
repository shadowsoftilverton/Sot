/*
  ds_s_letoscript

  All the utilities that handle LetoScript for this module are found here.
  These utilities make it easier to write LetoScript in other scripts.

  Written for LetoScript build 23. By dragonsong, Apr 23 2005.

*/

// Change a PC in some way, as specified in Script.
void ApplyLetoScriptToPC(string Script, object PC);

// Get the filename for this PC. ExportSingleCharacter should always be
// called beforehand.
string GetPCFile(object PC);

int OpenFileForLetoScript(string File, object PC);

void CloseFileForLetoScript(string File);

// Just run some LetoScript. Blocks during execution, and returns its
// result, if you want it.
string LetoScript(string Script);

void ApplyLetoScriptToPC(string Script, object PC)
{
    object M = GetModule();

    string VaultPath = GetLocalString(M, "DS_LETOSCRIPT_VAULTPATH");
    string Player = GetPCPlayerName(PC);
    string BicPath = VaultPath + Player + "/";

    int Portal = GetLocalInt(M, "DS_LETOSCRIPT_USES_PORTAL");
    string IP = GetLocalString(M, "DS_LETOSCRIPT_PORTAL_IP");
    string Password = GetLocalString(M, "DS_LETOSCRIPT_PORTAL_PASSWORD");

    Script =
        "$RealFile = q<" + BicPath + "> + FindNewestBic q<" + BicPath + ">;" +
        "$EditFile = $RealFile + '.utc';" +
        "FileRename $RealFile, $EditFile;" +
        "%bic = $EditFile or die;" +
        Script +
        "%bic = '>';" +
        "close %bic;" +
        "FileRename $EditFile, $RealFile;";

    SetLocalString(PC, "LetoScript", Script);

    if(Portal && IP != "")
    {
        ExportSingleCharacter(PC);
        /*
        string File = GetPCFile(PC);
        if( !OpenFileForLetoScript(File, PC) )
        {
            // Log an error here if desired.
            SendMessageToPC(PC, "The attempt to edit your character failed.");
            return;
        }
        LetoScript(Script);
        */
        DelayCommand(2.5f, ActivatePortal(PC, IP, Password, "", TRUE) );
        //CloseFileForLetoScript(File);
    }
    else
    {
        DelayCommand(2.5f, BootPC(PC) );
        //DelayCommand(1.0f, SetLocalString(M, "NWNX!LETO!SCRIPT", Script));
    }
}

string GetPCFile(object PC)
{
    object M = GetModule();
    string Vault = GetLocalString(M, "DS_LETOSCRIPT_VAULTPATH");
    string Player = GetPCPlayerName(PC);

    SetLocalString(
        M, "NWNX!LETO!SCRIPT",
        "print FindNewestBic q<" + Vault + Player + ">"
    );
    return Vault + Player + "/" + GetLocalString(M, "NWNX!LETO!SCRIPT");
}

int OpenFileForLetoScript(string File, object PC)
{
    string RealFile = File;
    string EditFile = File + ".utc";
    string Script =
      "FileRename q<" + RealFile + ">, q<" + EditFile + ">;" +
      "%bic = q<" + EditFile + "> or die $!;";

    string Result = LetoScript(Script);
    if(Result != "")
        SendMessageToPC(PC, Result);

    return Result == "";
}

void CloseFileForLetoScript(string File)
{
    string RealFile = File;
    string EditFile = File + ".utc";
    string Script =
        "%bic = '>';" +
        "close %bic;" +
        "FileRename q<" + EditFile + ">, q<" + RealFile + ">;";
}

void ReloadPC(object PC)
{
    object M = GetModule();
    int Portal = GetLocalInt(M, "DS_LETOSCRIPT_USES_PORTAL");
    string IP = GetLocalString(M, "DS_LETOSCRIPT_PORTAL_IP");
    string Password = GetLocalString(M, "DS_LETOSCRIPT_PORTAL_PASSWORD");

    if(Portal && IP != "")
    {
        ExportSingleCharacter(PC);
        ActivatePortal(PC, IP, Password, "", TRUE);
    }
    else
        BootPC(PC);
}

string LetoScript(string Script)
{
    object M = GetModule();
    SetLocalString(M, "NWNX!LETO!SCRIPT", Script);
    return GetLocalString(M, "NWNX!LETO!SCRIPT");
}

