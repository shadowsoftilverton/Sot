/*
 *  NWNeXalt - Empty File
 *  (c) 2007 Doug Swarin (zac@intertex.net)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  $Id$
 *  $HeadURL$
 *
 */

#ifndef _NX_NWN_STRUCT_CNWSSTATS_LEVEL_
#define _NX_NWN_STRUCT_CNWSSTATS_LEVEL_

struct CNWSStats_Level_s {
    CExoArrayList_uint32        ls_spells_known[10];

    uint32_t                    unknown_1[30];

    CExoArrayList_uint16        ls_featlist;

    uint8_t                    *ls_skilllist;
    uint8_t                     ls_skillpoints;

    uint8_t                     unknown_2;

    uint8_t                     ls_ability;
    uint8_t                     ls_hp;
    
    uint8_t                     ls_class;
};

#endif /* _NX_NWN_STRUCT_CNWSSTATS_LEVEL_ */

/* vim: set sw=4: */
