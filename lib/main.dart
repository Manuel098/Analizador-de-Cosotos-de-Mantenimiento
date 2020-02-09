import 'package:flutter/material.dart';
import 'Home/index.dart' as Home; 
void main() => runApp(MaterialApp(
  title: 'Costos de Mantenimiento',
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/':(context)=> Home.Index()
  },
));
 