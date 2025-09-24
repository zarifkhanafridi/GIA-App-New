// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ApiService {
//   // Method to reset the password
//   static Future<Map<String, dynamic>> resetPassword(String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://your-api-endpoint.com/reset-password'), // Replace with your actual API URL
//         body: {
//           'password': password,
//           // Include any other required parameters
//         },
//       );
//
//       if (response.statusCode == 200) {
//         return json.decode(response.body);  // Assuming a JSON response
//       } else {
//         throw Exception('Failed to reset password');
//       }
//     } catch (e) {
//       rethrow;  // Rethrow the error if the request fails
//     }
//   }
// }
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Method to reset the password
  static Future<Map<String, dynamic>> resetPassword(String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://your-api-endpoint.com/reset-password'), // Replace with your actual API URL
        headers: {
          'Content-Type': 'application/json', // Set content-type as JSON
        },
        body: json.encode({
          'password': password, // Assuming the password field is required
          // Include any other required parameters such as email or token
        }),
      );

      if (response.statusCode == 200) {
        // If server responds with success (200)
        return json.decode(response.body); // Parse and return the JSON response
      } else {
        // If server responds with any other status code
        throw Exception('Failed to reset password: ${response.body}');
      }
    } catch (e) {
      // Handle errors (network issues, unexpected responses, etc.)
      throw Exception('An error occurred: $e');
    }
  }
}
