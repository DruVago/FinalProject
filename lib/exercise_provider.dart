import 'package:flutter_riverpod/flutter_riverpod.dart';

class Exercise {
  String name;
  bool isCompleted;

  Exercise({required this.name, this.isCompleted = false});
}

class ExerciseNotifier extends StateNotifier<List<Exercise>> {
  ExerciseNotifier() : super([]);

  void addExercise(String name) {
    state = [...state, Exercise(name: name)];
  }

  void toggleExerciseCompletion(int index) {
    final updatedExercise = Exercise(
      name: state[index].name,
      isCompleted: !state[index].isCompleted,
    );

    // Create a new list with the updated exercise
    state = [
      ...state.sublist(0, index),
      updatedExercise,
      ...state.sublist(index + 1),
    ];
  }

  void deleteExercise(int index) {
    state = [...state]..removeAt(index);
  }
}

final exerciseListProvider =
    StateNotifierProvider<ExerciseNotifier, List<Exercise>>(
  (ref) => ExerciseNotifier(),
);
