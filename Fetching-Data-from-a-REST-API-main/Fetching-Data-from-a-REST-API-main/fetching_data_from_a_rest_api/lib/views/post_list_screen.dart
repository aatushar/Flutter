import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';

class PostListScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: postController.postList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(postController.postList[index].title),
                subtitle: Text(postController.postList[index].body),
              );
            },
          );
        }
      }),
    );
  }
}
