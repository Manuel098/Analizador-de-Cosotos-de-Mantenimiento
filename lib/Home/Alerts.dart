import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'index.dart';

class NewAlerts{
  final GlobalKey<FormState> _linekey = GlobalKey<FormState>(), _moneykey = GlobalKey<FormState>();
  int _nL,_mL,_tL, _salario;
  double  _eI, _tD, _tCA, _eM, _cM;
  makeLines({BuildContext context,double eI, double tD})=>showDialog(context: context, builder: (context){
    _eI = eI;
    _tD = tD;
    return AlertDialog(
      elevation: 5.0,
      title: Text('Lineas de Codigo'),
      content: SingleChildScrollView(
        child: Form(
          key: _linekey,
          child: ListBody(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(labelText: "Nuevas líneas de código"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if(Validations().number(value: value)==0){
                    _nL = int.parse(value);
                    return null;
                  }else{
                    return Validations().number(value: value);
                  }
                },
              ),Divider(height: 20,indent: 500,endIndent: 500,),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Líneas de código modificadas"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if(Validations().number(value: value)==0){
                    _mL = int.parse(value);
                    return null;
                  }else{
                    return Validations().number(value: value);
                  }
                },
              ),Divider(height: 20,indent: 500,endIndent: 500,),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Total de líneas de código"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if(Validations().number(value: value)==0){
                    _tL = int.parse(value);
                    return null;
                  }else{
                    return Validations().number(value: value);
                  }
                },
              ),Divider(height: 20,indent: 500,endIndent: 500,),
            ],
          )
        )
      ),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text('Submit'),
          onPressed: (){
            if (_linekey.currentState.validate()) {
              _tCA=(_nL+_mL)/_tL;
              _eM=_tCA*_eI;
              print(_eM);
              Navigator.of(context).pop();
              makeSalario(context);
            }
          },
        )
      ],
    );
  });
  
  makeSalario(BuildContext context)=>showDialog(context: context, builder: (context){
    return AlertDialog(
      elevation: 5.0,
      title: Text('Salario'),
      content: SingleChildScrollView(
        child: Form(
          key: _moneykey,
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text('¿Cuál es el salario mensual del desarrollador?'),
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Salario"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if(Validations().number(value: value)==0){
                    _salario = int.parse(value);
                    return null;
                  }else{
                    return Validations().number(value: value);
                  }
                },
              ),Divider(height: 20,indent: 500,endIndent: 500,),
            ],
          )
        )
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text('Continuar'),
          onPressed: (){
            if (_moneykey.currentState.validate()) {
              
              _cM = _eM*_salario;
              Navigator.of(context).pop();
              resultado(context);
            }
          },
        )
      ],
    );
  });

  errorAlert(BuildContext context)=>showDialog(context: context, builder: (context){
    return AlertDialog(
      elevation: 5.0,
      title: Text('Error'),
      content: Text('Necesitas ingresar el tipo de proyecto'),
    );
  });
  resultado(BuildContext context)=>showDialog(context: context, builder: (context){
    return AlertDialog(
      elevation: 5.0,
      title: Text('Resultados'),
      content: Text('El salario mensual mensual es de \$ ${_cM} y es nesesario trabajar ${_eM} meses'),
    );
  });
}