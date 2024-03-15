class FileCardModel{
  final String title;
  final String subtitle;
  final String dateAdded;
  final String fileType;
  final String fileUrl;
  final String fileName;
  final String id;

  FileCardModel({required this.title,required this.subtitle,required this.dateAdded,required this.fileType,required this.fileUrl,required this.fileName,required this.id});
  factory FileCardModel.fromJson(Map<dynamic,dynamic> json,String id){
    return FileCardModel(id:id, title: json["title"].toString(), subtitle: json["subTitle"].toString(), dateAdded: json["dateAdded"].toString(), fileType: json["fileType"].toString(), fileUrl: json["fileUrl"].toString(),fileName: json["fileName"].toString());
  }
}