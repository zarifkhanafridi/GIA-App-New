// ignore_for_file: public_member_api_docs, sort_constructors_first

class BranchModel {
  String email;
  String phone;
  String fax;
  String website;
  String address;
  String campus;
  BranchModel(
      {required this.email,
      required this.phone,
      required this.fax,
      required this.website,
      required this.address,
      required this.campus});
}

List<BranchModel> branchAList = [
  BranchModel(
    campus: 'Adamic Girls Campus',
    email: 'example.edu.pk',
    phone: '0966-4522',
    fax: '0966-098643',
    website: 'https://url.com',
    address: 'Volker street 34C Block Road,Uk',
  ),
  BranchModel(
    campus: 'Adamic Boys Campus',
    email: 'example.edu.pk',
    phone: '0966-4522',
    fax: '0966-098643',
    website: 'https://url.com',
    address: 'Volker street 34C Block Road,Uk',
  ),
];
