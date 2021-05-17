part of 'models.dart';

class Habits extends Equatable {
  final String habitId;
  final String habitName;
  final String habitType;
  final String defaultHabit;
  final String positiveHabit;
  final String addBy;
  final String createdAt;
  final String updatedAt;

  Habits(
    this.habitId,
    this.habitName,
    this.habitType,
    this.defaultHabit,
    this.positiveHabit,
    this.addBy,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props => [
        habitId,
        habitName,
        habitType,
        defaultHabit,
        positiveHabit,
        addBy,
        createdAt,
        updatedAt,
      ];
}
