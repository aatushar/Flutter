import 'package:api_consume/controllers/subject_contoller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SubjectListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subject List'),
      ),
      body: Consumer<SubjectController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage));
          }

          return ListView.builder(
            itemCount: controller.subjects.length,
            itemBuilder: (context, index) {
              final subject = controller.subjects[index];
              return Card(
                child: ListTile(
                  leading: Image.network(subject.image),
                  title: Text(subject.subjectName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
