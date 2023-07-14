import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Referências do Database
  late final DatabaseReference _leituraLuminosidadeRef;
  late final DatabaseReference _leituraTemperaturaRef;
  late final DatabaseReference _leituraUmidadeArRef;
  late final DatabaseReference _leituraUmidadeSoloRef;
  late final DatabaseReference _spMaxLuminosidadeRef;
  late final DatabaseReference _spMinLuminosidadeRef;
  late final DatabaseReference _spMaxTemperaturaRef;
  late final DatabaseReference _spMinTemperaturaRef;
  late final DatabaseReference _spMaxUmidadeSoloRef;
  late final DatabaseReference _spMinUmidadeSoloRef;
  late final DatabaseReference _spMaxUmidadeArRef;
  late final DatabaseReference _spMinUmidadeArRef;
  late final DatabaseReference _estadoIrrigacaoRef;
  late final DatabaseReference _estadoVentoinhaRef;
  late final DatabaseReference _estadoLampadaAquecimentoRef;
  late final DatabaseReference _modoManualRef;

  // Subscriptions
  late StreamSubscription<DatabaseEvent> _leituraLuminosidadeSubscription;
  late StreamSubscription<DatabaseEvent> _leituraTemperaturaSubscription;
  late StreamSubscription<DatabaseEvent> _leituraUmidadeArSubscription;
  late StreamSubscription<DatabaseEvent> _leituraUmidadeSoloSubscription;
  late StreamSubscription<DatabaseEvent> _spMaxLuminosidadeSubscription;
  late StreamSubscription<DatabaseEvent> _spMinLuminosidadeSubscription;
  late StreamSubscription<DatabaseEvent> _spMaxTemperaturaSubscription;
  late StreamSubscription<DatabaseEvent> _spMinTemperaturaSubscription;
  late StreamSubscription<DatabaseEvent> _spMaxUmidadeSoloSubscription;
  late StreamSubscription<DatabaseEvent> _spMinUmidadeSoloSubscription;
  late StreamSubscription<DatabaseEvent> _spMaxUmidadeArSubscription;
  late StreamSubscription<DatabaseEvent> _spMinUmidadeArSubscription;
  late StreamSubscription<DatabaseEvent> _estadoIrrigacaoSubscription;
  late StreamSubscription<DatabaseEvent> _estadoVentoinhaSubscription;
  late StreamSubscription<DatabaseEvent> _estadoLampadaAquecimentoSubscription;
  late StreamSubscription<DatabaseEvent> _modoManualSubscripiton;

  int _valorLuminosidade = 0;
  int _valorTemperatura = 0;
  int _valorUmidadeAr = 0;
  int _valorUmidadeSolo = 0;
  int luminosidadeSPMax = 0;
  int luminosidadeSPMin = 0;
  int temperaturaSPMax = 0;
  int temperaturaSPMin = 0;
  int umidadeSoloSPMax = 0;
  int umidadeSoloSPMin = 0;
  int umidadeArSPMax = 0;
  int umidadeArSPMin = 0;
  bool _estadoIrrigacao = false;
  bool _estadoVentoinha = false;
  bool _estadoLampadaAquecimento = false;
  bool _estadoModoManual = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _leituraLuminosidadeRef =
        FirebaseDatabase.instance.ref('leituraLuminosidade');
    _leituraTemperaturaRef =
        FirebaseDatabase.instance.ref('leituraTemperatura');
    _leituraUmidadeArRef = FirebaseDatabase.instance.ref('leituraUmidadeAr');
    _leituraUmidadeSoloRef =
        FirebaseDatabase.instance.ref('leituraUmidadeSolo');
    _spMaxLuminosidadeRef = FirebaseDatabase.instance.ref('spMaxLuminosidade');
    _spMinLuminosidadeRef = FirebaseDatabase.instance.ref('spMinLuminosidade');
    _spMaxTemperaturaRef = FirebaseDatabase.instance.ref('spMaxTemperatura');
    _spMinTemperaturaRef = FirebaseDatabase.instance.ref('spMinTemperatura');
    _spMaxUmidadeSoloRef = FirebaseDatabase.instance.ref('spMaxUmidadeSolo');
    _spMinUmidadeSoloRef = FirebaseDatabase.instance.ref('spMinUmidadeSolo');
    _spMaxUmidadeArRef = FirebaseDatabase.instance.ref('spMaxUmidadeAr');
    _spMinUmidadeArRef = FirebaseDatabase.instance.ref('spMinUmidadeAr');
    _estadoIrrigacaoRef = FirebaseDatabase.instance.ref('estadoIrrigacao');
    _estadoVentoinhaRef = FirebaseDatabase.instance.ref('estadoVentoinha');
    _estadoLampadaAquecimentoRef =
        FirebaseDatabase.instance.ref('estadoLampadaAquecimento');
    _modoManualRef = FirebaseDatabase.instance.ref('modoManual');

    try{
      final _modoManualSnapshot = await _modoManualRef.get();
      _estadoModoManual = _modoManualSnapshot.value as bool;
    }
    catch(err){
      debugPrint(err.toString());
    }

    try {
      final _leituraLuminosidadeSnapshot = await _leituraLuminosidadeRef.get();
      _valorLuminosidade = _leituraLuminosidadeSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final _leituraTemperaturaSnapshot = await _leituraTemperaturaRef.get();
      _valorLuminosidade = _leituraTemperaturaSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final _leituraUmidadeArSnapshot = await _leituraUmidadeArRef.get();
      _valorLuminosidade = _leituraUmidadeArSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final _leituraUmidadeSoloSnapshot = await _leituraUmidadeSoloRef.get();
      _valorLuminosidade = _leituraUmidadeSoloSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

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
      final estadoIrrigacaoSnapshot = await _estadoIrrigacaoRef.get();
      _estadoIrrigacao = estadoIrrigacaoSnapshot.value as bool;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final estadoVentoinhaSnapshot = await _estadoVentoinhaRef.get();
      _estadoVentoinha = estadoVentoinhaSnapshot.value as bool;
    } catch (err) {
      debugPrint(err.toString());
    }

    try {
      final estadoLampadaAquecimentoSnapshot =
          await _estadoLampadaAquecimentoRef.get();
      _estadoVentoinha = estadoLampadaAquecimentoSnapshot.value as bool;
    } catch (err) {
      debugPrint(err.toString());
    }

    // Subscritpions
    _modoManualSubscripiton =
      _modoManualRef.onValue.listen((DatabaseEvent event) {
        setState((){
          _estadoModoManual = event.snapshot.value as bool;
        });
      });


    _leituraLuminosidadeSubscription =
        _leituraLuminosidadeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _valorLuminosidade = (event.snapshot.value ?? 0) as int;
      });
    });

    _leituraTemperaturaSubscription =
        _leituraTemperaturaRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _valorTemperatura = (event.snapshot.value ?? 0) as int;
      });
    });

    _leituraUmidadeArSubscription =
        _leituraUmidadeArRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _valorUmidadeAr = (event.snapshot.value ?? 0) as int;
      });
    });

    _leituraUmidadeSoloSubscription =
        _leituraUmidadeSoloRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _valorUmidadeSolo = (event.snapshot.value ?? 0) as int;
      });
    });

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

    _estadoIrrigacaoSubscription =
        _estadoIrrigacaoRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _estadoIrrigacao = (event.snapshot.value ?? 0) as bool;
      });
    });

    _estadoVentoinhaSubscription =
        _estadoVentoinhaRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _estadoVentoinha = (event.snapshot.value ?? 0) as bool;
      });
    });

    _estadoLampadaAquecimentoSubscription =
        _estadoLampadaAquecimentoRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _estadoLampadaAquecimento = (event.snapshot.value ?? 0) as bool;
      });
    });
  }

  String modoAtivo(){
    if(_estadoModoManual == true){
      return 'Modo Manual Ativo';
    }
    else{
      return 'Modo Automático Ativo';
    }
  }


  String estadoDispositivo(estado) {
    if (estado == true) {
      return 'ON';
    } else {
      return 'OFF';
    }
  }

  Color? corIconeDispositivo(estado) {
    if (estado == true) {
      return Colors.green[900];
    } else {
      return null;
    }
  }

  bool piscarValorLeituraForaIntervalo(int leitura, int spMax, int spMin) {
    if (leitura > spMax || leitura < spMin) {
      return true;
    } else {
      return false;
    }
  }

  Color? corLeituraForaIntervalo(int leitura, int spMax, int spMin) {
    if (leitura > spMax || leitura < spMin) {
      return Colors.deepOrange[800];
    }
  }

  @override
  void dispose() {
    _leituraTemperaturaSubscription.cancel();
    _leituraLuminosidadeSubscription.cancel();
    _leituraUmidadeArSubscription.cancel();
    _leituraUmidadeSoloSubscription.cancel();
    _spMaxLuminosidadeSubscription.cancel();
    _spMinLuminosidadeSubscription.cancel();
    _spMaxTemperaturaSubscription.cancel();
    _spMinTemperaturaSubscription.cancel();
    _spMaxUmidadeSoloSubscription.cancel();
    _spMinUmidadeSoloSubscription.cancel();
    _spMaxUmidadeArSubscription.cancel();
    _spMinUmidadeArSubscription.cancel();
    _estadoIrrigacaoSubscription.cancel();
    _estadoLampadaAquecimentoSubscription.cancel();
    _estadoVentoinhaSubscription.cancel();
    _modoManualSubscripiton.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          modoAtivo(),
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PainelMonitoramento(
                  icone: Icons.local_fire_department,
                  nomeVariavel: 'Temperatura',
                  leituraVariavel: '$_valorTemperatura°C',
                  spMaxVariavel: '$temperaturaSPMax°C',
                  spMinVariavel: '$temperaturaSPMin°C',
                  corValorLeitura: corLeituraForaIntervalo(
                    _valorTemperatura,
                    temperaturaSPMax,
                    temperaturaSPMin,
                  ),
                  piscarValorLeitura: piscarValorLeituraForaIntervalo(
                    _valorTemperatura,
                    temperaturaSPMax,
                    temperaturaSPMin,
                  ),
                  dispositivo: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.wind_power,
                            color: corIconeDispositivo(_estadoVentoinha),
                          ),
                          VerticalDivider(
                            width: 5,
                          ),
                          Text(
                            estadoDispositivo(_estadoVentoinha),
                            style: TextStyle(
                              color: corIconeDispositivo(_estadoVentoinha),
                              fontSize: 20,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_rounded,
                            color:
                                corIconeDispositivo(_estadoLampadaAquecimento),
                          ),
                          VerticalDivider(
                            width: 5,
                          ),
                          Text(
                            estadoDispositivo(_estadoLampadaAquecimento),
                            style: TextStyle(
                              color: corIconeDispositivo(
                                  _estadoLampadaAquecimento),
                              fontSize: 20,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                PainelMonitoramento(
                  icone: Icons.water_drop_rounded,
                  nomeVariavel: 'Umidade do Solo',
                  leituraVariavel: '$_valorUmidadeSolo%',
                  spMaxVariavel: '$umidadeSoloSPMax%',
                  spMinVariavel: '$umidadeSoloSPMin%',
                  corValorLeitura: corLeituraForaIntervalo(
                    _valorUmidadeSolo,
                    umidadeSoloSPMax,
                    umidadeSoloSPMin,
                  ),
                  piscarValorLeitura: piscarValorLeituraForaIntervalo(
                    _valorUmidadeSolo,
                    umidadeSoloSPMax,
                    umidadeSoloSPMin,
                  ),
                  dispositivo: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.shower_rounded,
                            color: corIconeDispositivo(_estadoIrrigacao),
                          ),
                          VerticalDivider(
                            width: 5,
                          ),
                          Text(
                            estadoDispositivo(_estadoIrrigacao),
                            style: TextStyle(
                              color: corIconeDispositivo(_estadoIrrigacao),
                              fontSize: 20,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PainelMonitoramento(
                  icone: Icons.light_mode_outlined,
                  nomeVariavel: 'Luminosidade',
                  leituraVariavel: '$_valorLuminosidade%',
                  spMaxVariavel: '$luminosidadeSPMax%',
                  spMinVariavel: '$luminosidadeSPMin%',
                  corValorLeitura: corLeituraForaIntervalo(
                    _valorLuminosidade,
                    luminosidadeSPMax,
                    luminosidadeSPMin,
                  ),
                  piscarValorLeitura: piscarValorLeituraForaIntervalo(
                    _valorLuminosidade,
                    luminosidadeSPMax,
                    luminosidadeSPMin,
                  ),
                ),
                PainelMonitoramento(
                  icone: Icons.ac_unit,
                  nomeVariavel: 'Umidade do Ar',
                  leituraVariavel: '$_valorUmidadeAr%',
                  spMaxVariavel: '$umidadeArSPMax%',
                  spMinVariavel: '$umidadeArSPMin%',
                  corValorLeitura: corLeituraForaIntervalo(
                    _valorUmidadeAr,
                    umidadeArSPMax,
                    umidadeArSPMin,
                  ),
                  piscarValorLeitura: piscarValorLeituraForaIntervalo(
                    _valorUmidadeAr,
                    umidadeArSPMax,
                    umidadeArSPMin,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class PainelMonitoramento extends StatefulWidget {
  IconData icone;
  String nomeVariavel;
  String leituraVariavel;
  String spMaxVariavel;
  String spMinVariavel;
  Color? corValorLeitura;
  List<Widget>? dispositivo;
  bool piscarValorLeitura;

  PainelMonitoramento({
    required this.icone,
    required this.nomeVariavel,
    required this.leituraVariavel,
    required this.spMaxVariavel,
    required this.spMinVariavel,
    required this.corValorLeitura,
    required this.piscarValorLeitura,
    this.dispositivo,
  });

  @override
  State<PainelMonitoramento> createState() => _PainelMonitoramentoState();
}

class _PainelMonitoramentoState extends State<PainelMonitoramento> {
  double _opacidadePisca = 1.0;
  double _opacidade = 1.0;

  @override
  void initState() {
    super.initState();
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _opacidadePisca = _opacidadePisca == 1.0 ? 0.0 : 1.0;
        });
      });
  }

  double PiscaValor(){
    if (widget.piscarValorLeitura == true){
      return _opacidadePisca;
    }
    else{
      return _opacidade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ]),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icone,
                  size: 25,
                ),
                Text(
                  '${widget.nomeVariavel}',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[700],
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedOpacity(
                  opacity: PiscaValor(),
                  duration: Duration(seconds: 1),
                  child: Text(
                    '${widget.leituraVariavel}',
                    style: TextStyle(
                      color: widget.corValorLeitura,
                      fontSize: 45,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[700],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Máx:\n${widget.spMaxVariavel}',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Outfit',
                        color: Colors.green[900],
                      ),
                    ),
                    Text(
                      'Min:\n${widget.spMinVariavel}',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Outfit',
                        color: Colors.red[900],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[700],
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: (widget.dispositivo ?? []),
            ),
          ),
        ],
      ),
    );
  }
}
