import 'package:image_picker/image_picker.dart';

 pickimg(ImageSource source) async{
  final ImagePicker _picker= ImagePicker();
  XFile? _file= await _picker.pickImage(source: source);
  if(_file!=null){
    return _file.readAsBytes();
  }else{
    print('no img selected');
  }

}