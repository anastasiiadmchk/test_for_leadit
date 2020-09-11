import 'package:app_for_leadit/data_receivers/comments_receiver.dart';
import 'package:app_for_leadit/data_receivers/posts_list_receiver.dart';
import 'package:app_for_leadit/data_receivers/user_receiver.dart';
import 'package:app_for_leadit/json_decoders/post_info.dart';
import 'package:app_for_leadit/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final futurePosts = useMemoized(() => PostsList().postsList);
    final futureUsers = useMemoized(() => UserReceiver().getUsers());
    final futureComments = useMemoized(() => CommentsReceiver().getComments());

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Posts'),
            ),
            body: FutureBuilder(
                future: Future.wait([futurePosts, futureUsers, futureComments]),
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
