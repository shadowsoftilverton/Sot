//===================================================
// (c) Invictus 2011
// ---
// Developed for use with the Shadows of Tilverton
// roleplaying server to enable additional two-weapon
// fighting feats and the Tempest class.
// ---
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
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
