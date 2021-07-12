class Post {
  String userId;
  String name;
  String title;
  String content;

  Post(String userId, String title, String content, String name) {
    this.userId = userId;
    this.name = name;
    this.content = content;
    this.title = title;
  }

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'],
        title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'title': title,
        'content': content,
      };
}
