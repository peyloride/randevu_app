# randevu_app

Methods to solve Artistanbul Software Developer Job Application Quiz. There are two implementations; Ruby and Python.

# Problem
Randevu alınabilecek saatlerin belirlenmesi
Randevu alınabilecek saatler ve aynı anda kaç kişiye hizmet verilebileceği ("kota"), 20 dakikalık aralıklar ile önceden tanımlanıyor. Yeni bir randevu almak istendiğinde; tanımlı saat/kotalar, daha önceden alınmış olan randevular ve randevu almak isteyen kişi sayısı bilgilerini kullanarak müsait olan saat listesini döndüren bir fonksiyon yazılması bekleniyor.

Müsait saatleri belirlerken önemli bir kural var, randevu alan grup içerisindeki tüm kişilerin işlemi ardışık bir şekilde aynı personel tarafından yapılmalı. Örneğin, bir çift saat 11:20 için randevu aldığında, o saatte iki kişilik kota işgal etmiyor, onun yerine 11:20 ve 11:40 saatleri için birer kişilik kota kullanmış oluyorlar. Bu nedenle, bu çift randevu alırken eğer saat 11:40 randevu almak için müsait değilse saat 11:20'ye da randevu alamıyor olması gerekiyor.


Örnek veriler:

```
saatler = [
    {'kota': 3, 'saat': '09:00'},
    {'kota': 3, 'saat': '09:20'},
    {'kota': 3, 'saat': '09:40'},
    {'kota': 3, 'saat': '10:00'},
    {'kota': 3, 'saat': '10:20'},
    {'kota': 3, 'saat': '10:40'},
    {'kota': 2, 'saat': '11:00'},
    {'kota': 2, 'saat': '11:20'},
    {'kota': 2, 'saat': '11:40'}
]
randevular = [
    {'kisi_sayisi': 2, 'saat': '10:40'},
    {'kisi_sayisi': 3, 'saat': '09:00'},
    {'kisi_sayisi': 1, 'saat': '11:40'},
    {'kisi_sayisi': 2, 'saat': '11:20'},
    {'kisi_sayisi': 1, 'saat': '09:40'},
    {'kisi_sayisi': 3, 'saat': '09:00'},
    {'kisi_sayisi': 4, 'saat': '10:00'}
]
```


Yukarıdaki veriler ile örnek çıktı:

```
>> musait_saatler(saatler, randevular, 2)

['09:00', '10:00', '10:20']
```

# Instructions
Every method has comment lines for how to use. Briefly, I did calculate quotas after current appointments, then check remaining quotas can handle new people.

# Tests
There is rspec tests for Ruby version. You can use this command in project folder to run tests.
```ruby
rspec spec/app.spec
```

Tested on 2.5.0p0 and Python 3.6.4.






