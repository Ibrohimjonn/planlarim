import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planlarim/model/post_model.dart';
import 'package:planlarim/services/prefs_service.dart';
import 'package:planlarim/services/rtdb_service.dart';
import 'package:planlarim/services/store_service.dart';

class Detail extends StatefulWidget {

  static final String id = 'detail';

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var isLoading = false;
  File _image;
  final picker = ImagePicker();

  var nameController = TextEditingController();
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async{

    String name = nameController.text.toString();
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if(name.isEmpty || title.isEmpty || content.isEmpty) return;
    if(_image == null) return;

    _apiUploadImage(title,content,name);
  }

  void _apiUploadImage(String name, String content, String title) {
    setState(() {
      isLoading = true;
    });
    StoreService.uploadImage(_image).then((img_url) => {
      _apiAddPosts(name, content, title, img_url),
    });
  }

  _apiAddPosts(String name,String title,String content,String img_url)async{
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id,name,title,content,img_url)).then((response) => {
      _respAddPost(),
    });
  }

  _respAddPost(){
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data':'done'});
  }

  Future _getImage() async {
    final pickedFile = await picker .getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
      }else{
        print('no image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _getImage,
                    child: Container(
                      height: 300,
                      width: 150,
                      child: _image != null ?
                      Image.file(_image,fit: BoxFit.cover,) :
                      Image.asset("assets/images/insta.jpg"),
                    ),
                  ),

                  SizedBox(height: 15,),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "name",
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "title",
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: "date",
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.deepOrange,
                    ),
                    child: FlatButton(
                      onPressed: _addPost,
                      child: Text('Add',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),

          isLoading? Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      ),
    );
  }
}
