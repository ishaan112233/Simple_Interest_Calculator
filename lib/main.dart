import "package:flutter/material.dart";
import 'package:flutter/services.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SI Calculator App",
      home: SIFORM(),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark
      ),
    )
  );
}
class SIFORM extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFORMState();
  }

}

class _SIFORMState extends State<SIFORM>{

  var _formKey = GlobalKey<FormState>();


  var _currencies = ["Rupees", "Dollar", "Other"];
  final _minPadding = 5.0;
  var _currentCurrency = '';

  @override
  void initState(){
    super.initState();
    _currentCurrency = _currencies[0];
  }
  var _displayResult="";
  TextEditingController principal = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController term = TextEditingController();
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
     TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
         padding: EdgeInsets.all(_minPadding*2) ,
        child: ListView(
          children: <Widget>[

           getImageAsset(),
           Padding(
           padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
           child:TextFormField(
             keyboardType: TextInputType.number,
             inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
             style: textStyle,
             controller: principal,
             validator: (String val){
               if (val.isEmpty){
                 return "Enter Amount";
               }
             },
             decoration: InputDecoration(
               labelText: 'Principal',
               hintText: 'Enter Principal Ammount Eg. 12000',
               labelStyle: textStyle,
               errorStyle: TextStyle(
                 color: Colors.redAccent,
                 fontSize: 12.0
               ),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10.0)
               )
             ),
           )),
            Padding(
              padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
              child:TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              style: textStyle,
              controller: rate,
              validator: (String val){
                if(val.isEmpty ){
                  return "Enter Value";
                }

              },
              decoration: InputDecoration(
                  labelText: 'Rate Of Interest',
                  hintText: 'Enter Rate Of Interest',
                  labelStyle: textStyle,
                  errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12.0
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  )
              ),
            )),
            Padding(
            padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
            child:Row(
              children: <Widget>[

                Expanded(
                  child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: term,
                  validator: (String val){
                    if(val.isEmpty){
                      return "Enter Value";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Term',
                      hintText: 'Term in Yrs',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                )),
                Container(width: _minPadding*5,),
                Expanded(
                  child:DropdownButton<String>(
                    items: _currencies.map((String val){
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                  }).toList(),
                    value: _currentCurrency,

                    onChanged: (String newVal){
                        _onSelectCurrency(newVal);
                    },
                ))

              ],
            )),
            Padding(
                padding: EdgeInsets.only(bottom: _minPadding, top: _minPadding),
                child: Row(children: <Widget>[

              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColorDark,
                  child: Text('Calculate', textScaleFactor: 1.5,),
                  onPressed: (){

                    setState(() {
                      if(_formKey.currentState.validate()) {
                        this._displayResult = _calculateSI();
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text('Reset', style: textStyle,),
                  onPressed: (){
                    setState(() {
                      _reset();
                    });
                  },
                ),
              )
            ],)),
          Padding(
            padding: EdgeInsets.all(_minPadding*2),
            child: Text(_displayResult, style: textStyle,),
          )
          ],
        )),
      ),
    );
  }
  Widget getImageAsset(){
    AssetImage asstImage = AssetImage("images/logo.png");
    Image image = Image(image: asstImage, width: 125.0, height: 125.0,);

    return Container(child: image, padding: EdgeInsets.all( _minPadding * 10 ),);
  }

  void _onSelectCurrency(String newVal){
     setState(() {
       this._currentCurrency = newVal;
     });
  }
  String _calculateSI(){
     double principal_val = double.parse(principal.text);
     double rate_val = double.parse(rate.text);
     double term_val = double.parse(term.text);

     double totalAmount = principal_val + (principal_val * rate_val * term_val)/100;

     String result = "After $term_val years, your investment will be $totalAmount";
     return result;
  }

  void _reset(){
     principal.text = '';
     rate.text = '';
     term.text = '';
     _displayResult = '';
     _currentCurrency = _currencies[0];
  }
}