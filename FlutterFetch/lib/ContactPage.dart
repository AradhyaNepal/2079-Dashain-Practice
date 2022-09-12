import 'package:flutter/material.dart';
import 'package:flutterfetch/contact_manager.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contact"),
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.2),
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "EcoHot Reneable Energy Pvt",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height:100,
                  width: 150,

                  child: Image.asset(
                      "assets/logo2.png",
                    fit: BoxFit.cover,
                  ),
                ),
                TopContact(),
                SizedBox(height: 10,),
                BottomView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomView extends StatefulWidget {
  const BottomView({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  String name="",email="",phone="",message="";
  bool isLoading=false;
  final GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
                "Get in Touch",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 25
              ),

            ),
            Form(
              key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    TextFormField(
                        textInputAction:TextInputAction.next,
                      onSaved: (value)=>name=value??"",
                      validator: (value){
                          if(value!.isEmpty) return "Please Enter Name";
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Name",
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red,),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red,),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2,color: Colors.red),

                        )
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      textInputAction:TextInputAction.next,
                      onSaved: (value)=>email=value??"",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty) return "Please Enter Email";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red,),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red,),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red),

                          )
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      textInputAction:TextInputAction.next,
                      onSaved: (value)=>phone=value??"",
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(value!.isEmpty) return "Please Enter Number";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Number",
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red,),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red,),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red),

                          )
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      onSaved: (value)=>message=value??"",
                      textInputAction:TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      validator: (value){
                        if(value!.isEmpty) return "Please Enter Message";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Message",
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red,),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red,),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 2,color: Colors.red),

                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    isLoading?CircularProgressIndicator():SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async{
                            if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                              setState(() {
                                isLoading=true;
                              });

                              await ContactManager.postMessage(name: name, email: email, phone: phone, message: message).then((value){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Message Sended")));
                              }).onError((error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
                              });
                              setState(() {
                                isLoading=false;
                              });
                            }
                          },
                          child: Text("Submit")
                      ),
                    )
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}

class TopContact extends StatelessWidget {
  const TopContact({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Text(
                "Head Office",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 25
              ),
            ),
            Text(
                "Echo Hot Industries Pvt. Ltd.",
              style: TextStyle(
                  fontSize: 17.5
              ),
            ),
            Text(
                "Tel: +977-9849502623",
              style: TextStyle(
                  fontSize: 17.5
              ),
            ),
            Row(
              children: [
                Text(
                  "Email:",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20
                  ),
                ),
                Text(
                    "ecohotnepal@gmail.com",
                  style: TextStyle(
                      fontSize: 17.5
                  ),
                )
              ],
            ),
            SizedBox(height: 15,),//Spacing
            Text(
                "Field Office",
              style: TextStyle(
                color: Colors.red,
                fontSize: 25
              ),
            ),
            Text(
                "Sukedhara-04, Kathmandu",
              style: TextStyle(
                  fontSize: 17.5
              ),
            ),
            SizedBox(height: 15,),//Spacing
            Text(
              "Customer Support",
              style: TextStyle(
                fontSize: 25,
                color: Colors.red
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  "Tel:",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20
                  ),
                ),
                Text(
                  "\t+977-9849502623",
                  style: TextStyle(
                      fontSize: 17.5
                  ),
                )
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text(
                  "Mail",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red
                  ),
                ),
                Text(
                    "\tecohotnepal@gmail.com",
                  style: TextStyle(
                      fontSize: 17.5
                  ),
                )
              ],
            ),


          ],
        ),
      ),
    );
  }
}
