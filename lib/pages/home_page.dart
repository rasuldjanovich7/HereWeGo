import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/sign_in_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/rtdb_service.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPosts();
  }

  _openDetails(){
    Navigator.pushNamed(context, DetailPage.id);
  }

  _apiGetPosts() async {
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id!).then((response) => {
      _respPosts(response),
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
        title: const Text('All Posts'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AuthService.signOutUser(context);
                Navigator.pushReplacementNamed(context, SignIn.id);
              },
              icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i){
          return itemsOfList(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _openDetails();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  
  Widget itemsOfList(Post post){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: post.img_url != null ?
              Image.network(post.img_url, fit: BoxFit.cover,) :
              Image.asset('assets/images/default.png'),
          ),
          const SizedBox(height: 10),
          Text(post.lastName + " " + post.firstName, style: const TextStyle(color: Colors.black, fontSize: 20),),
          const SizedBox(height: 10),
          Text(post.date, style: TextStyle(color: Colors.grey.shade700, fontSize: 16),),
          const SizedBox(height: 10),
          Text(post.content, style: TextStyle(color: Colors.grey.shade700, fontSize: 16),)
        ],
      ),
    );
  }
  
}
