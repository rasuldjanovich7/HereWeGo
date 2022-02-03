import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego/model/post_model.dart';

class RTDBService{
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(Post post) async {
    _database.child('posts').push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> getPosts(String id) async {
    List<Post> items = [];
    Query _query = _database.ref.child("posts").orderByChild("userId").equalTo(id);
    DatabaseEvent snapshot = await _query.once();
    var result = snapshot.snapshot.children;

    for(var item in result) {
      debugPrint(item.value.toString());
      items.add(Post.fromJson(Map<String, dynamic>.from(item.value as Map)));

      print(items);
      // items.add(Post());
    }
    return items;
  }

}
