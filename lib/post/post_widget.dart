import 'package:app_for_leadit/json_decoders/comment_info.dart';
import 'package:app_for_leadit/json_decoders/post_info.dart';
import 'package:app_for_leadit/json_decoders/user_info.dart';
import 'package:app_for_leadit/main/comments_page.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final User postCreator;
  final List<Comment> comments;

  const PostWidget({Key key, this.post, this.postCreator, this.comments})
      : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        elevation: 8,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(
                Icons.account_circle,
                color: Colors.black54,
              ),
              SizedBox(width: 5),
              Text(widget.postCreator.username,
                  style: TextStyle(fontWeight: FontWeight.w700))
            ]),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.post.title,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              child: Text(widget.post.body),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.black54,
                      size: 14,
                    ),
                    onTap: _openComments,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.comments.length.toString(),
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  _openComments() async {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CommentsPage(
                    comments: widget.comments,
                  )));
    });
  }
}
