class Comment{
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment(this.email, this.name, this.id, this.body, this.postId);

  Comment.fromJson(Map<String, dynamic> json) :
  id = json['id'],
  postId = json['postId'],
  name = json['name'],
  body = json['body'],
  email = json['email'];

  Map<String, dynamic> toJson() =>
    {
      'id' : id,
      'postId' : postId,
      'body ' : body,
      'name' : name,
      'email' : email,
    };
}