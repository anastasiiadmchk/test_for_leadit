import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_for_leadit/data_receivers/comments_provider.dart';
import 'package:app_for_leadit/data_receivers/posts_provider.dart';
import 'package:app_for_leadit/data_receivers/users_provider.dart';
import 'package:app_for_leadit/json_decoders/post_info.dart';
import 'package:app_for_leadit/post/post_widget.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var postsList = Provider.of<PostsProvider>(context, listen: false);
    var commentsList = Provider.of<CommentsProvider>(context, listen: false);
    var usersList = Provider.of<UsersProvider>(context, listen: false);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Posts'),
            ),
            body: FutureBuilder(
                future: Future.wait([postsList.getAllPosts(), usersList.getAllUsers(), commentsList.getAllComments()]),
                builder: (context, snapshotPosts) {
                  if (snapshotPosts.hasError) print(snapshotPosts.error);

                  if (snapshotPosts.connectionState == ConnectionState.done &&
                      snapshotPosts.hasData) {
                    List<Post> _posts = snapshotPosts.data[0];
                    return ListView.builder(
                        cacheExtent: 50,
                        itemCount: _posts.length,
                        itemBuilder: (_, index) {
                          Post _post = _posts[index];

                          return PostWidget(
                            post: _post,
                            postCreator: snapshotPosts.data[1]
                                .firstWhere((user) => user.id == _post.userId),
                            comments: snapshotPosts.data[2]
                                .where(
                                    (comments) => comments.postId == _post.id)
                                .toList(),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
