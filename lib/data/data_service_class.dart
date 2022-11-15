//při vypnutí appky se musí uložit practice vocab do vocablistu a ten následně do souboru . json
//měnit practice list pomocí funkce - bezpečnější

//_vocabList - všechna slovíčka i se statusem
//_practiceVocab - vybrané lekce mapa [unit, lekce] : [slovíčka]
//_practiceVocabList - [slovíčka]
class ClassService {
  Map _vocabList = {};
  Map _practiceVocab = {};

  void fillVocabList(Map chosenClass) {
    //pokud chci změnit třídu, tak se vocablist musí uložit do souboru, aby se tu nesmazal
    _vocabList = {};
    _vocabList = chosenClass.map((key, value) => MapEntry(
        key,
        value.map((key, value) => MapEntry(
            key, value.map((e) => [e[0], e[1], "unknown"]).toList()))));
  }

  List fillPracticeVocab(Map lectureList) {
    //pokud chci změnit lekci, tak se practicevocab musí uložit do vocablistu, aby se tu nesmazal
    _practiceVocab = {};
    lectureList.forEach((key, value) {
      for (var element in value) {
        if (element[1] == true) {
          //_practiceVocab.addAll(_vocabList[key]![element[0]]!.map((e) => e.toList()));
          _practiceVocab[[key, element[0]]] = _vocabList[key]![element[0]]!;
        }
      }
    });
    return getPracticeVocab();
  }

  void setPracticeVocab(String lexis, String status) {
    _practiceVocab.forEach((key, value) {
      for (var element in value) {
        if (element[0] == lexis) {
          element[2] = status;
        }
      }
    });
  }

  List getPracticeVocab() {
    List _practiceVocabList = [];
    _practiceVocab.forEach((key, value) {
      _practiceVocabList.addAll(value);
    });
    return _practiceVocabList;
  }

  // void savePracticeVocab() {
  //   //nulovat _practice vocab?
  //   _practiceVocab.forEach((key, value) {
  //     _vocabList[key] = value;
  //   });
  //   print(_vocabList);
  // }
}

ClassService classService = ClassService();
