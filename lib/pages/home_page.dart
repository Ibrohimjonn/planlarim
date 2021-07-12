import 'package:flutter/material.dart';
import 'package:planlarim/model/post_model.dart';
import 'package:planlarim/pages/detail_page.dart';
import 'package:planlarim/services/auth_service.dart';
import 'package:planlarim/services/prefs_service.dart';
import 'package:planlarim/services/rtdb_service.dart';

class Home extends StatefulWidget {
  static final String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> items = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPost();
  }

  Future _openDetail() async{
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new Detail();
      }
    ));
    if(results != null && results.containsKey("data")){
      print(results['data']);
      _apiGetPost();
    }
  }

  _apiGetPost() async{
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id).then((posts) => {
      _respPosts(posts),
    });
  }

  _respPosts(List<Post> posts){
    setState(() {
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Posts'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return itemOfList(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  Widget itemOfList(Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            post.content,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            post.name,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
