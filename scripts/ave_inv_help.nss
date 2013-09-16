void main()
{
    object oPC=GetPCSpeaker();

    SendMessageToPC(oPC,"Currently, the only inventory management functions are the loot management options. "+
    "These include flagging all items in your inventory as not loot and dropping all loot items on the ground."+
    "The typical use of this system is to flag all items as not loot before you go "+
    "on a trip, then drop all the items you have obtained since then to show them to your party."+
    "Other inventory sorting functions are planned for the future.");

    /*SendMessageToPC(oPC,"/sortpolicy maxtier N"
    "Where N is an integer from 1-7, only sorts items below tier N. Example: /sortpolicy maxtier 6"
    "Default value 7"

    "/sortpolicy mintier N"
    "Where N is an integer from 1-7, only sorts items below tier N. Example: /sortpolicy mintier 5"
    "Default value 1"

    "/sortpolicy besttoworst"
    "A toggle that makes sorting categorize items with highest tier items being sorted first."
    "Default TRUE"

    "/sortpolicy ignorebagged"
    "A toggle that makes sorting bypass items inside bags and not attempt to resort them. Warning, turning this off may cause your inventory to overflow and you to drop items if you have an extremely large number of bags and have usesubbags off (ie you tell sorting to remove items from your bags)."
    "Default TRUE"

    "/sortpolicy usesubbags"
    "A toggle that makes sorting attempt to place items in bags that are inside the target's inventory. If the bags have their own sortpolicies, those will trump the sortpolicies of the player."
    "Default TRUE"

    "/sortpolicy bagsonly"
    "A toggle that makes sorting ONLY attempt to place items in bags, and not perturb items that can't be bagged."
    "Default FALSE"

    "/sortpolicy itemtype T"
    "Makes sorting consider a specific type of item. Valid values for T are:"
    "all (default)"
    "reagent"
    "melee"
    "ranged"
    "thrown"
    "staves"
    "ammo"
    "armor"
    "shield"
    "helm"
    "glove"
    "bracer"
    "cloak"
    "belt"
    "boots"
    "amulet"
    "ring"
    "potion"
    "scroll"
    "healkit"
    "wand"
    "trapkit"

    "armor N"
    "Where N is a base AC value. Example: /sortpolicy itemptype armor 0"
    "shieldN"
    "Where N is a base AC value. Example: /sortpolicy itemtype shield 2"
    "reagent T"
    "Where T is an item type that is a valid target for crafting, sorts reagents that can be placed onto item type T. Example: /sortpolicy itemtype reagent helm"

    "/sortpolicy itemtype T&T"
    "Where T and T are both item types, as described above. Makes the sortpolicy select two (or more) different item types. Example: /sortpolicy itemtype boots&gloves&bracers"

    "/sortpolicy priority T N"
    "Where T is an itemtype as described above and N is any whole number. The system will attempt to put higher-priority items first according to the besttoworst policy."
    "Default: 0 for all items."

    "/sortpolicy prioritytrumpsquality"
    "A toggle that makes the system sort first by itemtype priority and then by item quality (besttoworst), or the other way around. By default, priority trumps quality and quality is only used as a tiebreaker for items of identical priority."
    "Default TRUE"

    "/sortpolicy lootonly"
    "A toggle that makes sorting ignore items that have been flagged as not loot by the utility wand."
    "Default FALSE"

    "Finally, you can combine commands with the + delimiter. For example: /sortpolicy lootonly+itemtype boots");
    */
}
