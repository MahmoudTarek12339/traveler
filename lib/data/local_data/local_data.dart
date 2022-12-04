import 'package:traveler/model/models.dart';

List<Review> reviews = [
  Review('Mahmoud Tarek', 'assets/users/user1.png', 'Apr 24th 2022',
      'It was really an enjoyable visit to this place it is really a masterpiece in all meanings creativity in details and colors it is really a wonderful place'),
  Review('Salma Wassouf', 'assets/users/user2.png', 'May 15th 2022',
      'It was a great historical site, really enjoyed the view, the air and everything, I will definitely visit this place again'),
  Review('Mohammed Mostafa', 'assets/users/user3.png', 'MAR 6th 2021',
      'It was a very good experience, I really enjoyed it, for sure i will visit it again')
];

List<Country> countries = [
  Country(
      'Egypt',
      'assets/countries/egypt.jpg',
      'Egypt has one of the longest histories of any country, tracing its heritage along the Nile Delta .',
      [
        Location(
            'Cairo Tower',
            'assets/egypt/cairo_tower.jpg',
            'Sharia Hadayek al-Zuhreya, Cairo',
            'Standing 614 feet (187 meters) tall on Gezira Island, the Cairo Tower is one of Cairo’s most recognizable landmarks.',
            4.5,
            reviews[0]),
        Location(
            'Djoser Pyramid',
            'assets/egypt/djoser_pyramid.jpg',
            'Saqqara, Egypt',
            'Considered the original pyramid and the world’s earliest stone monument, the Pyramid of Djoser (Step Pyramid) is a highlight of any trip to Saqqara. Built in 2650 BC, it still stands proud over Saqqara, surrounded by the remains of ritual buildings.',
            3.5,
            reviews[1]),
        Location(
            'Giza Pyramids',
            'assets/egypt/pyramids.jpg',
            'Giza, Egypt',
            "The Pyramids of Giza are one of the Seven Wonders of the World. Dating back over 4,500 years, these awe-inspiring pyramids were built as tombs for three kings of Egypt's Old Kingdom. Today, the Pyramids are one of the most popular tourist sites in the world",
            4.75,
            reviews[2])
      ]),
  Country(
      'China',
      'assets/countries/china.jpg',
      'China has a history of thousands of years, which gives it a lot of historical sites.',
      [
        Location(
            'The Great Wall',
            'assets/china/great_wall.jpg',
            'Beijing, China',
            'The Great Wall of China is one of the most notorious structures in the entire world. The Jinshanling section in Hebei Province, China, pictured here, is only a small part of the wall that stretches over 4,000 kilometers',
            4.5,
            reviews[0]),
        Location(
            'The Forbidden City',
            'assets/china/forbidden_city.jpg',
            'Beijing, China',
            'Imperial Palace complex in Beijing, containing hundreds of buildings and some 9,000 rooms. It served the emperors of China from 1421 to 1911. No commoner or foreigner was allowed to enter it without special permission. The moated palaces, with their golden tiled roofs and red pillars, are surrounded by high walls with a tower on each corner.',
            4,
            reviews[1]),
        Location(
            'Potala Palace',
            'assets/china/potala_palace.jpg',
            'Lhasa, Tibet',
            'The Potala Palace is a Tibetan castle located on Red Hill with an elevation of 3,750 meters above sea level,The Potala Palace was listed as a world cultural heritage now. The open area of Potala Palace is the main building which consists of the White House and the Red Palace which contains a large number of cultural relics and treasures inside. ',
            3.5,
            reviews[2])
      ]),
  Country(
      'Greece',
      'assets/countries/greece.jpg',
      'If you are a history lover, then a vacation to Greece is pure perfection',
      [
        Location(
            'Acropolis of Athens',
            'assets/greece/acropolis_of_athens.jpg',
            'Athens, Greece',
            "The Acropolis of Athens, a UNESCO World Heritage Site, is the city's most iconic attraction, with its ancient Parthenon and beautiful views of the city.",
            4.5,
            reviews[0]),
        Location(
            'Delphi',
            'assets/greece/delphi.jpg',
            'Ancient city, Greece',
            'Delphi , Site of the ancient temple and oracle of Apollo in Greece. Located on the slopes of Mount Parnassus, it was the centre of the world in ancient Greek religion.',
            4,
            reviews[1]),
        Location(
            'Meteora',
            'assets/greece/meteora.jpg',
            'Thessaly, Greece',
            'The Meteora is a rock formation in central Greece hosting one of the largest and most precipitously built complexes of Eastern Orthodox monasteries, second in importance only to Mount Athos.',
            3.5,
            reviews[2])
      ]),
  Country(
      'Italy',
      'assets/countries/italy.jpg',
      'More than sunshine and siestas, Italy has a long and fascinating history with historical sites to match.',
      [
        Location(
            "Doge's Palace",
            'assets/italy/doges_palace.jpg',
            'Venice, Italy',
            "The Doge's Palace is a palace built in Venetian Gothic style, and one of the main landmarks of the city of Venice in northern Italy. The palace was the residence of the Doge of Venice, the supreme authority of the former Republic.",
            4.5,
            reviews[0]),
        Location(
            "Hadrian's Villa",
            'assets/italy/hadrians_villa.jpg',
            'Rome, Italy',
            "Hadrian's Villa is a UNESCO World Heritage Site comprising the ruins and archaeological remains of a large villa complex built c. AD 120 by Roman Emperor Hadrian at Tivoli outside Rome.",
            4,
            reviews[1]),
        Location(
            'Palazzo Vecchio',
            'assets/italy/palazzo_vecchio.jpg',
            'Florence, Italy',
            'Palazzo Vecchio, also called Palazzo della Signoria, most important historic government building in Florence, having been the seat of the Signoria of the Florentine Republic in the 14th century and then the government centre of the Medici grand dukes of Tuscany. From 1865 to 1871 it housed the Chamber of Deputies of the Kingdom of Italy, and since 1872 it has been the town hall.',
            3.5,
            reviews[2]),
      ])
];
