import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymtodo/exercise_provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delete Exercises',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF77DBFF), Color(0xFF4AC0FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 3,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          List<Exercise> exercises = ref.watch(exerciseListProvider);

          void deleteExercise(int index) {
            ref.read(exerciseListProvider.notifier).state = [
              ...exercises..removeAt(index),
            ];
          }

          return exercises.isEmpty
              ? Center(
                  child: Text(
                    'No exercises to delete.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return Dismissible(
                        key: ValueKey(exercise),
                        onDismissed: (_) => deleteExercise(index),
                        background: Container(
                          padding: const EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          color: Colors.redAccent,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: Colors.blue.withOpacity(0.15),
                          margin: const EdgeInsets.only(bottom: 12.0),
                          child: ListTile(
                            title: Text(
                              exercise.name,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                decoration: exercise.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                                size: 24,
                              ),
                              onPressed: () => deleteExercise(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF77C7FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            elevation: 2,
          ),
          child: const Text(
            'Back to Home',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
