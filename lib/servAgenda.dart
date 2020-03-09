
class Evento {
  final int id;
  final DateTime de;
  final DateTime ate;
  final int idAtividade;
  final String descrAtividade;
  final int levelAtividade;
  final String local;
  final String participantes;
  final bool conlcuida;
  final int levelSatisf;

  Evento(this.id, this.de, this.ate, this.idAtividade, this.descrAtividade ,this.levelAtividade, this.local, this.participantes, {this.conlcuida = false, this.levelSatisf = 0});


}

class ServAgenda {

  final List<Evento> _agenda = [
    Evento(1, DateTime(2020,2,29,16,0), DateTime(2020,2,29,17,30), 27, 'Planejar as férias', 1, 'Casa', 'Disney cast'),
    Evento(2, DateTime(2020,2,29,21,30), DateTime(2020,2,29,23,30), 17, 'Assistir televisão, séries e vídeos', 1, 'Casa', ''),
    Evento(3, DateTime(2020,3,1,10,00), DateTime(2020,3,1,11,45), 44,'Cuidar do jardim ou piscina',  1, 'Casa', ''),

  ];

   List<Evento> get agenda {
    return [..._agenda];
  }

}