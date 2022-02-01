import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  final db = await Db.create(
      'mongodb+srv://admin:admin@cluster0.80ypz.mongodb.net/test?retryWrites=true&w=majority');

  await db.open();
  final coll = db.collection('contacts');

  print((await coll.find().toList()).toString());

  const port = 8081;
  final serv = Sevr();

  serv.options('/', [
    (req, res) {
      setCors(req, res);
      return res.status(200);
    }
  ]);

  serv.get('/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      final contacts = await coll.find().toList();
      return res.status(200).json({'contacts': contacts});
    }
  ]);

  serv.post('/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      await coll.insertOne(req.body);
      return res.json(await coll.findOne(where.eq('name', req.body['name'])));
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

  serv.listen(port, callback: () {
    print('Listening on port $port');
  });
}

void setCors(ServRequest req, ServResponse res) {
  res.response.headers.add('Access-Control-Allow-Origin', '*');
  res.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, DELETE');
  res.response.headers
      .add('Access-Control-Allow-Headers', 'Origin, Content-Type');
}
