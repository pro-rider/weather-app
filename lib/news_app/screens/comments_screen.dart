import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_page/news_app/widgets/comment_item.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Faker faker = Faker();
  final GlobalKey _inputKey = GlobalKey();


  List<Map<String, dynamic>> comments = [];
  int? replyingToIndex;
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? commentsJson = prefs.getString('comments');

    if (commentsJson != null) {
      final List<dynamic> decoded = jsonDecode(commentsJson);
      setState(() {
        comments = decoded.cast<Map<String, dynamic>>();
      });
    } else {
      comments = List.generate(5, (index) {
        return {
          'username': faker.person.name(),
          'avatar': 'assets/placeholders/avatar.jpg',
          'comment': faker.lorem.sentence(),
          'replies': <Map<String, String>>[],
          'liked': false,
        };
      });
      _saveComments();
    }
  }

  Future<void> _saveComments() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(comments);
    await prefs.setString('comments', encoded);
  }

  void _sendComment() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (editingIndex != null) {
        comments[editingIndex!]['comment'] = text;
        editingIndex = null;
      } else if (replyingToIndex != null) {
        comments[replyingToIndex!]['replies'].add({
          'username': 'You',
          'comment': text,
        });
        replyingToIndex = null;
      } else {
        comments.add({
          'username': 'You',
          'avatar': 'assets/placeholders/avatar.jpg',
          'comment': text,
          'replies': [],
          'liked': false,
        });
      }
      _controller.clear();
      _saveComments();
    });
  }

  void _startReplying(int index) {
    setState(() {
      replyingToIndex = index;
      editingIndex = null;
      _controller.text = '@${comments[index]['username']} ';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
    _focusNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        context,
        alignment: 1.0,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  void _startEditing(int index) {
    setState(() {
      editingIndex = index;
      replyingToIndex = null;
      _controller.text = comments[index]['comment'];
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
    _focusNode.requestFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        context,
        alignment: 1.0, // Bottom of the screen
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  void _toggleLike(int index) {
    setState(() {
      comments[index]['liked'] = !comments[index]['liked'];
    });
    _saveComments();
  }

  void _deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
    });
    _saveComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) => CommentItem(
                username: comments[index]['username'],
                avatar: comments[index]['avatar'],
                comment: comments[index]['comment'],
                replies: comments[index]['replies'],
                isLiked: comments[index]['liked'],
                onReply: () => _startReplying(index),
                onEdit: () => _startEditing(index),
                onDelete: () => _deleteComment(index),
                onLikeToggle: () => _toggleLike(index), onAvatarTap: () {  },
                
              ),
            ),
          ),
          if (replyingToIndex != null || editingIndex != null)
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Text(
                    editingIndex != null
                        ? 'Editing your comment'
                        : 'Replying to ${comments[replyingToIndex!]['username']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        replyingToIndex = null;
                        editingIndex = null;
                        _controller.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          // Input Area
          Padding(
            key: _inputKey,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: editingIndex != null
                          ? 'Edit your comment...'
                          : replyingToIndex != null
                              ? 'Write your reply...'
                              : 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: replyingToIndex != null || editingIndex != null,
                      fillColor: replyingToIndex != null || editingIndex != null
                          ? Colors.blue[50]
                          : null,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}