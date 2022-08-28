// Copyright (c) 2011-2020 The Bitcoin Core developers
// Copyright (c) 2021 The xbi developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef xbi_MAPPORT_H
#define xbi_MAPPORT_H

#ifdef USE_UMNP
static constexpr bool DEFAULT_UMNP = USE_UMNP;
#else
static constexpr bool DEFAULT_UMNP = false;
#endif // USE_UMNP

#ifdef USE_NATPMP
static constexpr bool DEFAULT_NATPMP = USE_NATPMP;
#else
static constexpr bool DEFAULT_NATPMP = false;
#endif // USE_NATPMP

enum MapPortProtoFlag : unsigned int {
    NONE = 0x00,
    UMNP = 0x01,
    NAT_PMP = 0x02,
};

void StartMapPort(bool use_upnp, bool use_natpmp);
void InterruptMapPort();
void StopMapPort();

#endif //xbi_MAPPORT_H
