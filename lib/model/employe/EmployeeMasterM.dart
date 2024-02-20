import 'package:json_annotation/json_annotation.dart';

//part 'EmployeeMasterM.g.dart';

@JsonSerializable()
class EmployeeMasterM {
  List<EmpDetailsBean> EmpDetails;
  dynamic EmpQualification;
  dynamic EmpExperience;
  List<EmpSalaryBean> EmpSalary;

  factory EmployeeMasterM.fromJson(Map<String, dynamic> json) {
    return EmployeeMasterM(
      EmpDetails: List.of(json["EmpDetails"])
          .map((i) => EmpDetailsBean.fromJson(i))
          .toList(),
      EmpQualification: json["EmpQualification"],
      EmpExperience: ["EmpExperience"],
      EmpSalary: List.of(json["EmpSalary"])
          .map((i) => EmpSalaryBean.fromJson(i))
          .toList(),
      EmpSalaryTax: List.of(json["EmpSalaryTax"])
          .map((i) => EmpSalaryTaxBean.fromJson(i))
          .toList(),
      EmpCmpAllowence: json["EmpCmpAllowence"],
      EmpAccountDetails: List.of(json["EmpAccountDetails"])
          .map((i) => EmpAccountDetailsBean.fromJson(i))
          .toList(),
      EmpPersonalDetails: List.of(json["EmpPersonalDetails"])
          .map((i) => EmpPersonalDetailsBean.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "EmpDetails": this.EmpDetails,
      "EmpQualification": this.EmpQualification,
      "EmpExperience": this.EmpExperience,
      "EmpSalary": (this.EmpSalary),
      "EmpSalaryTax": this.EmpSalaryTax,
      "EmpCmpAllowence": this.EmpCmpAllowence,
      "EmpAccountDetails": (this.EmpAccountDetails),
      "EmpPersonalDetails": this.EmpPersonalDetails,
    };
  }

  List<EmpSalaryTaxBean> EmpSalaryTax;
  dynamic EmpCmpAllowence;
  List<EmpAccountDetailsBean> EmpAccountDetails;
  List<EmpPersonalDetailsBean> EmpPersonalDetails;

  EmployeeMasterM(
      {required this.EmpDetails,
      this.EmpQualification,
      this.EmpExperience,
      required this.EmpSalary,
      required this.EmpSalaryTax,
      this.EmpCmpAllowence,
      required this.EmpAccountDetails,
      required this.EmpPersonalDetails});

/*
  factory EmployeeMasterM.fromJson(Map<String, dynamic> json) => _$EmployeeMasterMFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeMasterMToJson(this);
*/
}

@JsonSerializable()
class EmpPersonalDetailsBean {
  String Email;
  String DOB;
  num? Age;
  String Religion;
  String Bloodgroup;
  String AdharNo;
  String PancardNum;
  String Nationality;
  String MobileNo_Linked_Adhar;
  String Bloodgroup1;
  String DrvLicenceNum;
  String PassportNum;
  String Nationality1;
  String MobileNo_Linked_Adhar1;
  String PunchingID;
  num Balance;
  String EmpName;
  String Inactive;
  String Mobile;
  String EmpCode;

  EmpPersonalDetailsBean({
    required this.Email,
    required this.DOB,
    required this.Age,
    required this.Religion,
    required this.Bloodgroup,
    required this.AdharNo,
    required this.PancardNum,
    required this.Nationality,
    required this.MobileNo_Linked_Adhar,
    required this.Bloodgroup1,
    required this.DrvLicenceNum,
    required this.PassportNum,
    required this.Nationality1,
    required this.MobileNo_Linked_Adhar1,
    required this.PunchingID,
    required this.Balance,
    required this.EmpName,
    required this.Inactive,
    required this.Mobile,
    required this.EmpCode,
  });

  factory EmpPersonalDetailsBean.fromJson(Map<String, dynamic> json) {
    return EmpPersonalDetailsBean(
      AdharNo: json["AdharNo"],
      Email: json["Email"],
      DOB: json["DOB"],
      Religion: json["Religion"],
      EmpCode: json["EmpCode"],
      Bloodgroup: json["Bloodgroup"],
      EmpName: json['EmpName'],
      Age: json["Age"],
      Balance: json["Balance"],
      Bloodgroup1: json['Bloodgroup1'],
      DrvLicenceNum: json['DrvLicenceNum'],
      Inactive: json['Inactive'],
      Mobile: json['Mobile'],
      MobileNo_Linked_Adhar1: json['MobileNo_Linked_Adhar1'],
      MobileNo_Linked_Adhar: json['MobileNo_Linked_Adhar'],
      Nationality1: json['Nationality1'],
      Nationality: json['Nationality'],
      PancardNum: json['PancardNum'],
      PassportNum: json['PassportNum'],
      PunchingID:json['PunchingID'] ,
    );
  }
//

/*
  factory EmpPersonalDetailsBean.fromJson(Map<String, dynamic> json) => _$EmpPersonalDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EmpPersonalDetailsBeanToJson(this);
*/
}

@JsonSerializable()
class EmpAccountDetailsBean {
  String BankName;
  String BranchName;
  String Accountnumber;
  String IFSCCode;
  String AccountHolderName;

  factory EmpAccountDetailsBean.fromJson(Map<String, dynamic> json) {
    return EmpAccountDetailsBean(
      BankName: json["BankName"],
      BranchName: json["BranchName"],
      Accountnumber: json["Accountnumber"],
      IFSCCode: json["IFSCCode"],
      AccountHolderName: json["AccountHolderName"],
      GLAccount: json["GLAccount"],
      CommisionAccount: json["CommisionAccount"],
      LeaveAccount: json["LeaveAccount"],
    );
  }

  String GLAccount;
  String? CommisionAccount;
  String LeaveAccount;

  EmpAccountDetailsBean(
      {required this.BankName,
      required this.BranchName,
      required this.Accountnumber,
      required this.IFSCCode,
      required this.AccountHolderName,
      required this.GLAccount,
       this.CommisionAccount,
      required this.LeaveAccount});

/*
  factory EmpAccountDetailsBean.fromJson(Map<String, dynamic> json) => _$EmpAccountDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EmpAccountDetailsBeanToJson(this);
*/
}

@JsonSerializable()
class EmpSalaryTaxBean {
  String TaxCode;
  String Remarks;
  num Dynamic;
  num Amount;

  factory EmpSalaryTaxBean.fromJson(Map<String, dynamic> json) {
    return EmpSalaryTaxBean(
      TaxCode: json["TaxCode"],
      Remarks: json["Remarks"],
      Dynamic: json["Dynamic"],
      Amount: json["Amount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TaxCode": this.TaxCode,
      "Remarks": this.Remarks,
      "Dynamic": this.Dynamic,
      "Amount": this.Amount,
    };
  }

  EmpSalaryTaxBean(
      {required this.TaxCode,
      required this.Remarks,
      required this.Dynamic,
      required this.Amount}) {
    // TODO: implement EmpSalaryTaxBean
    throw UnimplementedError();
  }

/*
  factory EmpSalaryTaxBean.fromJson(Map<String, dynamic> json) => _$EmpSalaryTaxBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EmpSalaryTaxBeanToJson(this);
*/
}

@JsonSerializable()
class EmpSalaryBean {
  String BrickCode;
  num Account;
  num Amount;
  String Remarks;
  num Dynamic;

  EmpSalaryBean(
      {required this.BrickCode,
      required this.Account,
      required this.Amount,
      required this.Remarks,
      required this.Dynamic});

  factory EmpSalaryBean.fromJson(Map<String, dynamic> json) {
    return EmpSalaryBean(
      BrickCode: json["BrickCode"],
      Account: json["Account"],
      Amount: json["Amount"],
      Remarks: json["Remarks"],
      Dynamic: json["Dynamic"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "BrickCode": this.BrickCode,
      "Account": this.Account,
      "Amount": this.Amount,
      "Remarks": this.Remarks,
      "Dynamic": this.Dynamic,
    };
  }
//

/*
  factory EmpSalaryBean.fromJson(Map<String, dynamic> json) => _$EmpSalaryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EmpSalaryBeanToJson(this);
*/
}

@JsonSerializable()
class EmpDetailsBean {
  String EmpCode;
  String EmpName;
  num? EmpCategory;
  String Designation;
  String Department;
  String WrkShift;
  String AllowEmpLogin;
  String UserName;
  String Password;
  String DOB;
  String Gender;
  String Bloodgroup;
  String Nationality;
  String JoiningDate;
  String Taxnum;
  String PancardNum;
  String PassportNum;
  String PasspotExpiry;
  String DrvLicenceNum;
  String DrvLincenceExpiry;
  String PermntAddress;
  String PermntCity;
  String PermntState;
  dynamic ZipCode;
  String PermntCountry;
  String PresentAddrss;
  String PresentCity;
  String PresentState;
  dynamic PresentZip;
  String PresentCountry;
  String TelNum;
  String Mobile;
  String EmrgencyPersonName;
  String EmrgencyPersonRelation;
  String EmrgencyPersonNum;
  String CreatedBy;
  dynamic UpdatedBy;
  dynamic HpprovedBy;

  Map<String, dynamic> toJson() {
    return {
      "Department": this.Department,
    };
  }

  String Inactive;
  String MechineCode;
  num UserId;
  dynamic Created_Date;
  String Updated_Date;
  num CtrlAccount;
  String LeaveAcnt;
  num Commission;
  num Salary;
  num DailyWage;
  String? SalaryCode;
  String PunchingID;
  String? Accounting_by;
  String Email;
  String? PerDaySal;
  String CommAcnt;
  num WrkHrs;
  String IsDirector;
  String IsHod;
  num Balance;
  dynamic Image;
  String IsManger;
  String IsHrManager;
  String IsHRAssistant;
  num Manger;
  num HrManager;
  num HRAssistant;
  num BussinessTeritary;
  String AllowRewards;
  String ShiftBeginTime;
  String ShiftEndTime;
  dynamic Age;
  String Religion;
  String Status;
  String MobileNo_Linked_Adhar;
  String EPFNumber;
  String ESINumber;
  String WelfareNumber;
  String AdharNo;

  EmpDetailsBean(
      {required this.EmpCode,
      required this.EmpName,
       this.EmpCategory,
      required this.Designation,
      required this.Department,
      required this.WrkShift,
      required this.AllowEmpLogin,
      required this.UserName,
      required this.Password,
      required this.DOB,
      required this.Gender,
      required this.Bloodgroup,
      required this.Nationality,
      required this.JoiningDate,
      required this.Taxnum,
      required this.PancardNum,
      required this.PassportNum,
      required this.PasspotExpiry,
      required this.DrvLicenceNum,
      required this.DrvLincenceExpiry,
      required this.PermntAddress,
      required this.PermntCity,
      required this.PermntState,
      this.ZipCode,
      required this.PermntCountry,
      required this.PresentAddrss,
      required this.PresentCity,
      required this.PresentState,
      this.PresentZip,
      required this.PresentCountry,
      required this.TelNum,
      required this.Mobile,
      required this.EmrgencyPersonName,
      required this.EmrgencyPersonRelation,
      required this.EmrgencyPersonNum,
      required this.CreatedBy,
      this.UpdatedBy,
      this.HpprovedBy,
      required this.Inactive,
      required this.MechineCode,
      required this.UserId,
      this.Created_Date,
      required this.Updated_Date,
      required this.CtrlAccount,
      required this.LeaveAcnt,
      required this.Commission,
      required this.Salary,
      required this.DailyWage,
       this.SalaryCode,
      required this.PunchingID,
       this.Accounting_by,
      required this.Email,
       this.PerDaySal,
      required this.CommAcnt,
      required this.WrkHrs,
      required this.IsDirector,
      required this.IsHod,
      required this.Balance,
      this.Image,
      required this.IsManger,
      required this.IsHrManager,
      required this.IsHRAssistant,
      required this.Manger,
      required this.HrManager,
      required this.HRAssistant,
      required this.BussinessTeritary,
      required this.AllowRewards,
      required this.ShiftBeginTime,
      required this.ShiftEndTime,
      this.Age,
      required this.Religion,
      required this.Status,
      required this.MobileNo_Linked_Adhar,
      required this.EPFNumber,
      required this.ESINumber,
      required this.WelfareNumber,
      required this.AdharNo});

  factory EmpDetailsBean.fromJson(Map<String, dynamic> json) {
    return EmpDetailsBean(
      EmpCode: json["EmpCode"],
      EmpName: json["EmpName"],
      EmpCategory: json["EmpCategory"]??0,
      Designation: json["Designation"],
      Department: json["Department"],
      WrkShift: json["WrkShift"],
      AllowEmpLogin: json["AllowEmpLogin"],
      UserName: json["UserName"],
      Password: json["Password"],
      DOB: json["DOB"],
      Gender: json["Gender"],
      Bloodgroup: json["Bloodgroup"],
      Nationality: json["Nationality"],
      JoiningDate: json["JoiningDate"],
      Taxnum: json["Taxnum"],
      PancardNum: json["PancardNum"],
      PassportNum: json["PassportNum"],
      PasspotExpiry: json["PasspotExpiry"],
      DrvLicenceNum: json["DrvLicenceNum"],
      DrvLincenceExpiry: json["DrvLincenceExpiry"],
      PermntAddress: json["PermntAddress"],
      PermntCity: json["PermntCity"],
      PermntState: json["PermntState"],
      ZipCode: json["ZipCode"],
      PermntCountry: json["PermntCountry"],
      PresentAddrss: json["PresentAddrss"],
      PresentCity: json["PresentCity"],
      PresentState: json["PresentState"],
      PresentZip: json["PresentZip"],
      PresentCountry: json["PresentCountry"],
      TelNum: json["TelNum"],
      Mobile: json["Mobile"],
      EmrgencyPersonName: json["EmrgencyPersonName"],
      EmrgencyPersonRelation: json["EmrgencyPersonRelation"],
      EmrgencyPersonNum: json["EmrgencyPersonNum"],
      CreatedBy: json["CreatedBy"],
      UpdatedBy: json["UpdatedBy"],
      HpprovedBy: json["HpprovedBy"],
      Inactive: json["Inactive"],
      MechineCode: json["MechineCode"],
      UserId: json["UserId"],
      Created_Date: json["Created_Date"],
      Updated_Date: json["Updated_Date"],
      CtrlAccount: json["CtrlAccount"],
      LeaveAcnt: json["LeaveAcnt"],
      Commission: json["Commission"],
      Salary: json["Salary"],
      DailyWage: json["DailyWage"],
      SalaryCode: json["SalaryCode"],
      PunchingID: json["PunchingID"],
      Accounting_by: json["Accounting_by"],
      Email: json["Email"],
      PerDaySal: json["PerDaySal"],
      CommAcnt: json["CommAcnt"],
      WrkHrs: (json["WrkHrs"]),
      IsDirector: json["IsDirector"],
      IsHod: json["IsHod"],
      Balance: (json["Balance"]),
      Image: ["Image"],
      IsManger: json["IsManger"],
      IsHrManager: json["IsHrManager"],
      IsHRAssistant: json["IsHRAssistant"],
      Manger: (json["Manger"]),
      HrManager: json["HrManager"],
      HRAssistant: json["HRAssistant"],
      BussinessTeritary: (json["BussinessTeritary"]),
      AllowRewards: json["AllowRewards"],
      ShiftBeginTime: json["ShiftBeginTime"],
      ShiftEndTime: json["ShiftEndTime"],
      Age: json["Age"],
      Religion: json["Religion"],
      Status: json["Status"],
      MobileNo_Linked_Adhar: json["MobileNo_Linked_Adhar"],
      EPFNumber: json["EPFNumber"],
      ESINumber: json["ESINumber"],
      WelfareNumber: json["WelfareNumber"],
      AdharNo: json["AdharNo"],
    );
  }
//

/*factory EmpDetailsBean.fromJson(Map<String, dynamic> json) => _$EmpDetailsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$EmpDetailsBeanToJson(this);
*/
}
