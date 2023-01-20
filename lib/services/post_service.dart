import 'dart:convert';

import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

// get all posts
Future<ApiResponse> getPosts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse(postsURL),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer '
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['notificacion_multa'].map((p) => Post.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Create post
Future<ApiResponse> createPost(String numero,
  String numero_tarjeta,
  String numero_placa,
  String calle_principal,
  String calle_transversal,
  String fecha,
  String hora,
  String tipo_contravencion_a,
  String tiempo_permanencia,
  String supervisor_responsable,
  String estado,
  String observacion,
  String valor_tiempo,
  String inmovilizado,
  String? imagen1,
  String? imagen2,
  String? imagen3,
  String estado_rev,
  String latitud,
  String longitud) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(postsURL),
      headers: {'Accept': 'application/json'},
      body: {'numero': numero,
      'numero_tarjeta': numero_tarjeta,
      'numero_placa': numero_placa, 
      'calle_principal': calle_principal,
      'calle_transversal': calle_transversal,
      'fecha': fecha,
      'hora': hora,
      'tipo_contravencion_a': tipo_contravencion_a,
      'tiempo_permanencia': tiempo_permanencia,
      'supervisor_responsable': supervisor_responsable,
       'estado': estado,
      'observacion': observacion,
      'valor_tiempo': valor_tiempo,
      'inmovilizado': inmovilizado,
      'imagen1': imagen1,
      'imagen2': imagen2,
      'imagen3': imagen3,
      'estado_rev': estado_rev,
      'latitud': latitud,
      'longitud': longitud}
    );
    // here if the image is null we just send the body, if not null we send the image too

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        print(response.body);
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}



// Edit post
Future<ApiResponse> editPost(int postId, String body) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$postsURL/$postId'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'body': body
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Delete post
Future<ApiResponse> deletePost(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$postsURL/$postId'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Like or unlike post
Future<ApiResponse> likeUnlikePost(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse('$postsURL/$postId/likes'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}