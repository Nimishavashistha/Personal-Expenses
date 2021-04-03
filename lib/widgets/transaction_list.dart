import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    "No Transactions added Yet!",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.jpg',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? TextButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text("Delete"),
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                            style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor,
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
            ),
    );
  }
}
