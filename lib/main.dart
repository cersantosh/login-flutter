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
  var color = Colors.yellow;
  var bmi_value = "";
  dynamic bmi;
  var result = "";
  var error_message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("BMI calculator"),
        ),
        body: Container(
          color: color,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            
                            if(weight_controller.text != "" && height_controller.text != ""){
                              error_message = "";
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
                            bmi_value = "Your BMI is $bmi";
                            // normal : bmi from 18.5 to 25
                            // underweight : bmi below 18.5
                            // overweight : bmi from 25 to 30
                            // obesity : bmi greater than 30
        
                            if(bmi < 18.5){
                              result = "Underweight";
                              color = Colors.blue;
                            }
                            else if(bmi >= 18.5 && bmi <= 25){
                              result = "Normal";
                              color = Colors.green;
                            }
                            else if(bmi > 25 && bmi <= 30){
                              result = "Overweight";
                              color = Colors.pink;
                            }
                            else{
                              result = "Obesity";
                              color = Colors.red;
                            }
                            result = "You are $result";

                            }
                            else{
                              error_message = "Please Fill all the fields";
                              bmi_value = "";
                              result = "";
                              color = Colors.yellow;
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
                      child: Text("$bmi_value",  style: TextStyle(
                        fontSize: 20
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: Text("$result",  style: TextStyle(
                        fontSize: 20
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: Text("$error_message",  style: TextStyle(
                        fontSize: 20
                      ),),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
        
        
        
    );
  }
}
