import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  // Log into database
  final db = await Db.create(
      r'mongodb+srv://Alexboudreaux:7$PolkimQwesdec3@cluster0.gus5j.mongodb.net/scoring?retryWrites=true&w=majority');
  await db.open();
  final coll = db.collection('engagements');

  // Create server
  const port = 8081;
  final serv = Sevr();

  final corsPaths = ['/', '/:id'];
  for (var route in corsPaths) {
    serv.options(route, [
      (req, res) {
        setCors(req, res);
        return res.status(200);
      }
    ]);
  }

  serv.get('/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final categories = await coll.find().toList();
      return res.status(200).json({'categories': categories});
    }
  ]);

  serv.post('/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await coll.save(req.body);
      return res.json(
        await coll.findOne(where.eq('category', req.body['category'])),
      );
    }
  ]);

  serv.put('/:id', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await coll.update(
        where.eq('_id', ObjectId.parse(req.params['id'])),
        req.body,
      );
      return res.json(
        await coll.findOne(where.eq('_id', ObjectId.parse(req.params['id']))),
      );
    }
  ]);

  serv.delete('/:id', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await coll
          .remove(where.eq('_id', ObjectId.fromHexString(req.params['id'])));
      return res.status(200);
    }
  ]);

  // Listen for connections
  serv.listen(port, callback: () {
    print('Server listening on port: $port');
  });
}

void setCors(ServRequest req, ServResponse res) {
  res.response.headers.add('Access-Control-Allow-Origin', '*');
  res.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, DELETE');
  res.response.headers
      .add('Access-Control-Allow-Headers', 'Origin, Content-Type');
}
