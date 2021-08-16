import 'package:flutter/material.dart';

import '../model/database1.dart';

class TransactionDialog extends StatefulWidget {
  final Database1? transaction;
  final Function(String mname, String dname, String link) onClickedDone;

  const TransactionDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  final mnameController = TextEditingController();
  final dnameController = TextEditingController();
  final linkController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      mnameController.text = transaction.mname;
      dnameController.text = transaction.dname;
      linkController.text = transaction.link;
    }
  }

  @override
  void dispose() {
    mnameController.dispose();
    dnameController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildMname(),
              SizedBox(height: 8),
              buildDname(),
              SizedBox(height: 8),
              buildLink(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildMname() => TextFormField(
        controller: mnameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Moive Name',
        ),
        validator: (mname) =>
            mname != null && mname.isEmpty ? 'Enter Movie Name' : null,
      );
  Widget buildDname() => TextFormField(
        controller: dnameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter The Director Name',
        ),
        validator: (dname) =>
            dname != null && dname.isEmpty ? 'Enter The Director Name' : null,
      );
  Widget buildLink() => TextFormField(
        controller: linkController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Link',
        ),
        validator: (link) => link != null && link.isEmpty ? 'Enter Link' : null,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final mname = mnameController.text;
          final dname = dnameController.text;
          final link = linkController.text;

          widget.onClickedDone(mname, dname, link);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
