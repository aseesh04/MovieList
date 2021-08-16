import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movielist/model/database1.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielist/boxes.dart';
import 'package:movielist/widget/dialog.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movielist/login.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Movie List'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              ),
            )
          ],
        ),
        body: ValueListenableBuilder<Box<Database1>>(
          valueListenable: Boxes.getdata().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<Database1>();

            return buildContent(transactions);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => TransactionDialog(
              onClickedDone: addTransaction,
            ),
          ),
        ),
      );
  Widget buildContent(List<Database1> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No Movies Are Add yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];

                return buildTransaction(context, transaction);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildTransaction(
    BuildContext context,
    Database1 transaction,
  ) {
    final date = DateFormat.yMMMd().format(transaction.createdDate);

    return Card(
        color: Colors.white,
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: Text(
            transaction.mname,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(date),
          leading:
              CircleAvatar(backgroundImage: NetworkImage(transaction.link)),
          trailing: Text(
            transaction.dname,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          children: [
            buildButtons(context, transaction),
          ],
        ));
  }

  Widget buildButtons(BuildContext context, Database1 transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TransactionDialog(
                    transaction: transaction,
                    onClickedDone: (mname, dname, link) =>
                        editTransaction(transaction, mname, dname, link),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteTransaction(transaction),
            ),
          )
        ],
      );
  Future addTransaction(String mname, String dname, String link) async {
    final transaction = Database1()
      ..mname = mname
      ..createdDate = DateTime.now()
      ..dname = dname
      ..link = link;
    final box = Boxes.getdata();
    box.add(transaction);
  }

  void editTransaction(
      Database1 transaction, String mname, String dname, String link) {
    transaction.mname = mname;
    transaction.dname = dname;
    transaction.link = link;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    transaction.save();
  }

  void deleteTransaction(Database1 transaction) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() => transactions.remove(transaction));
  }
}
