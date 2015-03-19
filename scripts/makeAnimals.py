#!/bin/python

import requests
import json

animals = [
  {
    'sprite': '100_voltorb',
    'name': 'Voltorb',
    'health': 1,
    'location': [-122.0307625, 37.3321116]
  },
  {
    'sprite': '101_electrode',
    'name': 'Electrode',
    'health': 1,
    'location': [-122.0307625, 37.3321116]
  },
  {
    'sprite': '102_exeggcute',
    'name': 'Exeggcute',
    'health': 1,
    'location': [-122.0306625, 37.3321116]
  },
  {
    'sprite': '103_exeggutor',
    'name': 'Exeggutor',
    'health': 1,
    'location': [-122.0308625, 37.3321116]
  },
  {
    'sprite': '104_cubone',
    'name': 'Cubone',
    'health': 1,
    'location': [-122.0305625, 37.3321116]
  },
  {
    'sprite': '105_marowak',
    'name': 'Marowak',
    'health': 1,
    'location': [-122.0309625, 37.3321116]
  },
  {
    'sprite': '106_hitmonlee',
    'name': 'Hitmonlee',
    'health': 1,
    'location': [-122.0304625, 37.3321116]
  },
  {
    'sprite': '107_hitmonchan',
    'name': 'Hitmonchan',
    'health': 1,
    'location': [-122.0310625, 37.3321116]
  },
  {
    'sprite': '108_lickitung',
    'name': 'Lickitung',
    'health': 1,
    'location': [-122.0303625, 37.3321116]
  },
  {
    'sprite': '109_koffing',
    'name': 'Koffing',
    'health': 1,
    'location': [-122.0311625, 37.3321116]
  },
  {
    'sprite': '10_caterpie',
    'name': 'Aterpie',
    'health': 1,
    'location': [-122.0307625, 37.3322116]
  },
  {
    'sprite': '110_weezing',
    'name': 'Weezing',
    'health': 1,
    'location': [-122.0307625, 37.3320116]
  },
  {
    'sprite': '111_rhyhorn',
    'name': 'Rhyhorn',
    'health': 1,
    'location': [-122.0306625, 37.3322116]
  },
  {
    'sprite': '112_rhydon',
    'name': 'Rhydon',
    'health': 1,
    'location': [-122.0308625, 37.3320116]
  },
  {
    'sprite': '113_chansey',
    'name': 'Chansey',
    'health': 1,
    'location': [-122.0305625, 37.3322116]
  },
  {
    'sprite': '114_tangela',
    'name': 'Tangela',
    'health': 1,
    'location': [-122.0309625, 37.3320116]
  },
  {
    'sprite': '115_kangaskhan',
    'name': 'Kangaskhan',
    'health': 1,
    'location': [-122.0304625, 37.3322116]
  },
  {
    'sprite': '116_horsea',
    'name': 'Horsea',
    'health': 1,
    'location': [-122.0310625, 37.3320116]
  },
  {
    'sprite': '117_seadra',
    'name': 'Seadra',
    'health': 1,
    'location': [-122.0303625, 37.3322116]
  },
  {
    'sprite': '118_goldeen',
    'name': 'Goldeen',
    'health': 1,
    'location': [-122.0311625, 37.3320116]
  },
  {
    'sprite': '119_seaking',
    'name': 'Seaking',
    'health': 1,
    'location': [-122.0307625, 37.3323116]
  },
  {
    'sprite': '11_metapod',
    'name': 'Etapod',
    'health': 1,
    'location': [-122.0307625, 37.3319116]
  },
  {
    'sprite': '120_staryu',
    'name': 'Staryu',
    'health': 1,
    'location': [-122.0306625, 37.3323116]
  },
  {
    'sprite': '121_starmie',
    'name': 'Starmie',
    'health': 1,
    'location': [-122.0308625, 37.3319116]
  },
  {
    'sprite': '122_mr_mime',
    'name': 'Mr_mime',
    'health': 1,
    'location': [-122.0305625, 37.3323116]
  },
  {
    'sprite': '123_scyther',
    'name': 'Scyther',
    'health': 1,
    'location': [-122.0309625, 37.3319116]
  },
  {
    'sprite': '124_jynx',
    'name': 'Jynx',
    'health': 1,
    'location': [-122.0304625, 37.3323116]
  },
  {
    'sprite': '125_electabuzz',
    'name': 'Electabuzz',
    'health': 1,
    'location': [-122.0310625, 37.3319116]
  },
  {
    'sprite': '126_magmar',
    'name': 'Magmar',
    'health': 1,
    'location': [-122.0303625, 37.3323116]
  },
  {
    'sprite': '127_pinsir',
    'name': 'Pinsir',
    'health': 1,
    'location': [-122.0311625, 37.3319116]
  },
  {
    'sprite': '128_taurus',
    'name': 'Taurus',
    'health': 1,
    'location': [-122.0307625, 37.3324116]
  },
  {
    'sprite': '129_magikarp',
    'name': 'Magikarp',
    'health': 1,
    'location': [-122.0307625, 37.3318116]
  },
  {
    'sprite': '12_butterfree',
    'name': 'Utterfree',
    'health': 1,
    'location': [-122.0306625, 37.3324116]
  },
  {
    'sprite': '130_gyarados',
    'name': 'Gyarados',
    'health': 1,
    'location': [-122.0308625, 37.3318116]
  },
  {
    'sprite': '131_lapras',
    'name': 'Lapras',
    'health': 1,
    'location': [-122.0305625, 37.3324116]
  },
  {
    'sprite': '132_ditto',
    'name': 'Ditto',
    'health': 1,
    'location': [-122.0309625, 37.3318116]
  },
  {
    'sprite': '133_eevee',
    'name': 'Eevee',
    'health': 1,
    'location': [-122.0304625, 37.3324116]
  },
  {
    'sprite': '134_vaporeon',
    'name': 'Vaporeon',
    'health': 1,
    'location': [-122.0310625, 37.3318116]
  },
  {
    'sprite': '135_jolteon',
    'name': 'Jolteon',
    'health': 1,
    'location': [-122.0303625, 37.3324116]
  },
  {
    'sprite': '136_flareon',
    'name': 'Flareon',
    'health': 1,
    'location': [-122.0311625, 37.3318116]
  },
  {
    'sprite': '137_porygon',
    'name': 'Porygon',
    'health': 1,
    'location': [-122.0307625, 37.3325116]
  },
  {
    'sprite': '138_omanyte',
    'name': 'Omanyte',
    'health': 1,
    'location': [-122.0307625, 37.3317116]
  },
  {
    'sprite': '139_omastar',
    'name': 'Omastar',
    'health': 1,
    'location': [-122.0306625, 37.3325116]
  },
  {
    'sprite': '13_weedle',
    'name': 'Eedle',
    'health': 1,
    'location': [-122.0308625, 37.3317116]
  },
  {
    'sprite': '140_kabuto',
    'name': 'Kabuto',
    'health': 1,
    'location': [-122.0305625, 37.3325116]
  },
  {
    'sprite': '141_kabutops',
    'name': 'Kabutops',
    'health': 1,
    'location': [-122.0309625, 37.3317116]
  },
  {
    'sprite': '142_aerodactyl',
    'name': 'Aerodactyl',
    'health': 1,
    'location': [-122.0304625, 37.3325116]
  },
  {
    'sprite': '143_snorlax',
    'name': 'Snorlax',
    'health': 1,
    'location': [-122.0310625, 37.3317116]
  },
  {
    'sprite': '144_articuno',
    'name': 'Articuno',
    'health': 1,
    'location': [-122.0303625, 37.3325116]
  },
  {
    'sprite': '145_zapdos',
    'name': 'Zapdos',
    'health': 1,
    'location': [-122.0311625, 37.3317116]
  }
]

for animal in animals:
  headers = {'Content-type': 'application/json'}
  print(json.dumps(payload))
  r = requests.post("http://discoverage.herokuapp.com/animal", data=json.dumps(animal), headers=headers)
  print(r.text)
