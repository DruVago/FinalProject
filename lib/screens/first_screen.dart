import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymtodo/exercise_provider.dart';

class FirstScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Exercise',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF77C7FF), Color(0xFF4A90E2)],
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

          void addExercise() {
            if (_controller.text.isNotEmpty) {
              ref
                  .read(exerciseListProvider.notifier)
                  .addExercise(_controller.text);
              _controller.clear();
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Exercise',
                    hintText: 'Enter exercise name',
                    labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
                const SizedBox(height: 15),
                
                Center(
                  child: ElevatedButton(
                    onPressed: addExercise,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      backgroundColor: const Color(0xFF77C7FF),
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Add Exercise',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                
                Expanded(
                  child: exercises.isEmpty
                      ? const Center(
                          child: Text(
                            'No exercises added yet.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = exercises[index];
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              shadowColor: Colors.blue.withOpacity(0.15),
                              margin: const EdgeInsets.only(bottom: 12.0),
                              child: ListTile(
                                title: Text(
                                  exercise.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    decoration: exercise.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 15),
                
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 16),
                      backgroundColor: const Color(0xFF77C7FF),
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
