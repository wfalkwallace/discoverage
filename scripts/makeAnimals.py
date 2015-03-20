import requests
import json

animals = [
  {
    'sprite': '100_voltorb',
    'name': 'Voltorb',
    'health': 9,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0307700, 37.3321125]
  },
  {
    'sprite': '101_electrode',
    'name': 'Electrode',
    'health': 5,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0307700, 37.3321125]
  },
  {
    'sprite': '102_exeggcute',
    'name': 'Exeggcute',
    'health': 2,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0277700, 37.3321125]
  },
  {
    'sprite': '103_exeggutor',
    'name': 'Exeggutor',
    'health': 8,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0337700, 37.3321125]
  },
  {
    'sprite': '104_cubone',
    'name': 'Cubone',
    'health': 5,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0247700, 37.3321125]
  },
  {
    'sprite': '105_marowak',
    'name': 'Marowak',
    'health': 3,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0367700, 37.3321125]
  },
  {
    'sprite': '106_hitmonlee',
    'name': 'Hitmonlee',
    'health': 6,
    'owner': '550648a8fa6b8286095dd5ce',
    'location': [-122.0217700, 37.3321125]
  },
  {
    'sprite': '107_hitmonchan',
    'name': 'Hitmonchan',
    'health': 1,
    'location': [-122.0397700, 37.3321125]
  },
  {
    'sprite': '108_lickitung',
    'name': 'Lickitung',
    'health': 1,
    'location': [-122.0187700, 37.3321125]
  },
  {
    'sprite': '109_koffing',
    'name': 'Koffing',
    'health': 1,
    'location': [-122.0427700, 37.3321125]
  },
  {
    'sprite': '10_caterpie',
    'name': 'Aterpie',
    'health': 1,
    'location': [-122.0157700, 37.3321125]
  },
  {
    'sprite': '110_weezing',
    'name': 'Weezing',
    'health': 1,
    'location': [-122.0457700, 37.3321125]
  },
  {
    'sprite': '111_rhyhorn',
    'name': 'Rhyhorn',
    'health': 1,
    'location': [-122.0127700, 37.3321125]
  },
  {
    'sprite': '112_rhydon',
    'name': 'Rhydon',
    'health': 1,
    'location': [-122.0487700, 37.3321125]
  },
  {
    'sprite': '113_chansey',
    'name': 'Chansey',
    'health': 1,
    'location': [-122.0097700, 37.3321125]
  },
  {
    'sprite': '114_tangela',
    'name': 'Tangela',
    'health': 1,
    'location': [-122.0517700, 37.3321125]
  },
  {
    'sprite': '115_kangaskhan',
    'name': 'Kangaskhan',
    'health': 1,
    'location': [-122.0067700, 37.3321125]
  },
  {
    'sprite': '116_horsea',
    'name': 'Horsea',
    'health': 1,
    'location': [-122.0547700, 37.3321125]
  },
  {
    'sprite': '117_seadra',
    'name': 'Seadra',
    'health': 1,
    'location': [-122.0037700, 37.3321125]
  },
  {
    'sprite': '118_goldeen',
    'name': 'Goldeen',
    'health': 1,
    'location': [-122.0577700, 37.3321125]
  },
  {
    'sprite': '119_seaking',
    'name': 'Seaking',
    'health': 1,
    'location': [-122.0307700, 37.3341125]
  },
  {
    'sprite': '11_metapod',
    'name': 'Etapod',
    'health': 1,
    'location': [-122.0307700, 37.3301125]
  },
  {
    'sprite': '120_staryu',
    'name': 'Staryu',
    'health': 1,
    'location': [-122.0277700, 37.3341125]
  },
  {
    'sprite': '121_starmie',
    'name': 'Starmie',
    'health': 1,
    'location': [-122.0337700, 37.3301125]
  },
  {
    'sprite': '122_mr_mime',
    'name': 'Mr_mime',
    'health': 1,
    'location': [-122.0247700, 37.3341125]
  },
  {
    'sprite': '123_scyther',
    'name': 'Scyther',
    'health': 1,
    'location': [-122.0367700, 37.3301125]
  },
  {
    'sprite': '124_jynx',
    'name': 'Jynx',
    'health': 1,
    'location': [-122.0217700, 37.3341125]
  },
  {
    'sprite': '125_electabuzz',
    'name': 'Electabuzz',
    'health': 1,
    'location': [-122.0397700, 37.3301125]
  },
  {
    'sprite': '126_magmar',
    'name': 'Magmar',
    'health': 1,
    'location': [-122.0187700, 37.3341125]
  },
  {
    'sprite': '127_pinsir',
    'name': 'Pinsir',
    'health': 1,
    'location': [-122.0427700, 37.3301125]
  },
  {
    'sprite': '128_taurus',
    'name': 'Taurus',
    'health': 1,
    'location': [-122.0157700, 37.3341125]
  },
  {
    'sprite': '129_magikarp',
    'name': 'Magikarp',
    'health': 1,
    'location': [-122.0457700, 37.3301125]
  },
  {
    'sprite': '12_butterfree',
    'name': 'Utterfree',
    'health': 1,
    'location': [-122.0127700, 37.3341125]
  },
  {
    'sprite': '130_gyarados',
    'name': 'Gyarados',
    'health': 1,
    'location': [-122.0487700, 37.3301125]
  },
  {
    'sprite': '131_lapras',
    'name': 'Lapras',
    'health': 1,
    'location': [-122.0097700, 37.3341125]
  },
  {
    'sprite': '132_ditto',
    'name': 'Ditto',
    'health': 1,
    'location': [-122.0517700, 37.3301125]
  },
  {
    'sprite': '133_eevee',
    'name': 'Eevee',
    'health': 1,
    'location': [-122.0067700, 37.3341125]
  },
  {
    'sprite': '134_vaporeon',
    'name': 'Vaporeon',
    'health': 1,
    'location': [-122.0547700, 37.3301125]
  },
  {
    'sprite': '135_jolteon',
    'name': 'Jolteon',
    'health': 1,
    'location': [-122.0037700, 37.3341125]
  },
  {
    'sprite': '136_flareon',
    'name': 'Flareon',
    'health': 1,
    'location': [-122.0577700, 37.3301125]
  },
  {
    'sprite': '137_porygon',
    'name': 'Porygon',
    'health': 1,
    'location': [-122.0307700, 37.3361125]
  },
  {
    'sprite': '138_omanyte',
    'name': 'Omanyte',
    'health': 1,
    'location': [-122.0307700, 37.3281125]
  },
  {
    'sprite': '139_omastar',
    'name': 'Omastar',
    'health': 1,
    'location': [-122.0277700, 37.3361125]
  },
  {
    'sprite': '13_weedle',
    'name': 'Eedle',
    'health': 1,
    'location': [-122.0337700, 37.3281125]
  },
  {
    'sprite': '140_kabuto',
    'name': 'Kabuto',
    'health': 1,
    'location': [-122.0247700, 37.3361125]
  },
  {
    'sprite': '141_kabutops',
    'name': 'Kabutops',
    'health': 1,
    'location': [-122.0367700, 37.3281125]
  },
  {
    'sprite': '142_aerodactyl',
    'name': 'Aerodactyl',
    'health': 1,
    'location': [-122.0217700, 37.3361125]
  },
  {
    'sprite': '143_snorlax',
    'name': 'Snorlax',
    'health': 1,
    'location': [-122.0397700, 37.3281125]
  },
  {
    'sprite': '144_articuno',
    'name': 'Articuno',
    'health': 1,
    'location': [-122.0187700, 37.3361125]
  },
  {
    'sprite': '145_zapdos',
    'name': 'Zapdos',
    'health': 1,
    'location': [-122.0427700, 37.3281125]
  }
]

for animal in animals:
  headers = {'Content-type': 'application/json'}
  r = requests.post("http://discoverage.herokuapp.com/animal", data=json.dumps(animal), headers=headers)
  print(r.text)
