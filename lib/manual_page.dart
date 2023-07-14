import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ManualPage extends StatefulWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  State<ManualPage> createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  late final DatabaseReference _modoManualRef;
  late final DatabaseReference _outIrrigacaoRef;
  late final DatabaseReference _outVentoinhaRef;
  late final DatabaseReference _outLampadaAquecimentoRef;
  late final DatabaseReference _modoAutomaticoRef;

  late StreamSubscription<DatabaseEvent> _modoManualSubscription;

  bool _estadoVentoinha = false;
  bool _estadoLampada = false;
  bool _estadoIrrigacao = false;
  bool estadoModoManual = false;
  String _nomeModoManual = 'Desligado';

  @override
  void initState(){
    super.initState();
    init();
  }

  init() async{
    _modoManualRef = FirebaseDatabase.instance.ref('modoManual');
    _outIrrigacaoRef = FirebaseDatabase.instance.ref('outIrrigacao');
    _outLampadaAquecimentoRef = FirebaseDatabase.instance.ref('outLampadaAquecimento');
    _outVentoinhaRef = FirebaseDatabase.instance.ref('outVentoinha');
    _modoAutomaticoRef = FirebaseDatabase.instance.ref('modoAutomatico');

    try{
      final modoManualSnapshot = await _modoManualRef.get();
      estadoModoManual = modoManualSnapshot.value as bool;
    }
    catch(err){
      debugPrint(err.toString());
    }

    _modoManualSubscription =
        _modoManualRef.onValue.listen((DatabaseEvent event) {
          setState((){
            estadoModoManual = (event.snapshot.value ?? 0) as bool;
            corTextoModoManual();
            textoModoManual();
            desligaDispositivos();
          });
        });
  }

  dbModoManual(estado) async{
    await _modoManualRef.set(estado);
    await _modoAutomaticoRef.set(!estado);
  }

  dbVentoinha(estado) async{
    await _outVentoinhaRef.set(estado);
  }

  dbLampadaAquecimento(estado) async{
    await _outLampadaAquecimentoRef.set(estado);
  }

  dbIrrigacao(estado) async{
    await _outIrrigacaoRef.set(estado);
  }

  Color? corIcone(estado) {
    if (estado == true) {
      return Colors.green;
    } else {
      return null;
    }
  }

  Color? corTextoModoManual() {
    if (estadoModoManual == false) {
      return Colors.red[700];
    } else {
      return Colors.green[700];
    }
  }

  void textoModoManual() {
    if (estadoModoManual == true) {
      _nomeModoManual = 'Ligado';
    } else {
      _nomeModoManual = 'Desligado';
    }
  }

  void desligaDispositivos() {
    if (estadoModoManual == false) {
      _estadoVentoinha = false;
      _estadoLampada = false;
      _estadoIrrigacao = false;

      dbVentoinha(false);
      dbIrrigacao(false);
      dbLampadaAquecimento(false);

    }
  }

  @override
  void dispose() {
    _modoManualSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
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
                'Modo Manual',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _nomeModoManual,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 18,
                  color: corTextoModoManual(),
                ),
              ),
              Transform.scale(
                scale: 1.5,
                child: Switch(
                  value: estadoModoManual,
                  activeColor: Colors.green,
                  onChanged: (bool valor) {
                      setState((){
                        dbModoManual(valor);
                        textoModoManual();
                        desligaDispositivos();
                      });
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1.5,
        ),
        ListTile(
          leading: Icon(
            Icons.wind_power,
            size: 30,
            color: corIcone(_estadoVentoinha),
          ),
          title: const Text(
            'Ventoinha',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 20,
            ),
          ),
          trailing: Switch(
            activeColor: Colors.green,
            value: _estadoVentoinha,
            onChanged: (bool valor) {
              setState(() {
                if (estadoModoManual == true) {
                  _estadoVentoinha = valor;
                  dbVentoinha(valor);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          exibeMensagemModoDesligado());
                }
              });
            },
          ),
        ),
        const Divider(
          thickness: 1.5,
        ),
        ListTile(
          leading: Icon(
            Icons.lightbulb_rounded,
            size: 30,
            color: corIcone(_estadoLampada),
          ),
          title: const Text(
            'Lâmpada de Aquecimento',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 20,
            ),
          ),
          trailing: Switch(
            activeColor: Colors.green,
            value: _estadoLampada,
            onChanged: (bool valor) {
              setState(() {
                if (estadoModoManual == true) {
                  dbLampadaAquecimento(valor);
                  _estadoLampada = valor;
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          exibeMensagemModoDesligado());
                }
              });
            },
          ),
        ),
        const Divider(
          thickness: 1.5,
        ),
        ListTile(
          leading: Icon(
            Icons.shower_rounded,
            size: 30,
            color: corIcone(_estadoIrrigacao),
          ),
          title: const Text(
            'Irrigação',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 20,
            ),
          ),
          trailing: Switch(
            activeColor: Colors.green,
            value: _estadoIrrigacao,
            onChanged: (bool valor) {
              setState(() {
                if (estadoModoManual == true) {
                  dbIrrigacao(valor);
                  _estadoIrrigacao = valor;
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          exibeMensagemModoDesligado());
                }
              });
            },
          ),
        ),
        const Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}

class exibeMensagemModoDesligado extends StatelessWidget {
  const exibeMensagemModoDesligado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Modo Manual Desativado!',
        style: TextStyle(fontSize: 24),
      ),
      content: Text(
        'Ligue o Modo Manual para ativar o dispositivo',
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'Ok',
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        )
      ],
    );
  }
}
