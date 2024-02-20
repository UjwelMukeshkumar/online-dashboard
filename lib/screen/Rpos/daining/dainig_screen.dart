import 'package:flutter/material.dart';
import 'package:glowrpt/screen/Rpos/daining/daining_category_screen.dart';

class DainingScreen extends StatelessWidget {
  const DainingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 2.5 / 1.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        int tableNumber = index + 1;
        return GestureDetector(
          onTap: () => _showDialoguefForNumberOfPersons(context, tableNumber),
          //  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>DainingCategory(tableNumber:tableNumber))),
          child: Container(
            // alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/c1.png"),fit:BoxFit.contain ,),
                color: Color.fromARGB(255, 235, 238, 235),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.only(left:8.0,top: 5),
              child: Text("T $tableNumber",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
            ),
          ),
        );
      },
    );
  }

  void _showDialoguefForNumberOfPersons(
    BuildContext context,
    int tableNumber,
  ) {
    TextEditingController _personController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text("Number of Persons"),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _personController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "No of Person",
                    suffixIcon: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            int numberOfPerson =
                                int.parse(_personController.text);
                            if (numberOfPerson > 0) {
                                Navigator.of(context).pop(numberOfPerson);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DainingCategory(
                                    tableNumber: tableNumber,
                                    numberOfPersons: numberOfPerson,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Icon(Icons.arrow_forward_sharp)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Number of persons";
                  }
                  return null;
                },
              ),
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 20.0),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         if (_formKey.currentState!.validate()) {
            //           int numberOfPerson = int.parse(_personController.text);
            //           if (numberOfPerson > 0) {
            //             Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (_) => DainingCategory(
            //                   tableNumber: tableNumber,
            //                   numberOfPersons: numberOfPerson,
            //                 ),
            //               ),
            //             );
            //           }
            //         }
            //       },
            //       child: Text("Submit"),
            //     ),
            //   )
            // ],
            actionsPadding: EdgeInsets.only(top: 0, bottom: 10),
          );
        });
  }
}
