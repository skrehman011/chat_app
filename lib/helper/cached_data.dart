import 'package:mondaytest/Models/Student.dart';
import 'package:mondaytest/helper/constants.dart';

class CachedData {
  static Map<String, Student> _studentsData = {};

  static Future<Student> getStudentById(String id) async {
    if (_studentsData.containsKey(id)) {
      return _studentsData[id]!;
    }

    var obj = await usersRef.doc(id).get();
    var student = Student.fromMap(obj.data() as Map<String, dynamic>);
    _studentsData[id] = student;
    return student;
  }
}
