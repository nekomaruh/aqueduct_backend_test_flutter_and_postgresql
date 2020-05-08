import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class ReadsController extends ResourceController {

  List reads = [
    {
      'title': 'Head First Design Patterns',
      'author': 'Eric Freeman',
      'year': 2004
    },
    {
      'title': 'Clean Code: A handbook of Agile Software Craftsmanship',
      'author': 'Robert C. Martin',
      'year': 2008
    },
    {
      'title': 'Code Complete: A Practical Handbook of Software Construction',
      'author': 'Steve McConnell',
      'year': 2004
    },
  ];
  /*
  @override
  FutureOr<RequestOrResponse> handle(Request request) {
    switch (request.method) {
      case 'GET':
        return Response.ok('Hello, world');
        break;
      case 'POST':
        return Response.ok('Post');
        break;
      case 'PUT':
        return Response.ok('Put');
        break;
      case 'DELETE':
        return Response.ok('Delete');
        break;
      default:
        return Response(
            HttpStatus.methodNotAllowed, null, 'Method is not allowed');
    }
  }
   */

  @Operation.get()
  Future<Response> getAllReads() async{
    return Response.ok(reads);
  }

  @Operation.get('id')
  Future<Response> getRead(@Bind.path('id') int id) async{
    if(id<0 || id > reads.length-1){
      return Response.notFound(body: 'Item not found');
    }
    return Response.ok(reads[id]);
  }

  @Operation.post()
  Future<Response> postAllReads() async{
    final Map<String, dynamic> body = request.body.as();
    reads.add(body);
    return Response.ok(body);
  }

  @Operation.put('id')
  Future<Response> putAllReads(@Bind.path('id') int id) async{
    if( id < 0 || id > reads.length -1 ){
      return Response.notFound(body: 'Out of range');
    }
    final Map<String, dynamic> body = request.body.as();
    reads[id] = body;
    return Response.ok('Put all reads');
  }

  @Operation.delete('id')
  Future<Response> deleteRead(@Bind.path('id') int id) async{
    if( id < 0 || id > reads.length -1 ){
      return Response.notFound(body: 'Item not found');
    }
    reads.removeAt(id);
    return Response.ok('Delete reads');
  }
}