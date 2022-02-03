import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/rtdb_service.dart';
import 'package:herewego/services/store_service.dart';
import 'package:image_picker/image_picker.dart';

class DetailPage extends StatefulWidget {
  static const String id = 'detail_page';
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        print('No image selected');
      }
    });

  }

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  _addPost() async{
    String firstName = firstNameController.text.toString().trim();
    String lastName = lastNameController.text.toString().trim();
    String content = contentController.text.toString().trim();
    String date = dateController.text.toString().trim();
    if(firstName.isEmpty || lastName.isEmpty || content.isEmpty || date.isEmpty) return;
    if(_image ==  null) return;

    _apiUploadImage(firstName, lastName, content, date);
  }

  void _apiUploadImage(String firstName, String lastName, String content, String date) {
    StoreService.uploadImage(_image!).then((img_url) =>
    {
      print(img_url),
      _apiAddPost(firstName, lastName, content, date, img_url ?? ""),
    });
  }

  _apiAddPost(String firstName, String lastName, String content, String date, String img_url) async {
    var id = await Prefs.loadUserId();
    print(id);
    RTDBService.addPost(Post(id!, firstName, lastName, content, date, img_url)).then((response) => {
      print(response),
      Navigator.pop(context),
      // _respAddPost(response),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Add Post"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            GestureDetector(
              onTap: (){
                _getImage();
              },
              child: Container(
                height: 100,
                width: 100,
                child: _image != null ? Image.file(_image!, fit: BoxFit.cover) : Image.asset('assets/images/camera.png'),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: 'Firstname',
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: 'Lastname',
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: 'Content',
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                hintText: 'Date',
              ),
            ),
            const SizedBox(height: 20),

            Container(
              color: Colors.deepOrange,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _addPost();
                },
                child: const Text('Add', style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
