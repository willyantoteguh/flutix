part of 'shared.dart';

Future<File> getImage() async {
  // ignore: deprecated_member_use
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance
      .ref()
      .child(fileName); //Ambil filename tanpa path
  StorageUploadTask task = ref.putFile(image); //UploadFile
  StorageTaskSnapshot snapshot =
      await task.onComplete; //kembalian setelah berhasil upload

  return await snapshot.ref.getDownloadURL();
}
