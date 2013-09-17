//===================================================
// (c) Invictus 2011
// ---
// Developed for use with the Shadows of Tilverton
// roleplaying server. Other use is forbidden without
// the consent of the plugin author.
//===================================================

#include "NWNXCombat.h"

int32_t Hook_CalculateOffHandAttacks(CNWSCombatRound *round) {
	CNWSCreature *cre = round->org_nwcreature;
	CNWSItem *item = CNWSInventory__GetItemInSlot(cre->cre_equipment, EQUIPMENT_SLOT_RIGHTHAND);
	round->OffHandAttacks = 0;

	if(item) {
		CNWBaseItem *baseItem = (CNWBaseItem *) CNWBaseItemArray__GetBaseItem((*NWN_Rules)->ru_baseitems, item->it_baseitem);

		if(!baseItem->RangedWeapon) {
			if(((int8_t) (baseItem->WeaponSize - cre->cre_size)) > 0) {
				if(baseItem->WeaponWield == 8)
					round->OffHandAttacks = 1;
			} else {
				item = CNWSInventory__GetItemInSlot(cre->cre_equipment, EQUIPMENT_SLOT_LEFTHAND);

				if(item) {
					baseItem = (CNWBaseItem *) CNWBaseItemArray__GetBaseItem((*NWN_Rules)->ru_baseitems, item->it_baseitem);

					if(baseItem->WeaponType && baseItem->WeaponWield != 7)
						round->OffHandAttacks = 1;
				}
			}

			if(round->OffHandAttacks > 0) {
				if(CNWSCreatureStats__HasFeat(cre->cre_stats, 20))
					round->OffHandAttacks = 2;
				else if(CNWSCreatureStats__HasFeat(cre->cre_stats, 1132))
					round->OffHandAttacks = 3;
				else if(CNWSCreatureStats__HasFeat(cre->cre_stats, 1301))
					round->OffHandAttacks = round->OnHandAttacks;
			}
		}
	}

	return round->OffHandAttacks;
}
