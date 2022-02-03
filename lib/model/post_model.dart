
class Post{
  String userId;
  String firstName;
  String lastName;
  String content;
  String date;
  String img_url;

  Post(this.userId, this.img_url, this.firstName, this.lastName, this.content, this.date);

  Post.fromJson(Map<String, dynamic> json)
    : userId = json['userId'],
      img_url = json['img_url'] ?? '',
      firstName = json['firstName'],
      lastName = json['lastName'],
      content = json['content'],
      date = json['date'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'img_url': img_url,
    'firstName': firstName,
    'lastName': lastName,
    'content': content,
    'date': date
  };
}