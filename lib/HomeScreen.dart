import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}
class _HomeScreenState extends State<HomeScreen>{
  bool isloading =true;
  
  var _intialV1="en";
  var _intialV2="ar";
  final textSentenceController=TextEditingController();
  final textKeyController=TextEditingController();
   String translated="";
  bool connectedSuccess=false;
   final Map<dynamic,dynamic> listOfLang={};
   final listed=["am","da"];
  bool intilized=false;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
  
  }
  void submited()async {
    if (listOfLang.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Check your Internet Connection"),duration: Duration(seconds: 2),));
      return;
    }
    else if (textSentenceController.text.isEmpty || textKeyController.text.isEmpty){
        const SnackBar(content: Text("Empty Input"),duration: Duration(seconds: 2),);


    }
    else if (!listOfLang.keys.contains(textKeyController.text)){
        const SnackBar(content: Text("Invalid Key"),duration: Duration(seconds: 2),);

    }
    else {
      final url =Uri.tryParse("https://text-translator2.p.rapidapi.com/translate"
      );
      final  response =await http.post(url!,
      body: {"source_language": "en",
      "target_language": textKeyController.text,
      "text": textSentenceController.text},
      headers: {
	"content-type": "application/x-www-form-urlencoded",
	"X-RapidAPI-Key": "b208eec911mshcf2bbc911339699p19588cjsn4fa2db4a3d06",
	"X-RapidAPI-Host": "text-translator2.p.rapidapi.com"
});
  if (response.statusCode==200){
    final dynamic data=jsonDecode(response.body);

    setState(() {
         translated=data["data"]["translatedText"];

    });

  }
 
    }
    
  }
  void collectingData() async{
    final url =Uri.tryParse("https://text-translator2.p.rapidapi.com/getLanguages");
    final response = await http.get(url!,headers: {"X-RapidAPI-Key": "b208eec911mshcf2bbc911339699p19588cjsn4fa2db4a3d06",
	"X-RapidAPI-Host": "text-translator2.p.rapidapi.com"
    });
    if (response.statusCode!=200){
      return;
    }
    final data=jsonDecode(response.body);
    final list=data["data"]["languages"];
    setState(() {
       for (int i =0;i<list.length;i++){
        listOfLang[data["data"]["languages"][i]["code"].toString()]=data["data"]["languages"][i]["name"].toString();
    }
    });
   
  
  }
  @override
  Widget build(BuildContext context)   {
    
    if (intilized==false) {
      setState(() {
            collectingData();
      intilized=true;
      });
  
    }
    // TODO: implement build
    return Scaffold(
      
      resizeToAvoidBottomInset : false,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 209, 205),
        title:  Center(
          child:Text("English Translator App",
          style: GoogleFonts.lato(
            fontSize: 32,
            color: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.bold
          ),),),
        
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.1)
          ]
          )
        ),
        child: Column(
            children: [
              InkWell(
                onTap: submited,
                child: Image.asset("assets/images/one.webp",
                scale: 1.6,
                )),
              Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 208, 208),
                  borderRadius: BorderRadius.circular(15)
                ),
                child:   Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 50,
                        controller: textSentenceController,
                        decoration: InputDecoration(
                          label: Text("Enter Your Sentence",
                          style: GoogleFonts.lato(
                            fontSize: 18
                          ),)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: TextField(
                        controller: textKeyController,
                        maxLength: 3,
                        decoration: InputDecoration(
                          
                          label: Text("Enter Language key",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                          ),)
                        ),
                      ),),
                    
                  ],
                )
                    
                  ),
               
              
              Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 208, 208),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(child:  Text(translated.isEmpty?"empty":translated)),
              )
            ],
      
        ),
      ),
    );
  }

}