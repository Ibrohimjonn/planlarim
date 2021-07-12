import 'package:flutter/material.dart';
import 'package:planlarim/model/post_model.dart';
import 'package:planlarim/services/prefs_service.dart';
import 'package:planlarim/services/rtdb_service.dart';

class Detail extends StatefulWidget {

  static final String id = 'detail';

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  var nameController = TextEditingController();
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async{

    String name = nameController.text.toString();
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if(name.isEmpty || title.isEmpty || content.isEmpty) return;
    _apiAddPosts(name,title,content);
  }

  _apiAddPosts(String name,String title,String content)async{
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id,name,title,content)).then((response) => {
      _respAddPost(),
    });
  }

  _respAddPost(){
    Navigator.of(context).pop({'data':'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
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
                  hintText: "content",
                ),
              ),

              SizedBox(height: 20,),

              Container(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  onPressed: _addPost,
                  color: Colors.blue,
                  child: Text('Add',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
