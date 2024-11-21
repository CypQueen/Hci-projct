import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(title:'دوائك لبيتك' ,theme: ThemeData(primarySwatch: Colors.blue,),
      home:LoginPage(),);
  }
}

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController= TextEditingController();
  String emailError = '';
  String passwordError='';

  bool _isEmailValid(String email){
    final emailRegex=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool_isPasswordStrong(String password){
    return password.length>= 8 && password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[0-9]'));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'البريد الالكتروني',
                errorText: emailError.isEmpty ? null:emailError,
              ),
            ),
            SizedBox(height:20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                errorText: passwordError.isEmpty?null:passwordError,
              ),
              obscureText: true,
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed:(){
                setState(() {
                  emailError= _isEmailValid(emailController.text) ? '' : 'يرجى ادخال بربد الكتروني صالح';
                  passwordError=bool_isPasswordStrong(passwordController.text)? '' : 'كلمة المرور يجب ان تحتوي على 8 أحرف على الأقل مع حرف ورقم كبيريّن' ;
                });
                if(emailError.isEmpty &&passwordError.isEmpty){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>HomePage()),
                  );
                }
              },
              child: Text('تسجيل الدخول'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>RegisterPage()),
                );
              },
              child: Text('انشاء حساب جديد'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState()=>_RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage>{
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();

  String emailError='';
  String passwordError='';

  bool _isEmailValid(String email){
    final emailRegex=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
  bool _isPasswordStrong(String password){
    return password.length>=8 && password.contains(RegExp(r'[A-Z]'))&& password.contains(RegExp(r'[0-9]')) ;
  }
  bool_doPasswordMatch(String password, String confirmPassword){
    return password ==confirmPassword;
  }
  Widget build(BuildContext contaxt){
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل مستخدم جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'البريد الالكتروني',
                errorText: emailError.isEmpty?null:emailError,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                errorText: passwordError.isEmpty?null:passwordError,
              ),
              obscureText: true,
            ),
            SizedBox(height:20),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                errorText: passwordError.isEmpty?null:passwordError,
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  emailError= _isEmailValid(emailController.text)? '' : 'يرجى ادخال بريد الكتروني صالح';
                  passwordError=_isPasswordStrong(passwordController.text)?'': 'كلمة المرور يجب ان تحتوي على 8 أحرف على الاقل مع حرف كبير و رقم';

                  if(!bool_doPasswordMatch(passwordController.text,confirmPasswordController.text)){
                    passwordError='كلمات المرور غير متطابقة';
                  }
                });
                if(emailError.isEmpty && passwordError.isEmpty){
                  Navigator.push(
                    contaxt,
                    MaterialPageRoute(builder: (contaxt)=>HomePage()),
                  );
                }
              },
              child: Text('تسجيل حساب جديد'),
            ),
          ],
        ),

      ),
    );
  }
}
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}
class _HomePageState extends State<HomePage>{
  List<String> cartItems= [];
  String location ='';
  List<Product> products =[
    Product(name:'بنادول',price:20),
    Product(name:'فيفادول',price:10),
    Product(name:'بروفين',price:20),
    Product(name:'كريم مسكن',price:20),
    Product(name:'فيتامين d',price:20),
    Product(name:'فيتامين c',price:20),
  ];
  List<Doctor> doctors=[
    Doctor(name:'د.أحمد',specialty:'صيدلي/ة',location:'مستشفى الملك خالد'),
    Doctor(name:'د.خالد',specialty:'طبيب/ة عام',location:'مستشفى الملك خالد'),
    Doctor(name:'د.فاطمة',specialty:'طبيب/ة نساء وولادة',location:'مستشفى النساء والولادة'),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('دواك لبيتك'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>SettingsPage()),
              );
            },
          ),
          IconButton(
            icon:Icon(Icons.exit_to_app),
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context)=>LoginPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('الاطباء والصيدلانيين',style: TextStyle(fontSize:20 ,fontWeight:FontWeight.bold )),
          ...doctors.map((doctor) => ListTile(
            title: Text('${doctor.specialty}-${doctor.location}'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=> ConsultationPage(doctorName:doctor.name),
                ),
              );
            },
          )),
          SizedBox(height: 20),
          Text('الأدوية والمنتجات',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ...products.map((product) => ListTile(
            title:Text(product.name),
            subtitle: Text('سعر:${product.price}ريال'),
            trailing: IconButton(
              icon:Icon(Icons.add_shopping_cart),
              onPressed: (){
                setState(() {
                  cartItems.add(product.name);
                });
              },
            ),
          )),
          SizedBox(height: 20),
          Cart(cartItems:cartItems,location:location,onLocationChanged:(newLocation){
            setState(() {
              location=newLocation;
            });
          }),
        ],
      ),
    );
  }
}
class Cart extends StatelessWidget {
  final List<String> cartItems;
  final String location;
  final Function(String) onLocationChanged;

  Cart({required this.cartItems,required this.location,required this.onLocationChanged});

  @override

  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('السلة',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
        ...cartItems.map((item)=>Text(item)),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: 'موقعك',
            hintText: 'أدخل موقعك هنا',
          ),
          onChanged: onLocationChanged,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('اتمام الطلب')));
          },
          child: Text('تسجيل الطلب'),
        ),
      ],
    );
  }
}
class Product{
  final String name;
  final double price;

  Product({required this.name,required this.price});
}

class Doctor{
  final String name;
  final String specialty;
  final String location;

  Doctor({required this.name,required this.specialty,required this.location});
}
class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('الأعدادات')),
      body:ListView(
        padding: EdgeInsets.all(16),
        children:[
          ListTile(
            title: Text(''),
            onTap: (){
              //action for account info
            },
          ),
          ListTile(
            title: Text('السجل الصحي'),
            onTap:(){
              // action for helth record
            },
          ),
          ListTile(
            title: Text('حذف الحساب'),
            onTap: (){
              //action for account delet
            },
          ),
        ],
      ),
    );
  }
}

class ConsultationPage extends StatelessWidget{
  final String doctorName;
  ConsultationPage({required this.doctorName});

  @override
  Widget build(BuildContext context){
    TextEditingController consultationController= TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('استشارة ل$doctorName')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: consultationController,
              decoration: InputDecoration(
                labelText: 'اكتب هنا',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                //اشاره الى تنفيذ ارسال الاستشاره
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم ارسال الاستشارة الى $doctorName')),
                );
                Navigator.pop(context);// العوده للصفحه الرئيسيه
              },
              child: Text('ارسال'),
            ),
          ],
        ),
      ),
    );
  }
}