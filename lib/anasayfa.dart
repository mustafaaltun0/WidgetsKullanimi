import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var tfController = TextEditingController();
  String alinanVeri = "";
  String resimAdi = "pizza.png";
  bool switchKontrol = false;
  bool checkboxKontrol = false;
  int radioDeger = 0;
  bool progressKontrol = false;
  double ilerleme = 30.0;
  var tfsaat = TextEditingController();
  var tftarih = TextEditingController();
  var ulkelerListesi = <String>[];
  String secilenUlke = "Türkiye";

  @override
  void initState(){
    super.initState();
    ulkelerListesi.add("Türkiye");
    ulkelerListesi.add("İtalya");
    ulkelerListesi.add("Japonya");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Widget"),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(alinanVeri),
              Padding(
                padding: const EdgeInsets.all(8.0),//padding kenarlara boşluk verecek
                child: TextField(
                  controller: tfController,
                  decoration: const InputDecoration(hintText: "Veri"),//içinde gözükecek mesaj
                  keyboardType: TextInputType.number,//hangi kılavyenin açılacağını belirtir
                  obscureText: true,//yazılan şey ğrünsün mü ? görünmesin mi ?
                ),
              ),
              ElevatedButton(onPressed: (){
                setState(() {//setstate sayfayı güncellemeye yarıyor
                  alinanVeri = tfController.text;
                });
              }, child: const Text("Veriyi Al")),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,// yan yana buton için row kullanıyoruz 
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      resimAdi = "ayran.png";
                    });
                  }, child: const Text("Resim Bir")),
                  SizedBox(width: 60,height: 60,
                    child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/$resimAdi")),
                  ElevatedButton(onPressed: (){
                    setState(() {
                     resimAdi = "kofte.png";
                    });
                  }, child: const Text("Resim iki")),
                ],
              ),
        
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,// yan yana buton için row kullanıyoruz 
                children: [
                  SizedBox(width: 200,
                    child: SwitchListTile(
                      title: const Text("Dart"),
                      controlAffinity: ListTileControlAffinity.leading,//dart yazısı switchlist in sağındamı solunda mı yazsın
                      value: switchKontrol,
                      onChanged: (veri){
                        setState(() {
                          switchKontrol = veri;
                        });
                      }
                     ),
                  ),
                  SizedBox(width: 200,
                    child: CheckboxListTile(
                      title: const Text("Flutter"),
                      controlAffinity: ListTileControlAffinity.leading,//Flutter yazısı switchlist in sağındamı solunda mı yazsın
                      value: checkboxKontrol,
                      onChanged: (veri){
                        setState(() {
                          checkboxKontrol = veri!;
                        });
                      }
                     ),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,// yan yana buton için row kullanıyoruz 
                children: [
                  SizedBox(width: 200,
                    child: RadioListTile(
                      title: const Text("Galatasaray"),
                      controlAffinity: ListTileControlAffinity.leading,//dart yazısı switchlist in sağındamı solunda mı yazsın
                      value: 1,
                      groupValue: radioDeger,
                      onChanged: (veri){
                        setState(() {
                          radioDeger = veri!;
                        });
                      }
                     ),
                  ),
                  SizedBox(width: 200,
                    child: RadioListTile(
                      title: const Text("Fenerbahçe"),
                      controlAffinity: ListTileControlAffinity.leading,//Flutter yazısı switchlist in sağındamı solunda mı yazsın
                      value: 2,
                      groupValue: radioDeger,
                      onChanged: (veri){
                        setState(() {
                          radioDeger = veri!;
                        });
                      }
                     ),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,// yan yana buton için row kullanıyoruz 
                children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      progressKontrol = true;
                    });
                  }, child: const Text("Başla")),
                  Visibility(visible: progressKontrol, child: const CircularProgressIndicator()),
                  ElevatedButton(onPressed: (){
                    setState(() {
                     progressKontrol = false;
                    });
                  }, child: const Text("Dur")),
                ],
              ),
              Text(ilerleme.toInt().toString()),
              Slider(max:100.0,min: 0.0,value:  ilerleme, onChanged: (veri){
                setState(() {
                  ilerleme = veri;
                });
              }),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 120,
                      child: TextField(controller: tfsaat,decoration:const InputDecoration(hintText: "Saat"),)),
                  IconButton(onPressed: (){
                    showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()))
                    .then((value) {
                      tfsaat.text = "${value!.hour} : ${value.minute}";
                    });
                  }, icon: const Icon(Icons.access_time)),
        
                  SizedBox(width: 120,
                      child: TextField(controller: tftarih,decoration:const InputDecoration(hintText: "Tarih"),)),
                  IconButton(onPressed: (){
                    showDatePicker(context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030))
                    .then((value) {
                      tftarih.text = "${value!.day} / ${value.month} / ${value.year}";
                    });
                  }, icon: const Icon(Icons.data_array)),  
                ],
              ),
              DropdownButton(
                value: secilenUlke, 
                icon: const Icon(Icons.arrow_drop_down),
                items: ulkelerListesi.map((ulke){
                  return DropdownMenuItem(value: ulke,child: Text(ulke),);
                }).toList(),
                onChanged: (veri){
                  setState(() {
                    secilenUlke = veri!; 
                  });
                }
              ),
              GestureDetector(
                onTap: (){
                  print("Tek Tıklandı");
                },
                onDoubleTap: (){
                  print("Çift Tıklandı");
                },
                onLongPress: () {
                  print("Üzerine uzun Basıldı");
                },
                child: Container(width: 200,height: 400,color :Colors.red)),
              ElevatedButton(onPressed: (){
                print("Switch durum : $switchKontrol");
                print("Checkbox durum : $checkboxKontrol");
                print("Switch durum : $switchKontrol");
                print("Radio durum : $radioDeger");
                print("Slider durum : $ilerleme");
              }, child: const Text("Göster"))
            ],
          ),
        ),
      ),
    );
  }
}