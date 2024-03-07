String firebaseCode(String error){
  return error.split(']')[0].split('/')[1];
}