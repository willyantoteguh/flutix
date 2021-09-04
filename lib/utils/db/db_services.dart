import 'package:bwa_flutix/models/models.dart';

import 'db_helper.dart';

class DBServices {
  Future<bool> addTransaction(TicketDB model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.insert(TicketDB.table, model);

      isSaved = inserted == 1 ? true : false;
    }

    return isSaved;
  }

  Future<List<TicketDB>> getTickets() async {
    await DB.init();
    List<Map<String, dynamic>> tickets = await DB.query(TicketDB.table);

    return tickets.map((item) => TicketDB.fromMap(item)).toList();
  }

  Future<List<Theater>> getTheaters() async {
    await DB.init();
    List<Map<String, dynamic>> theaters = await DB.query(Theater.table);

    return theaters.map((item) => Theater.fromMap(item)).toList();
  }

  Future<bool> updateTheaters(TicketDB model) async {
    await DB.init();
    bool isSaved = false;
    if (model != null) {
      int inserted = await DB.update(TicketDB.table, model);

      isSaved = inserted == 1 ? true : false;
    }

    return isSaved;
  }

  Future<bool> deleteProduct(TicketDB model) async {
    await DB.init();
    bool isDeleted = false;
    if (model != null) {
      int deleted = await DB.delete(TicketDB.table, model);

      isDeleted = deleted == 1 ? true : false;
    }

    return isDeleted;
  }
}
