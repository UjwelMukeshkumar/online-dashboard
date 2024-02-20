import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CreateNewShiftScreen extends StatefulWidget {
  @override
  State<CreateNewShiftScreen> createState() => _CreateNewShiftScreenState();
}

class _CreateNewShiftScreenState extends State<CreateNewShiftScreen> {
  var tecName = TextEditingController();
  var tecCode = TextEditingController();
  var tecValue = TextEditingController();

   Color? currentColor;

  var formKey=GlobalKey<FormState>();

   CompanyRepository? compRepo;

  @override
  void initState() {
    
    super.initState();
    compRepo=Provider.of<CompanyRepository>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    var space=SizedBox(height: 8,);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Shift"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tecName,
                decoration: InputDecoration(
                    labelText: "Shift Name", border: textFieldBorder),
                validator: (text) => text!.isEmpty ? "Enter Shift Name" : null,
              ),
              space,
              TextFormField(
                controller: tecCode,
                decoration: InputDecoration(
                    labelText: "Shift Code", border: textFieldBorder),
                validator: (text) => text!.isEmpty ? "Enter Shift Code" : null,
              ),
              space,
              TextFormField(
                keyboardType: TextInputType.number,
                controller: tecValue,
                decoration: InputDecoration(
                    labelText: "Shift Value", border: textFieldBorder),
                validator: (text) => text!.isEmpty ? "Enter Shift Value" : null,
              ),
              space,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Pick Color"),
              ),
              InkWell(
                onTap: openColorPallet,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    color: currentColor,
                    // color: Color(4293576704),
                  ),
                  height: 30,
                ),
              ),
              Expanded(child: Container()),
              ElevatedButton(onPressed: save, child: Text("Save"))


            ],
          ),
        ),
      ),
    );
  }

  void openColorPallet() {
    showDialog(
      context: context,
      builder:(context)=> AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: Colors.red,
            onColorChanged: changeColor,
            enableAlpha: false,
            displayThumbColor: true,
            hexInputBar: true,

          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Select'),
            onPressed: () {
              // setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void changeColor(Color value) {
    setState(() {
    currentColor=value;
    print("Color ${value.value}");
    });
  }

  Future<void> save() async {
    if(formKey.currentState!.validate()){
      if(currentColor==null){
        showToast("Select Color");
        return;
      }
      var response=await Serviece.insertShift(context: context,api_key: compRepo!.getSelectedApiKey(),shiftCode: tecCode.text,shiftColor: currentColor!.value.toString(),shiftName: tecName.text,shiftValue: tecValue.text);
      if(response!=null){
        showToast("Saved");
        Navigator.pop(context,true);
      }
    }
  }
}
