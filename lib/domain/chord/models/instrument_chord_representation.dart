import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/chord/models/finger.dart';
import 'package:cifraclub/domain/chord/models/instrument_chord.dart';
import 'package:cifraclub/domain/chord/models/neck.dart';
import 'package:cifraclub/domain/chord/models/note.dart';
import 'package:cifraclub/domain/chord/models/note_state.dart';

abstract class InstrumentChordRepresentation {
  final int numStrings;

  InstrumentChordRepresentation({required this.numStrings});

  ChordRepresentation buildChord({required InstrumentChord instrumentChord}) {
    var mount = instrumentChord.fretDiagram.split(" ").sublist(0, numStrings);

    var lowestFret = 100; // armazena menor casa pressionada (sem corda solta)
    var highestFret = 0; // armazena maior casa pressionada
    var hits = 0; // Número de dedos já usados. Vai controlar se vamos precisar de pestana ou não
    var bassStringIndex = -1;

    for (var n = 0; n < mount.length; n++) {
      var fret = mount[n];
      if (fret != 'X' && fret != 'x') {
        var fretNumber = int.tryParse(fret.replaceAll('P', '').replaceAll('p', '')) ?? 0;
        if (fret[0] != 'P' && fretNumber != 0 && fretNumber < lowestFret) {
          lowestFret = fretNumber;
        }
        if (fretNumber > highestFret) {
          highestFret = fretNumber;
        }
        if (fret[0] != 'P' && fret[0] != 'p' && fretNumber != 0) {
          hits++;
        }
        if (bassStringIndex < 0) {
          bassStringIndex = n;
        }
      }
    }

    var firstFret = lowestFret;
    if (highestFret <= 5) {
      lowestFret = 1;
    }

    var neckStart = 0;
    var finger = 1;
    var inBar = 0;
    bool emptyFret;
    bool hasBar;
    bool afterBar;
    bool thumbFinger;
    var fingers = <Finger>[];
    Bar? bar;

    for (var fretNumber = lowestFret; fretNumber <= (lowestFret + 4); fretNumber++) {
      hasBar = false;
      emptyFret = true;

      for (var string = 0; string < numStrings; string++) {
        afterBar = mount[string] == "P$fretNumber";
        thumbFinger = mount[string] == "p$fretNumber";

        if (int.tryParse(mount[string]) == fretNumber || hasBar || afterBar || thumbFinger) {
          emptyFret = false;

          // Vai precisar de pestana
          if ((hits > 4 && fretNumber == firstFret) || hasBar || afterBar) {
            if (!hasBar) {
              var strings = numStrings - string;
              var frets = fretNumber + 1 - lowestFret;

              // Pestana
              bar = Bar(string: strings, fret: frets);

              finger++;

              // Hack pra evitar usar os dedos 1 e 2 juntos em acordes como F#m
              for (var i = 0; i < mount.length; i++) {
                if (int.tryParse(mount[i]) == fretNumber) {
                  inBar++;
                }
              }

              if (hits - inBar <= 2) {
                finger++;
              }
            }

            hasBar = true;
          } else {
            var strings = numStrings - string;
            var frets = fretNumber + 1 - lowestFret;

            // Dedo normal
            fingers.add(Finger(id: finger, fret: frets, string: strings));

            finger++;
          }
        }
      }

      // Tá faltando dedo pra por ainda
      if (emptyFret && finger == 2 && hits < 4) {
        finger++;
      }

      // O acorde não começa no começa do braço
      if (fretNumber == lowestFret && lowestFret != 1) {
        neckStart = fretNumber;
      }
    }

    // Pra facilar a leitura, insere o braço no início da lista de partes
    final neck = Neck(start: neckStart);

    // Constrói as cordas que serão tocadas (bolinhas no rodapé do acorde)
    var notes = <Note>[];
    for (var n = mount.length - 1; n >= 0; n--) {
      if (mount[n].toUpperCase() == 'X') {
        notes.add(const Note(NoteState.notPicked));
      } else if (bassStringIndex == n) {
        notes.add(const Note(NoteState.bassNote));
      } else {
        notes.add(const Note(NoteState.picked));
      }
    }

    return ChordRepresentation(
      original: instrumentChord.fretDiagram,
      neck: neck,
      notes: notes,
      fingers: fingers,
      bar: bar,
      instrument: this,
      name: instrumentChord.name,
    );
  }
}

class CavacoChordRepresentation extends InstrumentChordRepresentation {
  CavacoChordRepresentation() : super(numStrings: 4);
}

class GuitarChordRepresentation extends InstrumentChordRepresentation {
  GuitarChordRepresentation() : super(numStrings: 6);
}

class UkuleleChordRepresentation extends InstrumentChordRepresentation {
  UkuleleChordRepresentation() : super(numStrings: 4);
}

class ViolaChordRepresentation extends InstrumentChordRepresentation {
  ViolaChordRepresentation() : super(numStrings: 5);
}
