import 'dart:async';
import 'package:estufa_inteligente/setPointPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AutomaticoPage extends StatefulWidget {
  const AutomaticoPage({Key? key}) : super(key: key);

  @override
  State<AutomaticoPage> createState() => _AutomaticoPageState();
}

class _AutomaticoPageState extends State<AutomaticoPage> {
  late final DatabaseReference _modoAutomaticoRef;
  late final DatabaseReference _spMaxLuminosidadeRef;
  late final DatabaseReference _spMinLuminosidadeRef;
  late final DatabaseReference _spMaxTemperaturaRef;
  late final DatabaseReference _spMinTemperaturaRef;
  late final DatabaseReference _spMaxUmidadeSoloRef;
  late final DatabaseReference _spMinUmidadeSoloRef;
  late final DatabaseReference _spMaxUmidadeArRef;
  late final DatabaseReference _spMinUmidadeArRef;
  late final DatabaseReference _modoManualRef;

  late StreamSubscription<DatabaseEvent> _spMaxLuminosidadeSubscription;
  late StreamSubscription<DatabaseEvent> _spMinLuminosidadeSubscription;
  late StreamSubscription<DatabaseEvent> _spMaxTemperaturaSubscription;
  late StreamSubscription<DatabaseEvent> _spMinTemperaturaSubscription;
  late StreamSubscription<DatabaseEvent> _spMaxUmidadeSoloSubscription;
  late StreamSubscription<DatabaseEvent> _spMinUmidadeSoloSubscription;
  late StreamSubscription<DatabaseEvent> _spMaxUmidadeArSubscription;
  late StreamSubscription<DatabaseEvent> _spMinUmidadeArSubscription;
  late StreamSubscription<DatabaseEvent> _modoAutomaticoSubscription;

  String _nomeModoAutomatico = 'Desligado';
  bool estadoModoAutomatico = true;

  // Valores do Set Point
  int luminosidadeSPMax = 0;
  int luminosidadeSPMin = 0;
  int temperaturaSPMax = 0;
  int temperaturaSPMin = 0;
  int umidadeSoloSPMax = 0;
  int umidadeSoloSPMin = 0;
  int umidadeArSPMax = 0;
  int umidadeArSPMin = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _modoAutomaticoRef = FirebaseDatabase.instance.ref('modoAutomatico');
    _spMaxLuminosidadeRef = FirebaseDatabase.instance.ref('spMaxLuminosidade');
    _spMinLuminosidadeRef = FirebaseDatabase.instance.ref('spMinLuminosidade');
    _spMaxTemperaturaRef = FirebaseDatabase.instance.ref('spMaxTemperatura');
    _spMinTemperaturaRef = FirebaseDatabase.instance.ref('spMinTemperatura');
    _spMaxUmidadeSoloRef = FirebaseDatabase.instance.ref('spMaxUmidadeSolo');
    _spMinUmidadeSoloRef = FirebaseDatabase.instance.ref('spMinUmidadeSolo');
    _spMaxUmidadeArRef = FirebaseDatabase.instance.ref('spMaxUmidadeAr');
    _spMinUmidadeArRef = FirebaseDatabase.instance.ref('spMinUmidadeAr');
    _modoManualRef = FirebaseDatabase.instance.ref('modoManual');

    // Set Point Máximo da Luminosidade
    try {
      final spMaxLuminosidadeSnapshot = await _spMaxLuminosidadeRef.get();
      luminosidadeSPMax = spMaxLuminosidadeSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    // Set Point Mínimo da Luminosidade
    try {
      final spMinLuminosidadeSnapshot = await _spMinLuminosidadeRef.get();
      luminosidadeSPMin = spMinLuminosidadeSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final spMaxTemperaturaSnapshot = await _spMaxTemperaturaRef.get();
      temperaturaSPMax = spMaxTemperaturaSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final spMinTemperaturaSnapshot = await _spMinTemperaturaRef.get();
      temperaturaSPMin = spMinTemperaturaSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final spMaxUmidadeSoloSnapshot = await _spMaxUmidadeSoloRef.get();
      umidadeSoloSPMax = spMaxUmidadeSoloSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final spMinUmidadeSoloSnapshot = await _spMinUmidadeSoloRef.get();
      umidadeSoloSPMin = spMinUmidadeSoloSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final spMaxUmidadeArSnapshot = await _spMaxUmidadeArRef.get();
      umidadeArSPMax = spMaxUmidadeArSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final spMinUmidadeArSnapshot = await _spMinUmidadeArRef.get();
      umidadeArSPMin = spMinUmidadeArSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final modoAutomaticoSnapshot = await _modoAutomaticoRef.get();
      estadoModoAutomatico = modoAutomaticoSnapshot.value as bool;
    } catch (err) {
      debugPrint(err.toString());
    }

    // ------------------------------------------------------------------

    // Set Point Máximo da Luminosidade
    _spMaxLuminosidadeSubscription =
        _spMaxLuminosidadeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        luminosidadeSPMax = (event.snapshot.value ?? 0) as int;
      });
    });

    // Set Point Mínimo da Luminosidade
    _spMinLuminosidadeSubscription =
        _spMinLuminosidadeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        luminosidadeSPMin = (event.snapshot.value ?? 0) as int;
      });
    });

    _spMaxTemperaturaSubscription =
        _spMaxTemperaturaRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        temperaturaSPMax = (event.snapshot.value ?? 0) as int;
      });
    });

    _spMinTemperaturaSubscription =
        _spMinTemperaturaRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        temperaturaSPMin = (event.snapshot.value ?? 0) as int;
      });
    });

    _spMaxUmidadeSoloSubscription =
        _spMaxUmidadeSoloRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        umidadeSoloSPMax = (event.snapshot.value ?? 0) as int;
      });
    });

    _spMinUmidadeSoloSubscription =
        _spMinUmidadeSoloRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        umidadeSoloSPMin = (event.snapshot.value ?? 0) as int;
      });
    });

    _spMaxUmidadeArSubscription =
        _spMaxUmidadeArRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        umidadeArSPMax = (event.snapshot.value ?? 0) as int;
      });
    });

    _spMinUmidadeArSubscription =
        _spMinUmidadeArRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        umidadeArSPMin = (event.snapshot.value ?? 0) as int;
      });
    });

    _modoAutomaticoSubscription =
        _modoAutomaticoRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        estadoModoAutomatico = (event.snapshot.value ?? 0) as bool;
        textoModoAutomatico();
        corTextoModoAutomatico();
      });
    });
  }

  dbModoAutomatico(estado) async {
    await _modoAutomaticoRef.set(estado);
    await _modoManualRef.set(!estado);
  }

  @override
  void dispose() {
    _spMaxLuminosidadeSubscription.cancel();
    _spMinLuminosidadeSubscription.cancel();
    _spMaxTemperaturaSubscription.cancel();
    _spMinTemperaturaSubscription.cancel();
    _spMaxUmidadeSoloSubscription.cancel();
    _spMinUmidadeSoloSubscription.cancel();
    _spMaxUmidadeArSubscription.cancel();
    _spMinUmidadeArSubscription.cancel();
    _modoAutomaticoSubscription.cancel();
    super.dispose();
  }

  Color corTextoModoAutomatico() {
    if (estadoModoAutomatico == true) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void textoModoAutomatico() {
    if (estadoModoAutomatico == true) {
      _nomeModoAutomatico = 'Ligado';
    } else {
      _nomeModoAutomatico = 'Desligado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 3,
                )
              ]),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Modo Automático',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _nomeModoAutomatico,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 18,
                  color: corTextoModoAutomatico(),
                ),
              ),
              Transform.scale(
                scale: 1.5,
                child: Switch(
                    value: estadoModoAutomatico,
                    activeColor: Colors.green,
                    onChanged: (bool valor) {
                      setState(() {
                        dbModoAutomatico(valor);
                        textoModoAutomatico();
                      });
                    }),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1.5,
        ),
        PainelSetPoint(
          icone: Icons.light_mode_outlined,
          onPressed: () {},
          tipoVariavel: 'Luminosidade',
          valorSPMax: '$luminosidadeSPMax%',
          valorSPMin: '$luminosidadeSPMin%',
        ),
        const Divider(
          thickness: 1.5,
        ),
        PainelSetPoint(
          icone: Icons.local_fire_department,
          onPressed: () {},
          tipoVariavel: 'Temperatura',
          valorSPMax: '$temperaturaSPMax°',
          valorSPMin: '$temperaturaSPMin°',
        ),
        const Divider(
          thickness: 1.5,
        ),
        PainelSetPoint(
          icone: Icons.water_drop_rounded,
          onPressed: () {},
          tipoVariavel: 'Umidade do Solo',
          valorSPMax: '$umidadeSoloSPMax%',
          valorSPMin: '$umidadeSoloSPMin%',
        ),
        const Divider(
          thickness: 1.5,
        ),
        PainelSetPoint(
          icone: Icons.ac_unit,
          onPressed: () {},
          tipoVariavel: 'Umidade do Ar',
          valorSPMax: '$umidadeArSPMax%',
          valorSPMin: '$umidadeArSPMin%',
        ),
        const Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}

class PainelSetPoint extends StatelessWidget {
  IconData icone;
  final VoidCallback onPressed;
  String tipoVariavel;
  String valorSPMax;
  String valorSPMin;

  PainelSetPoint({
    required this.icone,
    required this.onPressed,
    required this.tipoVariavel,
    required this.valorSPMax,
    required this.valorSPMin,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icone,
        size: 30,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tipoVariavel,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Outfit',
            ),
          ),
          Column(
            children: [
              Text(
                'Máx: $valorSPMax',
                style: TextStyle(
                  fontFamily: 'Outfit',
                ),
              ),
              Text(
                'Min: $valorSPMin',
                style: TextStyle(
                  fontFamily: 'Outfit',
                ),
              )
            ],
          ),
        ],
      ),
      trailing: ElevatedButton(
        child: Text(
          'Alterar',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[700],
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SetPointPage(tipoVariavel: tipoVariavel)));
        },
      ),
    );
  }
}
