import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

// Api service to fetch , update and delete data in the db.json file on the github repo
class TaskService {

  final repoOwner = 'shubh7727am';
  final repoName = 'mockserver';
  final accessToken = 'github_pat_11BNMXJ4I0qvUT1ZFSFCjY_ndTGMDFzm{remove}8i1GyhsNOYqRzvb0Z9oCmsA10f1UpeJLV8UOH6QOZUPZ72HoZN' ; // delete {remove me} from the access token to fetch data correctly


  // fetching tasks from the db.json

  Future<List<Task>> fetchTasks() async {

    final url = 'https://api.github.com/repos/$repoOwner/$repoName/contents/db.json'; // api url
    // api response
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Cache-Control': 'no-cache', // Bypass client-side cache
      },
    );
    // if successful
    if (response.statusCode == 200) {

      // converting the body into map<string,dynamic> form
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // removing all the new line character form the content
      String base64Content = responseData['content'].replaceAll('\n', '');



      // Decode Base64 content
      String decodedJson = utf8.decode(base64Decode(base64Content));

      // Parse JSON into a Map
      final Map<String, dynamic> jsonResponse = jsonDecode(decodedJson);

      // Extract 'Tasks' and convert to a List of Task objects
      final List<dynamic> tasksJson = jsonResponse['Tasks'];



      return tasksJson.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks. HTTP status: ${response.statusCode}');
    }
  }

// similar as above updating user data
  Future<void> updateUserData(String username, Map<String, dynamic> updatedData) async {

    final url = 'https://api.github.com/repos/$repoOwner/$repoName/contents/$username.json';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final sha = jsonDecode(response.body)['sha'];
      final updatedContent = base64Encode(utf8.encode(jsonEncode(updatedData)));

      final updateResponse = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'message': 'Update $username.json',
          'content': updatedContent,
          'sha': sha,
        }),
      );

      if (updateResponse.statusCode == 200) {
        log('User data updated successfully.');
      } else {
        log('Failed to update user data. Status Code: ${updateResponse.statusCode}');
      }
    } else if (response.statusCode == 404) {
      log('User data not found.');
    } else {
      log('Failed to read user data. Status Code: ${response.statusCode}');
    }
  }




}
