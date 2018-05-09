# Problem: Randevu alınabilecek saatlerin belirlenmesi
# Randevu alınabilecek saatler ve aynı anda kaç kişiye hizmet verilebileceği ("kota"), 20 dakikalık aralıklar ile önceden tanımlanıyor. Yeni bir randevu almak istendiğinde; tanımlı saat/kotalar, daha önceden alınmış olan randevular ve randevu almak isteyen kişi sayısı bilgilerini kullanarak müsait olan saat listesini döndüren bir fonksiyon yazılması bekleniyor.

# Müsait saatleri belirlerken önemli bir kural var, randevu alan grup içerisindeki tüm kişilerin işlemi ardışık bir şekilde aynı personel tarafından yapılmalı. Örneğin, bir çift saat 11:20 için randevu aldığında, o saatte iki kişilik kota işgal etmiyor, onun yerine 11:20 ve 11:40 saatleri için birer kişilik kota kullanmış oluyorlar. Bu nedenle, bu çift randevu alırken eğer saat 11:40 randevu almak için müsait değilse saat 11:20'ye da randevu alamıyor olması gerekiyor.


# Örnek veriler:

# saatler = [
#     {'kota': 3, 'saat': '09:00'},
#     {'kota': 3, 'saat': '09:20'},
#     {'kota': 3, 'saat': '09:40'},
#     {'kota': 3, 'saat': '10:00'},
#     {'kota': 3, 'saat': '10:20'},
#     {'kota': 3, 'saat': '10:40'},
#     {'kota': 2, 'saat': '11:00'},
#     {'kota': 2, 'saat': '11:20'},
#     {'kota': 2, 'saat': '11:40'}
# ]
# randevular = [
#     {'kisi_sayisi': 2, 'saat': '10:40'},
#     {'kisi_sayisi': 3, 'saat': '09:00'},
#     {'kisi_sayisi': 1, 'saat': '11:40'},
#     {'kisi_sayisi': 2, 'saat': '11:20'},
#     {'kisi_sayisi': 1, 'saat': '09:40'},
#     {'kisi_sayisi': 3, 'saat': '09:00'},
#     {'kisi_sayisi': 4, 'saat': '10:00'}
# ]


# Yukarıdaki veriler ile örnek çıktı:

# >> musait_saatler(saatler, randevular, 2)
# ['09:00', '10:00', '10:20']

saatler = [
    {'kota': 3, 'saat': '09:00'},
    {'kota': 3, 'saat': '09:20'},
    {'kota': 3, 'saat': '09:40'},
    {'kota': 3, 'saat': '10:00'},
    {'kota': 3, 'saat': '10:20'},
    {'kota': 3, 'saat': '10:40'},
    {'kota': 2, 'saat': '11:00'},
    {'kota': 2, 'saat': '11:20'},
    {'kota': 2, 'saat': '11:40'},
    {'kota': 2, 'saat': '12:00'},
    {'kota': 1, 'saat': '12:20'},
    {'kota': 1, 'saat': '12:40'},
    {'kota': 1, 'saat': '13:00'}
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

# Args: Array, String, Integer
# Verilen saatten n sonraki saatin, @saat dizisi içerisindeki index'ini verir.
# Örnek: n_sonraki_saat_index('09:40', 1) için 3 döner.
# Dönüş tipi: Integer
def n_sonraki_saat_index(saatler, randevu_saati, n)
  saat_index = saatler.find_index(saatler.find { |saat| saat[:saat] == randevu_saati })
  saat_index + n
end

# Args: Array, Array
# Daha önceden belirtilen kotalardan düşecek şekilde var olan randevuları yerleştirir.
def randevuları_yerlestir(saatler, randevular)
  randevular.each do |randevu|
    (0..randevu[:kisi_sayisi] - 1).each do |kisi|
      saatler[n_sonraki_saat_index(saatler, randevu[:saat], kisi)][:kota] -= 1
    end
  end
end

# Args: Array, String, n
# Verilen saat ve kisiye göre saatler dizisinde bir eleman olup olmadığına ve bu elemanın
# kotasının 0'dan büyük veya eşit olup olmadığını kontrol eder
# Dönüş tipi: Boolean
def randevu_verilemez?(saatler, saat, kisi)
  saat_index = n_sonraki_saat_index(saatler, saat[:saat], kisi)
  saatler[saat_index].nil? || saatler[saat_index][:kota] <= 0
end

# Args: Array, Array, Integer
# saatler dizisindeki saat ve kotalara uygun şekilde var olan randevular listesi haricinde
# 'randevu_kisi' parametresi ile belirtilen sayıda kişi için uygun randevuları kontrol eder.
# Uygun randevu bulunması durumunda randevu saatlerini döner.
def musait_saatler(saatler, randevular, randevu_kisi)
  randevuları_yerlestir(saatler, randevular)

  uygun_saatler = []
  saatler.each do |saat|
    (0..randevu_kisi - 1).each do |kisi|
      break if randevu_verilemez?(saatler, saat, kisi)
      uygun_saatler << saat[:saat] if (randevu_kisi - 1 == kisi)
    end
  end
  uygun_saatler
end
