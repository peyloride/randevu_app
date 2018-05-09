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
def n_sonraki_saat_index(saatler, randevu_saati, n):
  for saat in saatler:
    if saat['saat'] == randevu_saati:
      return saatler.index(saat) + n

# Args: Array, Array
# Daha önceden belirtilen kotalardan düşecek şekilde var olan randevuları yerleştirir.
def randevuları_yerlestir(saatler, randevular):
  for randevu in randevular:
    for kisi in range(0, randevu['kisi_sayisi']):
      saatler[n_sonraki_saat_index(saatler, randevu['saat'], kisi)]['kota'] -= 1

# Args: Array, String, n
# Verilen saat ve kisiye göre saatler dizisinde bir eleman olup olmadığına ve bu elemanın
# kotasının 0'dan büyük veya eşit olup olmadığını kontrol eder
# Dönüş tipi: Boolean
def randevu_verilemez(saatler, saat, kisi):
  saat_index = n_sonraki_saat_index(saatler, saat['saat'], kisi)
  return (len(saatler) - 1) < saat_index or saatler[saat_index]['kota'] <= 0

# Args: Array, Array, Integer
# saatler dizisindeki saat ve kotalara uygun şekilde var olan randevular listesi haricinde
# 'randevu_kisi' parametresi ile belirtilen sayıda kişi için uygun randevuları kontrol eder.
# Uygun randevu bulunması durumunda randevu saatlerini döner.
def musait_saatler(saatler, randevular, randevu_kisi):
  randevuları_yerlestir(saatler, randevular)

  uygun_saatler = []
  for saat in saatler:
    for kisi in range(0, randevu_kisi):
      if randevu_verilemez(saatler, saat, kisi):
        break
      if (randevu_kisi -1 == kisi):
        uygun_saatler.append(saat['saat'])

  for saat in saatler:
    print(saat)

  print('*****************************')

  if uygun_saatler is []:
    print("Sonuç bulunamadı maalesef")
  else:
    print("Uygun saatler")
    print(uygun_saatler)

musait_saatler(saatler, randevular, 1)










