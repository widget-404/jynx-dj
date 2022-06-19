
class GalleryImageModel {
    GalleryImageModel({
        required this.imageID,
        required this.galleryID,
        required this.imageUrl,
    });

    String imageID;
    String imageUrl;
    String galleryID;
    
   

    factory GalleryImageModel.fromJson(Map<String, dynamic> json) => GalleryImageModel(
        imageID: json['id'].toString(),
        imageUrl: json['image'].toString(),
        galleryID: json['gallery_id'].toString()
        
    );
}



