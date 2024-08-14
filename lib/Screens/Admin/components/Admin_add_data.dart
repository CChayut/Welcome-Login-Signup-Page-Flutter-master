import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Admin/components/Admin_window.dart';
import 'package:flutter_auth/constants.dart'; // ตรวจสอบว่ามีการนำเข้า constants.dart

class AdminAddData extends StatefulWidget {
  const AdminAddData({Key? key}) : super(key: key);

  @override
  _AdminAddDataState createState() => _AdminAddDataState();
}

class _AdminAddDataState extends State<AdminAddData> {
  String? _selectedGender;
  DateTime? _selectedDate;
  String? _selectedMaritalStatus;
  String? _selectedEducationStatus;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _subDistrictController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _relativeAddressController =
      TextEditingController();
  final TextEditingController _medicalConditionController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _calculateAge(picked);
      });
    }
  }

  void _calculateAge(DateTime birthDate) {
    final DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    _ageController.text = '$age';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        //title: Text('เพิ่มข้อมูลผู้ป่วย'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "เพิ่มข้อมูลผู้ป่วย",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "ชื่อผู้ป่วย",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                _buildTextField(_nameController, "ชื่อผู้ป่วย"),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          _selectedDate == null
                              ? 'เลือกวัน/เดือน/ปี'
                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                          elevation: 2,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // ช่องว่าง 10 พิกเซล
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("เพศ"),
                          Row(
                            children: <Widget>[
                              Text("ชาย"),
                              Radio<String>(
                                value: 'ชาย',
                                groupValue: _selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                              SizedBox(width: 10), // ช่องว่าง 10 พิกเซล
                              Text("หญิง"),
                              Radio<String>(
                                value: 'หญิง',
                                groupValue: _selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "สถานะสมรส",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text("โสด"),
                              Radio<String>(
                                value: 'โสด',
                                groupValue: _selectedMaritalStatus,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedMaritalStatus = value;
                                  });
                                },
                              ),
                              SizedBox(width: 10), // ช่องว่าง 10 พิกเซล
                              Text("สมรส"),
                              Radio<String>(
                                value: 'สมรส',
                                groupValue: _selectedMaritalStatus,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedMaritalStatus = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "สถานะการศึกษา",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          DropdownButton<String>(
                            value: _selectedEducationStatus,
                            hint: Text("เลือกสถานะการศึกษา"),
                            items: <String>[
                              'ประถมศึกษา',
                              'มัธยมศึกษา',
                              'ปริญญาตรี',
                              'ปริญญาโท',
                              'ปริญญาเอก'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedEducationStatus = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "ที่อยู่",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                _buildTextField(_addressController, "ที่อยู่"),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildTextField(_cityController, "เมือง"),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(_districtController, "อำเภอ"),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(_subDistrictController, "ตำบล"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTextField(_phoneController, "เบอร์โทรศัพท์"),
                SizedBox(height: 20),
                _buildTextField(_relativeAddressController, "ที่อยู่ญาติ"),
                SizedBox(height: 20),
                _buildTextField(_medicalConditionController, "โรคประจำตัว"),
                SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the form submission logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 184, 66, 231),
                        elevation: 0,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        "เพิ่มข้อมูล",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AdminWindow();
                          },
                        ),
                      );
                    },
                    child: const Text('ย้อนกลับ'),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          Colors.blue, // เปลี่ยนสีข้อความปุ่มเป็นสีน้ำเงิน
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD3D3D3),
            blurRadius: 20.0,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
        keyboardType:
            hintText.contains("เบอร์โทรศัพท์") || hintText.contains("อายุ")
                ? TextInputType.number
                : TextInputType.text,
      ),
    );
  }
}
