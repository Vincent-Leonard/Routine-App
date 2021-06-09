import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:routine/models/models.dart';

DatabaseService<Logs> logsDBS = DatabaseService<Logs>("logs",
    fromDS: (id, data) => Logs.fromDS(id, data),
    toMap: (event) => event.toMap());
