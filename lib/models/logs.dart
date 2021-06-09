part of 'models.dart';

class Logs extends Equatable {
  final String amount;
  final DateTime date;
  final String habitType;
  final String typeValue;
  final String habitName;
  final String habitId;
  final String userId;

  Logs(
      {this.amount,
      this.date,
      this.habitType,
      this.typeValue,
      this.habitName,
      this.habitId,
      this.userId});

  @override
  List<Object> get props => [
        amount,
        date,
        habitType,
        typeValue,
        habitName,
        habitId,
        userId,
      ];

  factory Logs.fromMap(Map data) {
    return Logs(
      habitName: data['habitName'],
      habitType: data['habitType'],
      typeValue: data['typeValue'],
      amount: data['amount'],
      date: data['date'],
      habitId: data['habitId'],
      userId: data['userId'],
    );
  }

  factory Logs.fromDS(String id, Map<String, dynamic> data) {
    return Logs(
      habitName: data['habitName'],
      habitType: data['habitType'],
      typeValue: data['typeValue'],
      amount: data['amount'],
      date: data['date'],
      habitId: data['habitId'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "habitName": habitName,
      "habitType": habitType,
      "typeValue": typeValue,
      "amount": amount,
      "date": date,
      "habitId": habitId,
      "userId": userId,
    };
  }
}
