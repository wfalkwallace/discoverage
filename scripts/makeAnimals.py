import requests
import json

animals = [
  {
    'sprite': '100_voltorb',
    'name': 'Voltorb',
    'sprites': ['100_voltorb'],
    'names': ['Voltorb'],
    'health': 9,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0307700, 37.3321125]
  },
  {
    'sprite': '101_electrode',
    'name': 'Electrode',
    'sprites': ['101_electrode'],
    'names': ['Electrode'],
    'health': 5,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0307700, 37.3321125]
  },
  {
    'sprite': '102_exeggcute',
    'name': 'Exeggcute',
    'sprites': ['102_exeggcute'],
    'names': ['Exeggcute'],
    'health': 2,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0277700, 37.3321125]
  },
  {
    'sprite': '103_exeggutor',
    'name': 'Exeggutor',
    'sprites': ['103_exeggutor'],
    'names': ['Exeggutor'],
    'health': 8,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0337700, 37.3321125]
  },
  {
    'sprite': '104_cubone',
    'name': 'Cubone',
    'sprites': ['104_cubone'],
    'names': ['Cubone'],
    'health': 5,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0247700, 37.3321125]
  },
  {
    'sprite': '105_marowak',
    'name': 'Marowak',
    'sprites': ['105_marowak'],
    'names': ['Marowak'],
    'health': 3,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0367700, 37.3321125]
  },
  {
    'sprite': '106_hitmonlee',
    'name': 'Hitmonlee',
    'sprites': ['106_hitmonlee'],
    'names': ['Hitmonlee'],
    'health': 6,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0217700, 37.3321125]
  },
  {
    'sprite': '107_hitmonchan',
    'name': 'Hitmonchan',
    'sprites': ['107_hitmonchan'],
    'names': ['Hitmonchan'],
    'health': 1,
    'location': [-122.0397700, 37.3321125]
  },
  {
    'sprite': '108_lickitung',
    'name': 'Lickitung',
    'sprites': ['108_lickitung'],
    'names': ['Lickitung'],
    'health': 1,
    'location': [-122.0187700, 37.3321125]
  },
  {
    'sprite': '109_koffing',
    'name': 'Koffing',
    'sprites': ['109_koffing'],
    'names': ['Koffing'],
    'health': 1,
    'location': [-122.0427700, 37.3321125]
  },
  {
    'sprite': '10_caterpie',
    'name': 'Aterpie',
    'sprites': ['10_caterpie'],
    'names': ['Aterpie'],
    'health': 1,
    'location': [-122.0157700, 37.3321125]
  },
  {
    'sprite': '110_weezing',
    'name': 'Weezing',
    'sprites': ['110_weezing'],
    'names': ['Weezing'],
    'health': 1,
    'location': [-122.0457700, 37.3321125]
  },
  {
    'sprite': '111_rhyhorn',
    'name': 'Rhyhorn',
    'sprites': ['111_rhyhorn'],
    'names': ['Rhyhorn'],
    'health': 1,
    'location': [-122.0127700, 37.3321125]
  },
  {
    'sprite': '112_rhydon',
    'name': 'Rhydon',
    'sprites': ['112_rhydon'],
    'names': ['Rhydon'],
    'health': 1,
    'location': [-122.0487700, 37.3321125]
  },
  {
    'sprite': '113_chansey',
    'name': 'Chansey',
    'sprites': ['113_chansey'],
    'names': ['Chansey'],
    'health': 1,
    'location': [-122.0097700, 37.3321125]
  },
  {
    'sprite': '114_tangela',
    'name': 'Tangela',
    'sprites': ['114_tangela'],
    'names': ['Tangela'],
    'health': 1,
    'location': [-122.0517700, 37.3321125]
  },
  {
    'sprite': '115_kangaskhan',
    'name': 'Kangaskhan',
    'sprites': ['115_kangaskhan'],
    'names': ['Kangaskhan'],
    'health': 1,
    'location': [-122.0067700, 37.3321125]
  },
  {
    'sprite': '116_horsea',
    'name': 'Horsea',
    'sprites': ['116_horsea'],
    'names': ['Horsea'],
    'health': 1,
    'location': [-122.0547700, 37.3321125]
  },
  {
    'sprite': '117_seadra',
    'name': 'Seadra',
    'sprites': ['117_seadra'],
    'names': ['Seadra'],
    'health': 1,
    'location': [-122.0037700, 37.3321125]
  },
  {
    'sprite': '118_goldeen',
    'name': 'Goldeen',
    'sprites': ['118_goldeen'],
    'names': ['Goldeen'],
    'health': 1,
    'location': [-122.0577700, 37.3321125]
  },
  {
    'sprite': '119_seaking',
    'name': 'Seaking',
    'sprites': ['119_seaking'],
    'names': ['Seaking'],
    'health': 1,
    'location': [-122.0307700, 37.3341125]
  },
  {
    'sprite': '11_metapod',
    'name': 'Etapod',
    'sprites': ['11_metapod'],
    'names': ['Etapod'],
    'health': 1,
    'location': [-122.0307700, 37.3301125]
  },
  {
    'sprite': '120_staryu',
    'name': 'Staryu',
    'sprites': ['120_staryu'],
    'names': ['Staryu'],
    'health': 1,
    'location': [-122.0277700, 37.3341125]
  },
  {
    'sprite': '121_starmie',
    'name': 'Starmie',
    'sprites': ['121_starmie'],
    'names': ['Starmie'],
    'health': 1,
    'location': [-122.0337700, 37.3301125]
  },
  {
    'sprite': '122_mr_mime',
    'name': 'Mr_mime',
    'sprites': ['122_mr_mime'],
    'names': ['Mr_mime'],
    'health': 1,
    'location': [-122.0247700, 37.3341125]
  },
  {
    'sprite': '123_scyther',
    'name': 'Scyther',
    'sprites': ['123_scyther'],
    'names': ['Scyther'],
    'health': 1,
    'location': [-122.0367700, 37.3301125]
  },
  {
    'sprite': '124_jynx',
    'name': 'Jynx',
    'sprites': ['124_jynx'],
    'names': ['Jynx'],
    'health': 1,
    'location': [-122.0217700, 37.3341125]
  },
  {
    'sprite': '125_electabuzz',
    'name': 'Electabuzz',
    'sprites': ['125_electabuzz'],
    'names': ['Electabuzz'],
    'health': 1,
    'location': [-122.0397700, 37.3301125]
  },
  {
    'sprite': '126_magmar',
    'name': 'Magmar',
    'sprites': ['126_magmar'],
    'names': ['Magmar'],
    'health': 1,
    'location': [-122.0187700, 37.3341125]
  },
  {
    'sprite': '127_pinsir',
    'name': 'Pinsir',
    'sprites': ['127_pinsir'],
    'names': ['Pinsir'],
    'health': 1,
    'location': [-122.0427700, 37.3301125]
  },
  {
    'sprite': '128_taurus',
    'name': 'Taurus',
    'sprites': ['128_taurus'],
    'names': ['Taurus'],
    'health': 1,
    'location': [-122.0157700, 37.3341125]
  },
  {
    'sprite': '129_magikarp',
    'name': 'Magikarp',
    'sprites': ['129_magikarp'],
    'names': ['Magikarp'],
    'health': 1,
    'location': [-122.0457700, 37.3301125]
  },
  {
    'sprite': '12_butterfree',
    'name': 'Utterfree',
    'sprites': ['12_butterfree'],
    'names': ['Utterfree'],
    'health': 1,
    'location': [-122.0127700, 37.3341125]
  },
  {
    'sprite': '130_gyarados',
    'name': 'Gyarados',
    'sprites': ['130_gyarados'],
    'names': ['Gyarados'],
    'health': 1,
    'location': [-122.0487700, 37.3301125]
  },
  {
    'sprite': '131_lapras',
    'name': 'Lapras',
    'sprites': ['131_lapras'],
    'names': ['Lapras'],
    'health': 1,
    'location': [-122.0097700, 37.3341125]
  },
  {
    'sprite': '132_ditto',
    'name': 'Ditto',
    'sprites': ['132_ditto'],
    'names': ['Ditto'],
    'health': 1,
    'location': [-122.0517700, 37.3301125]
  },
  {
    'sprite': '133_eevee',
    'name': 'Eevee',
    'sprites': ['133_eevee'],
    'names': ['Eevee'],
    'health': 1,
    'location': [-122.0067700, 37.3341125]
  },
  {
    'sprite': '134_vaporeon',
    'name': 'Vaporeon',
    'sprites': ['134_vaporeon'],
    'names': ['Vaporeon'],
    'health': 1,
    'location': [-122.0547700, 37.3301125]
  },
  {
    'sprite': '135_jolteon',
    'name': 'Jolteon',
    'sprites': ['135_jolteon'],
    'names': ['Jolteon'],
    'health': 1,
    'location': [-122.0037700, 37.3341125]
  },
  {
    'sprite': '136_flareon',
    'name': 'Flareon',
    'sprites': ['136_flareon'],
    'names': ['Flareon'],
    'health': 1,
    'location': [-122.0577700, 37.3301125]
  },
  {
    'sprite': '137_porygon',
    'name': 'Porygon',
    'sprites': ['137_porygon'],
    'names': ['Porygon'],
    'health': 1,
    'location': [-122.0307700, 37.3361125]
  },
  {
    'sprite': '138_omanyte',
    'name': 'Omanyte',
    'sprites': ['138_omanyte'],
    'names': ['Omanyte'],
    'health': 1,
    'location': [-122.0307700, 37.3281125]
  },
  {
    'sprite': '139_omastar',
    'name': 'Omastar',
    'sprites': ['139_omastar'],
    'names': ['Omastar'],
    'health': 1,
    'location': [-122.0277700, 37.3361125]
  },
  {
    'sprite': '13_weedle',
    'name': 'Eedle',
    'sprites': ['13_weedle'],
    'names': ['Eedle'],
    'health': 1,
    'location': [-122.0337700, 37.3281125]
  },
  {
    'sprite': '140_kabuto',
    'name': 'Kabuto',
    'sprites': ['140_kabuto'],
    'names': ['Kabuto'],
    'health': 1,
    'location': [-122.0247700, 37.3361125]
  },
  {
    'sprite': '141_kabutops',
    'name': 'Kabutops',
    'sprites': ['141_kabutops'],
    'names': ['Kabutops'],
    'health': 1,
    'location': [-122.0367700, 37.3281125]
  },
  {
    'sprite': '142_aerodactyl',
    'name': 'Aerodactyl',
    'sprites': ['142_aerodactyl'],
    'names': ['Aerodactyl'],
    'health': 1,
    'location': [-122.0217700, 37.3361125]
  },
  {
    'sprite': '143_snorlax',
    'name': 'Snorlax',
    'sprites': ['143_snorlax'],
    'names': ['Snorlax'],
    'health': 1,
    'location': [-122.0397700, 37.3281125]
  },
  {
    'sprite': '144_articuno',
    'name': 'Articuno',
    'sprites': ['144_articuno'],
    'names': ['Articuno'],
    'health': 1,
    'location': [-122.0187700, 37.3361125]
  },
  {
    'sprite': '145_zapdos',
    'name': 'Zapdos',
    'sprites': ['145_zapdos'],
    'names': ['Zapdos'],
    'health': 1,
    'location': [-122.0427700, 37.3281125]
  }
]

for animal in animals:
  headers = {'Content-type': 'application/json'}
  r = requests.post("http://discoverage.herokuapp.com/animal", data=json.dumps(animal), headers=headers)
  print(r.text)
