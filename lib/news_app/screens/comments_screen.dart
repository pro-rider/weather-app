// comments_screen.dart
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:simple_page/news_app/widgets/comment_item.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final comments = List.generate(
        5,
        (index) => {
              'username': faker.person.name(),
              'avatar': 'assets/placeholders/avatar.jpg',
              'comment': faker.lorem.sentence(),
            });

    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) => CommentItem(
              username: comments[index]['username']!,
              avatar: comments[index]['avatar']!,
              comment: comments[index]['comment']!,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Colors.blue),
              onPressed: () {},
            ),
          ]),
        ),
      ]),
    );
  }
}
