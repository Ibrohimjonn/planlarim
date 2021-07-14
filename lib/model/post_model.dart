class Post {
  String userId;
  String name;
  String title;
  String content;
  String img_url;

  Post(String userId, String title, String content, String name,
      String img_url) {
    this.userId = userId;
    this.name = name;
    this.content = content;
    this.title = title;
    this.img_url = img_url;
  }

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'],
        title = json['title'],
        content = json['content'],
        img_url = json['img_url'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'title': title,
        'content': content,
        'img_url': img_url,
      };
}
