import 'package:flutter/material.dart';
import 'package:practice/screens/drop_down/backend/dropdown_provider.dart';
import 'package:provider/provider.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({Key? key}) : super(key: key);

  @override
  State<DropDownPage> createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  int selectedPrvValue=1;
  int districtId=1;
  
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child:Consumer<DropDownProvider>(
            builder: (context,provider,child) {
              return provider.isLoading?
              Center(
                child: CircularProgressIndicator(),
              ):
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    hint: Text(provider.provinceList.firstWhere((element) => element.id==selectedPrvValue).name),
                      items: provider.provinceList.map((e) =>  DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name)
                      )).toList(),
                      onChanged: (valueOf){
                        selectedPrvValue=valueOf??0;
                        setState(() {

                        });
                      }
                  ),
                  SizedBox(height: 10,),
                  DropdownButton(
                      hint: Text(provider.districtList.firstWhere((element) => element.id==districtId).name),
                      items: provider.districtList.where((element) =>element.provinceId==selectedPrvValue).map((e) =>  DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name)
                      )).toList(),
                      onChanged: (value){
                        districtId=value??0;
                        setState(() {

                        });
                      }
                  ),

                  SizedBox(height: 10,),
                  Text(
                    "District Id $districtId"
                  )
                ],
              );
            }
          ) ,
        ),
      ),
    );
  }

}
