import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/fave_reads.dart';
import 'package:fave_reads/model/read.dart';

class ReadsController extends ResourceController {
  ReadsController(this.context);
  ManagedContext context;

  List reads = [];

  @Operation.get()
  Future<Response> getAllReads() async{
    final readQuery = Query<Read>(context);
    return Response.ok(await readQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getRead(@Bind.path('id') int id) async{
    final readQuery = Query<Read>(context)
      ..where((read) => read.id).equalTo(id);
    final read = await readQuery.fetchOne();
    if(read==null){
      return Response.notFound(body: 'Item not found');
    }
    return Response.ok(reads);
  }

  @Operation.post()
  Future<Response> createNewRead(@Bind.body() Read body) async{

    reads.add(body);
    return Response.ok(body);
  }

  @Operation.put('id')
  Future<Response> putAllReads(@Bind.path('id') int id, @Bind.body() Read body) async{
    if( id < 0 || id > reads.length -1 ){
      return Response.notFound(body: 'Out of range');
    }
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