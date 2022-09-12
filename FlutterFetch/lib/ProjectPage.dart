import 'package:flutter/material.dart';
import 'package:flutterfetch/ProjectManager.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Projects"),
        ),
        body: Consumer<ProjectManager>(
          builder: (context,provider,child){
            return provider.isLoading?
            Center(
                child: CircularProgressIndicator()
            ):
            ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index){
                return ProjectWidget(project: provider.projectList[index],);
              },
              itemCount: provider.projectList.length,
            );
          },
        ),
      ),
    );
  }
}


class Project{
  String image,heading,subText,slug,description;
  Project({
    required this.image,
    required this.heading,
    required this.subText,
    required this.slug,
    required this.description
  });
}
class ProjectWidget extends StatelessWidget {
  final Project project;
  const ProjectWidget({
    required this.project,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(
                "assets/logo2.png"
              ),
            ),
            SizedBox(height: 5,),
            Text(
                project.heading,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),
            ),
            SizedBox(height: 10,),
            Text(
              project.subText
            ),
            SizedBox(height: 10,),
            InkWell(

                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,width: 2),
                    borderRadius: BorderRadius.circular(3)
                  ),
                  child: Text(
                      "Read More",
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
