import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'Alerts.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _type = ['Organico', 'Semi-acoplado', 'Acoplado'];
  int _kL = 0, _nL=0,_mL=0,_tL=0;
  double _eI = 0, _tD=0, _tCA=0, _eM=0, _cM=0;
  String _selectedType;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Costos de Mantenimiento'),
        backgroundColor: Colors.black54,
      ),
      body: Card(
        elevation: 12,
        margin: EdgeInsets.all(40),
        color: Colors.white70,
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).copyWith().size.width*0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(height: 25,indent: 500,endIndent: 500,),
                  Center(
                    child: Text('Lineas de codigo en miles', style: TextStyle(fontSize: 18)),
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(icon: Icon(Icons.airplay), labelText: "Líneas de código del repositorio"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if(Validations().number(value: value)==0){
                        _kL = int.parse(value);
                        return null;
                      }else{
                        return Validations().number(value: value);
                      }
                    },
                  ),Divider(height: 50,indent: 500,endIndent: 500,),
                  Center(
                    child: Text('Tipo de Proyecto', style: TextStyle(fontSize: 18)),
                  ),
                  Center(
                    child: DropdownButton<String>(
                      hint: Text('Ingrese el tipo de proyecto'),
                      value: _selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedType = newValue;
                        });
                      },
                      items: _type.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  new Divider(height: 35,indent: 500,endIndent: 500,),
                ],
              ),
            )
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RaisedButton(
        color: Colors.black54,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)
        ),
        textColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            'Continuar',
            style: TextStyle(fontSize: 20)
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            switch (_selectedType) {
              case 'Organico':
                _eI = Validations().monthMan(a:3.2, b: 1.05, klocs: _kL);
                _tD = Validations().timeDev(c:2.5, d: 0.38, eI: _eI);
                NewAlerts().makeLines(context: context, eI: _eI, tD: _tD);
                break;
              case 'Semi-acoplado':
                _eI = Validations().monthMan(a:3.0, b: 1.12, klocs: _kL);
                _tD = Validations().timeDev(c:2.5, d: 0.35, eI: _eI);
                NewAlerts().makeLines(context: context, eI: _eI, tD: _tD);
                break;
              case 'Acoplado':
                _eI = Validations().monthMan(a:2.8, b: 1.2, klocs: _kL);
                _tD = Validations().timeDev(c:2.5, d: 0.32, eI: _eI);
                NewAlerts().makeLines(context: context, eI: _eI, tD: _tD);
                break;
              default:
                NewAlerts().errorAlert(context);
                break;
            }
          }
        },
        elevation: 12,
      ),
    );
  }
}

class Validations{
  number({String value}){
    if (value.isEmpty) {
      return 'Por favor no deje el campo vacío';
    }else{
      try {
        int asd =int.parse(value);
        if(asd>0){
          return 0;
        }else{
          return 'Por favor ingrese un numero positivo';  
        }
      } catch (e) {
        return 'Por favor ingrese un numero';
      }
    }
  }
  
  monthMan({double a, int klocs, double b}) => (a * pow(klocs, b));
  
  timeDev({double c, double eI,double d})=> (c * pow(eI, d));
}
