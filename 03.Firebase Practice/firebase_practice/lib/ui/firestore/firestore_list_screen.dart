import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final CollectionReference<Map<String, dynamic>> posts = FirebaseFirestore
      .instance
      .collection('posts');

  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Opens the form for adding or editing a post.
  Future<void> showPostDialog({
    String? documentId,
    String? oldTitle,
    String? oldDescription,
  }) async {
    final titleController = TextEditingController(text: oldTitle ?? '');

    final descriptionController = TextEditingController(
      text: oldDescription ?? '',
    );

    final isEditing = documentId != null;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        bool isSaving = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Update Post' : 'Add Post'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSaving
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () async {
                          final title = titleController.text.trim();
                          final description = descriptionController.text.trim();

                          if (title.isEmpty || description.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter both title and description.',
                                ),
                              ),
                            );
                            return;
                          }

                          if (currentUser == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please log in to manage posts.'),
                              ),
                            );
                            return;
                          }

                          setDialogState(() => isSaving = true);

                          try {
                            if (isEditing) {
                              // UPDATE an existing document.
                              await posts.doc(documentId).update({
                                'title': title,
                                'description': description,
                                'updatedAt': FieldValue.serverTimestamp(),
                              });
                            } else {
                              // CREATE a new document.
                              await posts.add({
                                'title': title,
                                'description': description,
                                'userId': currentUser!.uid,
                                'createdAt': FieldValue.serverTimestamp(),
                              });
                            }

                            if (!mounted) return;

                            Navigator.pop(dialogContext);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isEditing
                                      ? 'Post updated successfully.'
                                      : 'Post added successfully.',
                                ),
                              ),
                            );
                          } catch (e) {
                            setDialogState(() => isSaving = false);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error saving post: $e')),
                            );
                          }
                        },
                  child: isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(isEditing ? 'Update' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );

    titleController.dispose();
    descriptionController.dispose();
  }

  // DELETE a post after confirmation.
  Future<void> deletePost(String documentId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await posts.doc(documentId).delete();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post deleted successfully.')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting post: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Firestore Posts')),
        body: const Center(child: Text('Please log in to view your posts.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Posts'), centerTitle: true),

      // READ documents and listen for real-time changes.
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: posts.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading posts: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = List.of(snapshot.data?.docs ?? []);

          if (documents.isEmpty) {
            return const Center(
              child: Text(
                'No posts yet.\nTap + to add your first post.',
                textAlign: TextAlign.center,
              ),
            );
          }

          // Newest posts first. Documents without createdAt go last.
          documents.sort((a, b) {
            final aTime = a.data()['createdAt'];
            final bTime = b.data()['createdAt'];

            if (aTime is Timestamp && bTime is Timestamp) {
              return bTime.compareTo(aTime);
            }
            if (aTime is Timestamp) return -1;
            if (bTime is Timestamp) return 1;
            return 0;
          });

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              final data = document.data();

              final title = data['title'] as String? ?? 'Untitled';
              final description = data['description'] as String? ?? '';
              final isOwner = data['userId'] == currentUser!.uid;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(description),
                  ),
                  trailing: isOwner
                      ? PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              showPostDialog(
                                documentId: document.id,
                                oldTitle: title,
                                oldDescription: description,
                              );
                            } else if (value == 'delete') {
                              deletePost(document.id);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showPostDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
