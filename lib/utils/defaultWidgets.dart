import 'package:flutter/material.dart';

TextField defTextField(String text, bool isPasswordType, TextEditingController controller){
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
      keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: text,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          borderSide: BorderSide(
            color: Color(0xFFB3C5D1),
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(
              color: Color(0xFFBEC5D1),
            )
        ),
        hintStyle: const TextStyle(
          color: Color(0xFFBABABA),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
  );
}

Container defMatButton(BuildContext context, String text, Function onTap, int col, int textCol){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 49,
      child: MaterialButton(
    height: 10,
    minWidth: 200,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    color: Color(col),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: Color(textCol),
      ),),
    onPressed: () {onTap();},
  ),
  );
}

Container defImgButton(BuildContext context, Function _onTap, String imageName, double h, double w){
  return Container(
    child: Material(
      color: Color(0xFFF26D2B),
      elevation: 8,
      borderRadius: BorderRadius.circular(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {_onTap();},
        splashColor: Colors.black26,
        child: Image.asset(
          imageName,
          height: h,
          width: w,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

