import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:jdonuts/core/database/app_database.dart';

/// A fresh in-memory database per test.
AppDatabase newTestDatabase() {
  // Several databases are opened across a test run; that is intended here.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(NativeDatabase.memory());
}
