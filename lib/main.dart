import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:powers/powers.dart';
// import 'package:sd_calculator/equations.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey();

  

String _measures='';
List<double> measuresList = [];
double sum = 0;
double moy;
double med;
double measureindex;
double measureindexplus;
double sd;
double variance;
double sampleVariance;
double sampleSd;
List<double> makam = [];
bool vrai = false;
// external num pow(num x, num exponent);
// bool get isEven;

bool isEven(num n) {
  return n % 2 == 0;
}



 double _moy(){
   setState(() {
     moy = (measuresList.reduce((a, b) => a + b))/measuresList.length;
   });
   return moy; 
}

 double _med(){
   setState(() {
   measureindex = measuresList[((measuresList.length/2)-1).toInt()];
   measureindexplus = measuresList[((measuresList.length/2)).toInt()];
   med = isEven(measuresList.length) ? (measureindex + measureindexplus)/2 : measureindexplus;
   });
   return med; 
}

List _makam() {
setState(() {
  makam = [];
  measuresList.map((e) => makam.add((e-moy).squared())).toList();
});
return makam;
}

double _variance (){
  setState(() {
    variance = (makam.fold(0,(a, b) => a + b))/measuresList.length;
  });
  return variance;
}

double _sd (){
  setState(() {
    sd = sqrt(variance);
  });
  return sd;
}

double _sampleVariance (){
  setState(() {
    sampleVariance = (makam.fold(0,(a, b) => a + b))/(measuresList.length-1);
  });
  return sampleVariance;
}

double _sampleSd () {
  setState(() {
    sampleSd = sqrt(sampleVariance);
  });
  return sampleSd;
}

void results(String input){
  setState(() {
  _measures = input;
  measuresList = _measures.trim().split(" ").map((e) => double.parse(e)).toList();
  });
  _moy();
  _med();
  _makam();
  _variance();
  _sd();
  _sampleVariance();
  _sampleSd();
  // print(makam);                                         
}

// void  _vrai (double input){
//   if((input-moy)<(input-med)){
//     setState(() {
//       vrai=true;
//     });
//   }else {
//     vrai = false;
//   }
// }


Widget getTextWidgets(var measures)
  {
    return Text(measures);
  }

  @override
  Widget build(BuildContext context) {
    // print(_makam());
    return Scaffold(
      appBar: AppBar(
        title:Text('analytical chemistry calculator'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Form(
                key: _formKey,
                child:Column(children: [
                  Padding(
                  padding: const EdgeInsets.symmetric(vertical:20),
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style:TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Measures',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    validator: (input){
                      if(input.trim().isEmpty) {
                     return 'Please enter a measure';
                     }else if (input.trim().contains(',') || input.trim().contains(',')){
                    return "','  and  '-' characters aren't allowed khaye";  
                     }
                     },
                    onSaved:(input) => results(input),
                    // initialValue: _measures,
                  ),
                ),
                RaisedButton(onPressed: (){
                  if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  }
                  FocusScopeNode currentFocus = FocusScope.of(context);
                   if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                 }
                },
                color: Colors.blue,
                child: Text('Results',style: TextStyle(color: Colors.white),),
                )
                ],)
                ),
            ),
          ),
          SizedBox(height: 30,),
          Center(
            child: Container(
                width: 70,
                height: 70,
                child: Center(child: measuresList.length != null ? Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Text('n: ',style: TextStyle(fontWeight: FontWeight.bold),),Text('${measuresList.length.toString()}',)],)  : Text('n: 0'),),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                  border:Border.all(width: 1,color: Colors.grey[600]),
                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),offset: Offset(1,1))]
                ),
              ),
          ),
            SizedBox(height: 15,),
          Container(
          // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              width: 130,
              height: 130,
              child: Center(child: moy != null ? Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Text('Moy: ',style: TextStyle(fontWeight: FontWeight.bold),),Text('${moy.toString()}')],)  : Text('Moy: 0'),),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8),
                border:Border.all(width: 1,color: Colors.grey[600]),
                boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),offset: Offset(1,1))]
              ),
            ),
            SizedBox(width: 15,),
            Container(
              width: 130,
              height: 130,
              child: Center(child: med != null ? Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Text('Med: ',style: TextStyle(fontWeight: FontWeight.bold),),Text('${med.toString()}')],)  : Text('Med: 0'),),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8),
                border:Border.all(width: 1,color: Colors.grey[600]),
                boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2),offset: Offset(1,1))]
              ),
            ),
          ],) ,),
          SizedBox(height: 30,),
          Container(child:Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('POPULATION',
                style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.blue),),
              ),
              Expanded(child: Divider(height: 50,))
            ],
          ) ,),
           Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: sd != null ? Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Text('Standard Deviation: ',style: TextStyle(fontWeight: FontWeight.bold),),Text('$sd')],) : Text('Standard deviation: 0'),
              ),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:Border.all(width: 1,color: Colors.grey[600])
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: variance != null ? Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Text('Variance: ',style: TextStyle(fontWeight: FontWeight.bold),),Text('$variance')],) : Text('variance: 0') ,
              ),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:Border.all(width: 1,color: Colors.grey[600])
              ),
            ),
          ],) ,),
           SizedBox(height: 30,),
          Container(child:Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('SAMPLE',
                style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.blue
                ),
                ),
              ),
              Expanded(child: Divider(height: 50,))
            ],
          ) ,),
           Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: sampleSd != null ?  Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Text('Standard Deviation: ',style: TextStyle(fontWeight: FontWeight.bold),),Text('$sampleSd')],) : Text('Standard deviation: 0') ,
              ),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:Border.all(width: 1,color: Colors.grey[600])
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: sampleVariance != null ?  Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Text('Variance: ',style: TextStyle(fontWeight: FontWeight.bold),),Text('$sampleVariance')],): Text('variance: 0'),
              ),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:Border.all(width: 1,color: Colors.grey[600])
              ),
            ),
          ],) ,),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
}
