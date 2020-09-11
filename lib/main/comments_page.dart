import 'package:app_for_leadit/json_decoders/comment_info.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  final List<Comment> comments;

  const CommentsPage({Key key, this.comments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_circle),
                        SizedBox(width: 5),
                        Text(
                          comments[index].email,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(comments[index].body),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
