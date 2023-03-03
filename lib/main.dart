import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

void main() { 
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var weight_controller = TextEditingController();
  var height_controller = TextEditingController();
  dynamic bmi;
  var result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("BMI calculator"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  TextField(
                    controller: weight_controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter weight",
                      suffixText: "KG",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontStyle: FontStyle.italic
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
            
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: height_controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter height",
                      suffixText: "Feet.Inch",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontStyle: FontStyle.italic
                      ),
                      border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20)
                      )
                    ),
            
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: SizedBox(
                      width: 180,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: (){
                          var weight = double.parse(weight_controller.text);
                          dynamic height = height_controller.text;
                          height = height.split(".");
                          var feet = int.parse(height[0]);
                          var inch = 0;
                          if(height.length != 1){
                          inch = int.parse(height[1]);

                          }
                          var meter = double.parse(((feet * 30.48 + inch * 2.54) / 100).toStringAsFixed(4));
                          bmi = weight / (meter * meter);
                          bmi = double.parse(bmi.toStringAsFixed(1));
                          // normal : bmi from 18.5 to 25
                          // underweight : bmi below 18.5
                          // overweight : bmi from 25 to 30
                          // obesity : bmi greater than 30

                          if(bmi < 18.5){
                            result = "Underweight";
                          }
                          else if(bmi >= 18.5 && bmi <= 25){
                            result = "Normal";
                          }
                          else if(bmi > 25 && bmi <= 30){
                            result = "Overweight";
                          }
                          else{
                            result = "Obesity";
                          }
                          setState(() {
                            
                          });


                        }, 
                        child: Text("Calculate BMI", style: TextStyle(
                          fontSize: 20
                        ),)
                        
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Text("Your BMI is $bmi",  style: TextStyle(
                      fontSize: 20
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Text("You are $result",  style: TextStyle(
                      fontSize: 20
                    ),),
                  )
                ],
              ),
            ),
          ),
        )
        
        
        
    );
  }
}
