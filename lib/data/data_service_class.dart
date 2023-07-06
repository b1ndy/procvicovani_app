//při vypnutí appky se musí uložit practice vocab do vocablistu a ten následně do souboru . json

//_vocabList - všechna slovíčka i se statusem
//_practiceVocab - vybrané lekce mapa [unit, lekce] : [slovíčka]
//_practiceVocabList - [slovíčka]
class DataServiceClass {
  Map _vocabList = {};
  List _practiceVocab = [];
  Map _practiceVocab2 = {};
  List _currentVocab = [];

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
    _practiceVocab2 = {};
    lectureList.forEach((key, value) {
      for (var element in value) {
        if (element[1] == true) {
          _practiceVocab2[[key, element[0]]] = _vocabList[key]![element[0]]!;
        }
      }
    });
    //print(_practiceVocab2);
    return (_practiceVocab.isNotEmpty) ? true : false;
  }

  bool fillPracticeVocab2(List vocabularyList) {
    _practiceVocab = [];
    for (var e in vocabularyList) {
      List temp = _vocabList[e[0]][e[1]];
      _practiceVocab.add(temp.firstWhere((e2) => e2[0] == e[2]));
    }
    return (_practiceVocab.isNotEmpty) ? true : false;
  }

  //saves curret vocab
  void saveCurrentVocab(List currentVocab) {
    _currentVocab = currentVocab;
  }

  //sets status (learned, learning..) for certain lexis in _practiceVocab
  void setPracticeVocab(String lexis, String status) {
    for (var e in _practiceVocab) {
      if (e[0] == lexis) {
        e[2] = status;
      }
    }
  }

  int _getLearnedCount() {
    int _learned = 0;
    for (var e in _practiceVocab) {
      if (e[2] == "learned") {
        _learned++;
      }
    }
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

  void resetLecture(unit, lecture) {
    _vocabList[unit][lecture].forEach((e) {
      e[2] = "unknown";
    });
  }

  //sets all PracticeVocab to unknown
  void resetPracticeVocab() {
    for (var e in _practiceVocab) {
      e[2] = "unknown";
    }
  }

  //returns vocab from certain lecture
  List getLectureVocab(unit, lecture) {
    List _lectureVocab = [];
    for (var element in _vocabList[unit][lecture]) {
      _lectureVocab.add([element[0], false]);
    }
    return _lectureVocab;
  }

  //returns _vocabList
  Map getVocabList() {
    return _vocabList;
  }

  //OLD CODE
  // Map getVocabList1() {
  //   Map<String, List<List>> _vocabList1 = {};
  //   _vocabList.forEach((key, value) {
  //     _vocabList1[key.toString()] = [];
  //     value.forEach((k, v) {
  //       _vocabList1[key.toString()]!.add([k, false]);
  //     });
  //   });
  //   print(_vocabList1.runtimeType);
  //   return _vocabList1;
  // }

  //returns shuffled practiceVocabList
  List getPracticeVocab() {
    List _practiceVocabList = [];
    for (var e in _practiceVocab) {
      if (e[2] != "learned") {
        _practiceVocabList.add(e);
      }
    }
    _practiceVocabList.shuffle();
    return _practiceVocabList;
  }

  //returns whole shuffled practiceVocabList (with learned)
  List getAllPracticeVocab() {
    List _practiceVocabList = [];
    for (var e in _practiceVocab) {
      _practiceVocabList.add(e);
    }
    _practiceVocabList.shuffle();
    return _practiceVocabList;
  }

  //returns curret vocab
  List getCurrentVocab() {
    return _currentVocab;
  }
}

DataServiceClass dataServiceClass = DataServiceClass();
