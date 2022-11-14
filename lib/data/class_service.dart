//při vypnutí appky se musí uložit practice vocab do vocablistu a ten následně do souboru . json
//měnit practice list pomocí funkce - bezpečnější
class ClassService {
  Map _vocabList = {};
  List _practiceVocab = [];

  void fillVocabList(chosenClass) {
    //pokud chci změnit třídu, tak se vocablist musí uložit do souboru, aby se tu nesmazal
    _vocabList = {};
    _vocabList = chosenClass.map((key, value) => MapEntry(
        key,
        value.map((key, value) => MapEntry(
            key, value.map((e) => [e[0], e[1], "unknown"]).toList()))));
  }

  List fillPracticeVocab(lectureList) {
    //pokud chci změnit lekci, tak se practicevocab musí uložit do vocablistu, aby se tu nesmazal
    _practiceVocab = [];
    lectureList.forEach((key, value) {
      for (var element in value) {
        if (element[1] == true) {
          //_practiceVocab.addAll(_vocabList[key]![element[0]]!.map((e) => e.toList()));
          _practiceVocab.addAll(_vocabList[key]![element[0]]!);
        }
      }
    });
    return _practiceVocab;
  }

  List getPracticeVocab() {
    return _practiceVocab;
  }
}

ClassService classService = ClassService();
