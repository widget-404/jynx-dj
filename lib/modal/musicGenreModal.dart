
class MusicGenreModal {
    MusicGenreModal({
        required this.name,
        required this.id,
    });

    String id;
    String name;
   

    factory MusicGenreModal.fromJson(Map<String, dynamic> json) => MusicGenreModal(
        name: json['music_genre'].toString(),
        id: json["id"].toString(),
    );
}



