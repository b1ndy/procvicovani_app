//při vypnutí appky se musí uložit practice vocab do vocablistu a ten následně do souboru . json

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
            key,
            value
                .map((e) => [e[0], e[1], e.length == 3 ? e[2] : "unknown"])
                .toList()))));
  }

  bool fillPracticeVocab(Map lectureList) {
    _practiceVocab = {};
    lectureList.forEach((key, value) {
      for (var element in value) {
        if (element[1] == true) {
          _practiceVocab[[key, element[0]]] = _vocabList[key]![element[0]]!;
        }
      }
    });
    return (_practiceVocab.isNotEmpty) ? true : false;
  }

  //sets status (learned, learning..) for certain lexis in _practiceVocab
  void setPracticeVocab(String lexis, String status) {
    _practiceVocab.forEach((key, value) {
      for (var element in value) {
        if (element[0] == lexis) {
          element[2] = status;
        }
      }
    });
  }

  int _getLearnedCount() {
    int _learned = 0;
    _practiceVocab.forEach((key, value) {
      for (var e in value) {
        if (e[2] == "learned") {
          _learned++;
        }
      }
    });
    return _learned;
  }

  //returns counters for practiceVocab including learned
  List<int> getCounters() {
    int _unknown = 0;
    int _learning = 0;
    int _learned = _getLearnedCount();
    getPracticeVocab().forEach((element) {
      switch (element[2]) {
        case "unknown":
          _unknown++;
          break;
        case "learning":
          _learning++;
          break;
        default:
      }
    });
    return [_unknown, _learning, _learned];
  }

  //sets all PracticeVocab to unknown
  void resetPracticeVocab() {
    _practiceVocab.forEach((key, value) {
      for (var element in value) {
        element[2] = "unknown";
      }
    });
  }

  //returns _vocabList
  Map getVocabList() {
    return _vocabList;
  }

  //returns shuffled practiceVocabList
  List getPracticeVocab() {
    List _practiceVocabList = [];
    _practiceVocab.forEach((key, value) {
      for (var e in value) {
        if (e[2] != "learned") {
          _practiceVocabList.add(e);
        }
      }
    });
    _practiceVocabList.shuffle();
    return _practiceVocabList;
  }
}

//how to get mixed practiceVocab

ClassService classService = ClassService();
