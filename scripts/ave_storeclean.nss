#include "ave_crafting"
#include "nwnx_funcs"
#include "inc_loot"

const float STORE_CLEAN_PERIOD = 7200.0; // every four hours
const float REAGENT_SPAWN_PERIOD = 7200.0; // every four hours
const float GEAR_SPAWN_PERIOD = 7200.0; // every four hours

void RepriceReagent(object oMyReagent);
void DoStoreClean(object oStore);
void SpawnReagent(object oStore);
void SpawnGear(object oStore);

void RepriceReagent(object oMyReagent) {
   int nCost;

   nCost = GetLocalInt(oMyReagent, "IPVarTier");
   nCost = FloatToInt(pow(8.0, IntToFloat(nCost)) / 4.0);
   nCost = Random(nCost) + Random(nCost) + 1;
   SetGoldPieceValue(oMyReagent, nCost);
}

void DoStoreClean(object oStore) {
    object oItem;
    int iDestroy;

    oItem = GetFirstItemInInventory(oStore);
    while(GetIsObjectValid(oItem)) {
        //Clean out ~10%% of inventory
        iDestroy = Random(10);
        if(iDestroy == 0 && GetInfiniteFlag(oItem) == 0) DestroyObject(oItem);
        oItem = GetNextItemInInventory(oStore);
    }

    DelayCommand(STORE_CLEAN_PERIOD, DoStoreClean(oStore));
}

// Invictus - 2013-04-20
void SpawnReagent(object oStore) {
    int nTier;
    int nChancesToIncreaseTier;
    object oReagent;

    nChancesToIncreaseTier = Random(7);
    nTier = 1;

    while(nChancesToIncreaseTier > 1) {
        if(Random(3) != 1) nTier++; // 66% chance to increase tier
        nChancesToIncreaseTier--;
    }

    oReagent = CreateReagent(nTier, oStore);
    DelayCommand(0.1, RepriceReagent(oReagent));
    DelayCommand(REAGENT_SPAWN_PERIOD, SpawnReagent(oStore));
}

void SpawnGear(object oStore) {
    int nTier;
    int nItemType;
    int nTotalItemTypes;
    int bGearSpawnEnabled;
    int nGearMaxTier;
    int bSpawnMeleeEnabled;
    int bSpawnRangedEnabled;
    int bSpawnArmorEnabled;
    int bSpawnRingEnabled;
    int bSpawnBracerEnabled;
    int bSpawnBeltEnabled;
    int bSpawnCloakEnabled;
    int bSpawnHelmEnabled;
    int bSpawnAmmoEnabled;
    int bSpawnShieldEnabled;
    int bSpawnGloveEnabled;
    int bSpawnTrapEnabled;
    int bSpawnPoisonEnabled;

    int nSelectOnce = FALSE;

    bGearSpawnEnabled = GetLocalInt(oStore, "store_spawn_gear");
    nGearMaxTier = GetLocalInt(oStore, "store_spawn_max_tier");
    bSpawnMeleeEnabled = GetLocalInt(oStore, "store_spawn_melee");
    bSpawnRangedEnabled = GetLocalInt(oStore, "store_spawn_ranged");
    bSpawnArmorEnabled = GetLocalInt(oStore, "store_spawn_armor");
    bSpawnRingEnabled = GetLocalInt(oStore, "store_spawn_ring");
    bSpawnBracerEnabled = GetLocalInt(oStore, "store_spawn_bracer");
    bSpawnBeltEnabled = GetLocalInt(oStore, "store_spawn_belt");
    bSpawnCloakEnabled = GetLocalInt(oStore, "store_spawn_cloak");
    bSpawnHelmEnabled = GetLocalInt(oStore, "store_spawn_helm");
    bSpawnAmmoEnabled = GetLocalInt(oStore, "store_spawn_ammo");
    bSpawnShieldEnabled = GetLocalInt(oStore, "store_spawn_shield");
    bSpawnGloveEnabled = GetLocalInt(oStore, "store_spawn_glove");
    bSpawnTrapEnabled = GetLocalInt(oStore, "store_spawn_trap");
    bSpawnPoisonEnabled = GetLocalInt(oStore, "store_spawn_poison");

    if(!bGearSpawnEnabled) return;

    nTotalItemTypes = bSpawnMeleeEnabled + bSpawnArmorEnabled +
                      bSpawnRingEnabled + bSpawnBracerEnabled +
                      bSpawnBeltEnabled + bSpawnCloakEnabled +
                      bSpawnHelmEnabled + bSpawnAmmoEnabled +
                      bSpawnShieldEnabled + bSpawnGloveEnabled +
                      bSpawnTrapEnabled + bSpawnPoisonEnabled +
                      bSpawnRangedEnabled;

    nItemType = Random(nTotalItemTypes);
    nTier = Random(nGearMaxTier) + 1;

    if(bSpawnMeleeEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateMelee(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnRangedEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateRanged(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnArmorEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateArmor(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnRingEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateRing(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnBracerEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateBracers(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnBeltEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateBelt(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnCloakEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateCloak(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnHelmEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateHelm(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnAmmoEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateHelm(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnShieldEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateShield(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnGloveEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateGloves(oStore, nTier, FALSE);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnTrapEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreateTrap(oStore, nTier);
            nSelectOnce = TRUE;
        }
    }

    if(bSpawnPoisonEnabled) {
        nItemType--;
        if(nItemType < 0 && !nSelectOnce) {
            LootCreatePoison(oStore, nTier);
            nSelectOnce = TRUE;
        }
    }

    DelayCommand(GEAR_SPAWN_PERIOD, SpawnGear(oStore));
}

void main() {
   object oStore = OBJECT_SELF;
   if (GetLocalInt(oStore, "ave_storeclean") == 0) {
        DoStoreClean(oStore);
        SpawnReagent(oStore);
        SpawnGear(oStore);
        SetLocalInt(oStore, "ave_storeclean", 1);
   }
}
