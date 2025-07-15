class CompanyModel {
  final String logo;
  final String companyName;
  final String description;
  final String isin;
  final String status;
  final ProsAndCons prosAndCons;
  final Financials financials;
  final IssuerDetails issuerDetails;

  CompanyModel({
    required this.logo,
    required this.companyName,
    required this.description,
    required this.isin,
    required this.status,
    required this.prosAndCons,
    required this.financials,
    required this.issuerDetails,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      logo: json['logo'],
      companyName: json['company_name'],
      description: json['description'],
      isin: json['isin'],
      status: json['status'],
      prosAndCons: ProsAndCons.fromJson(json['pros_and_cons']),
      financials: Financials.fromJson(json['financials']),
      issuerDetails: IssuerDetails.fromJson(json['issuer_details']),
    );
  }
}

class ProsAndCons {
  final List<String> pros;
  final List<String> cons;

  ProsAndCons({required this.pros, required this.cons});

  factory ProsAndCons.fromJson(Map<String, dynamic> json) {
    return ProsAndCons(
      pros: List<String>.from(json['pros']),
      cons: List<String>.from(json['cons']),
    );
  }
}

class Financials {
  final List<MonthlyValue> ebitda;
  final List<MonthlyValue> revenue;

  Financials({required this.ebitda, required this.revenue});

  factory Financials.fromJson(Map<String, dynamic> json) {
    return Financials(
      ebitda: (json['ebitda'] as List)
          .map((e) => MonthlyValue.fromJson(e))
          .toList(),
      revenue: (json['revenue'] as List)
          .map((e) => MonthlyValue.fromJson(e))
          .toList(),
    );
  }
}

class MonthlyValue {
  final String month;
  final int value;

  MonthlyValue({required this.month, required this.value});

  factory MonthlyValue.fromJson(Map<String, dynamic> json) {
    return MonthlyValue(
      month: json['month'],
      value: json['value'],
    );
  }
}

class IssuerDetails {
  final String issuerName;
  final String typeOfIssuer;
  final String sector;
  final String industry;
  final String issuerNature;
  final String cin;
  final String leadManager;
  final String registrar;
  final String debentureTrustee;

  IssuerDetails({
    required this.issuerName,
    required this.typeOfIssuer,
    required this.sector,
    required this.industry,
    required this.issuerNature,
    required this.cin,
    required this.leadManager,
    required this.registrar,
    required this.debentureTrustee,
  });

  factory IssuerDetails.fromJson(Map<String, dynamic> json) {
    return IssuerDetails(
      issuerName: json['issuer_name'],
      typeOfIssuer: json['type_of_issuer'],
      sector: json['sector'],
      industry: json['industry'],
      issuerNature: json['issuer_nature'],
      cin: json['cin'],
      leadManager: json['lead_manager'],
      registrar: json['registrar'],
      debentureTrustee: json['debenture_trustee'],
    );
  }
}
