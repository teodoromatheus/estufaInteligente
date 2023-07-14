import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class SetPointPage extends StatefulWidget {
  String tipoVariavel;
  SetPointPage({required this.tipoVariavel});

  @override
  State<SetPointPage> createState() => _SetPointPageState();
}

class _SetPointPageState extends State<SetPointPage> {
  late final DatabaseReference _spMaxLuminosidadeRef;
  late final DatabaseReference _spMinLuminosidadeRef;
  late final DatabaseReference _spMaxTemperaturaRef;
  late final DatabaseReference _spMinTemperaturaRef;
  late final DatabaseReference _spMaxUmidadeSoloRef;
  late final DatabaseReference _spMinUmidadeSoloRef;
  late final DatabaseReference _spMaxUmidadeArRef;
  late final DatabaseReference _spMinUmidadeArRef;

  int valorSPMax = 0;
  int valorSPMin = 0;

  TextEditingController controllerMax = TextEditingController();
  TextEditingController controllerMin = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _spMaxLuminosidadeRef = FirebaseDatabase.instance.ref('spMaxLuminosidade');
    _spMinLuminosidadeRef = FirebaseDatabase.instance.ref('spMinLuminosidade');
    _spMaxTemperaturaRef = FirebaseDatabase.instance.ref('spMaxTemperatura');
    _spMinTemperaturaRef = FirebaseDatabase.instance.ref('spMinTemperatura');
    _spMaxUmidadeSoloRef = FirebaseDatabase.instance.ref('spMaxUmidadeSolo');
    _spMinUmidadeSoloRef = FirebaseDatabase.instance.ref('spMinUmidadeSolo');
    _spMaxUmidadeArRef = FirebaseDatabase.instance.ref('spMaxUmidadeAr');
    _spMinUmidadeArRef = FirebaseDatabase.instance.ref('spMinUmidadeAr');
  }

  atualizaFirebase() async {
    valorSPMax = int.parse(controllerMax.text);
    valorSPMin = int.parse(controllerMin.text);
    if (widget.tipoVariavel == 'Luminosidade') {
      await _spMaxLuminosidadeRef.set(valorSPMax);
      await _spMinLuminosidadeRef.set(valorSPMin);
    } else if (widget.tipoVariavel == 'Temperatura') {
      await _spMaxTemperaturaRef.set(valorSPMax);
      await _spMinTemperaturaRef.set(valorSPMin);
    } else if (widget.tipoVariavel == 'Umidade do Solo') {
      await _spMaxUmidadeSoloRef.set(valorSPMax);
      await _spMinUmidadeSoloRef.set(valorSPMin);
    } else if (widget.tipoVariavel == 'Umidade do Ar') {
      await _spMinUmidadeArRef.set(valorSPMin);
      await _spMaxUmidadeArRef.set(valorSPMax);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Valores salvos!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _salvarForm() {
    if (int.tryParse(controllerMin.text) == null) {
      debugPrint('min não conforme');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ERRO! Valores não numéricos.',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          backgroundColor: Colors.red,
        ),
      );
    } else if (int.tryParse(controllerMax.text) == null) {
      debugPrint('max não conforme');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ERRO! Valores não numéricos.',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (int.parse(controllerMin.text) >= int.parse(controllerMax.text)) {
      debugPrint('entrei no erro maior/menor');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ERRO! SetPoint máximo deve ser maior que SetPoint mínimo',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else{
      debugPrint('Atualizei os dados');
      atualizaFirebase();
    }
  }

  @override
  void dispose() {
    controllerMax.dispose();
    controllerMin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Estufa Inteligente ',
              style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.eco_outlined,
              color: Colors.white,
              size: 35,
            )
          ],
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Definir SetPoint ${widget.tipoVariavel}',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Outfit',
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: TextFormField(
                      controller: controllerMax,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: 'Digite o SetPoint Max',
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Outfit',
                              color: Colors.grey[700])),
                    ),
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.02,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: TextFormField(
                      controller: controllerMin,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: 'Digite o SetPoint Min',
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Outfit',
                              color: Colors.grey[700])),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BotaoSetPointPage(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        funcaoBotao: 'Cancelar'),
                    BotaoSetPointPage(
                      onPressed: () {
                        _salvarForm();
                      },
                      funcaoBotao: 'Salvar',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BotaoSetPointPage extends StatelessWidget {
  VoidCallback onPressed;
  String funcaoBotao;

  BotaoSetPointPage(
      {Key? key, required this.onPressed, required this.funcaoBotao});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                '$funcaoBotao',
                style: TextStyle(
                    fontSize: 25, fontFamily: 'Outfit', color: Colors.white),
              ),
            ),
          ),
          color: Colors.green,
        ),
      ),
    );
  }
}
