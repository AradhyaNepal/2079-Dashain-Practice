import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Expanded(
                  child: Image.asset("assets/logo.png")
              ),
              SizedBox(height: 10,),
              Container(
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                ),
                child: Center(
                  child: Text(
                    "Web Hosting",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide( color: Colors.grey,width: 2),
                    right: BorderSide(color: Colors.grey,width: 2),
                  ),
                ),

                child: Column(
                  children: [

                    RowWidget(heading:"Unmetered" ,subHeading: "Bandwidth (Unlimited)",),
                    RowWidget(heading:"cPanel" ,subHeading: "With 100% Uptime",),
                    RowWidget(heading:"20" ,subHeading: "eMail Accounts",),
                    RowWidget(heading:"Auto" ,subHeading: "Backups",),
                    Divider(thickness: 2,color: Colors.grey,),
                    Text(
                      "20 GB Web Space",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Nrs. 6000/Year",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.red
                      ),
                    ),
                    SizedBox(height: 5,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor:Colors.blue ),
                      onPressed: (){},
                      child: Text(
                          "Order Now"
                      ),
                    ),
                    Divider(thickness: 2,color: Colors.grey,),
                    RowWidget(heading:"Free SSL" ,subHeading: "Free SSL",),
                    RowWidget(heading:"24/7" ,subHeading: "Live Support",),
                    RowWidget(heading:"Cloud" ,subHeading: "Storage",),
                    RowWidget(heading:"2 weeks" ,subHeading: "Two times auto backup",),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor:Colors.grey ),
                        onPressed: (){},
                        child: Text(
                            "See More Features"
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                height: 2,
                width: double.infinity,
              )


            ],
          ),
        ),
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  final String heading,subHeading;
  const RowWidget({
    required this.heading,
    required this.subHeading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/tick.png"
            ),
            SizedBox(width: 10,),
            Text(
              heading,
              style: TextStyle(
                fontSize: 17.5,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(width: 10,),

            Text(
                subHeading,
              style: TextStyle(
                  fontSize: 17.5,
              ),
            )
          ],
        ),
        SizedBox(height: 8,)
      ],
    );
  }
}
