# catchGame 🎮🐿️

## Genel Bakış
**catchGame**, dinamik ve eğlenceli bir iOS oyun deneyimi sunar! Oyuncular, ekranda rastgele beliren sevimli sincaplara dokunarak puan toplamaya çalışır. Bu oyun, reflekslerinizi ve hızınızı test ederken size keyifli anlar yaşatır. Şu anda geliştirme aşamasında olan catchGame, sürekli yenilikler ve geliştirmelerle büyümeye devam ediyor!

## Özellikler
- **Kullanıcı Kaydı:**  
  Sevimli arayüzümüz sayesinde isim giriş ekranında kaydınızı oluşturun ve oyuna hızlıca başlayın.  
  ([SignUpViewController.swift]&#8203;:contentReference[oaicite:0]{index=0})

- **Seviye Seçimi:**  
  Kolay, Orta ve Zor olmak üzere üç farklı zorluk seviyesi arasından seçim yaparak sincapların ekranda görünme süresini kendinize göre ayarlayın.  
  ([LevelSelectionViewController.swift]&#8203;:contentReference[oaicite:1]{index=1})

- **Oyun Mekaniği:**  
  10 saniyelik heyecan dolu süre boyunca, rastgele ekranda beliren sincaplara dokunarak puanlarınızı artırın.  
  ([ViewController.swift]&#8203;:contentReference[oaicite:2]{index=2})

- **Sonuç Ekranı:**  
  Oyun sonunda kullanıcı adınız, seçilen zorluk seviyesi, elde ettiğiniz puan ve mevcut yüksek skorlar ekranda gösterilir. Yeni bir rekor kırarsanız, özel tebrik mesajı ile ödüllendirilirsiniz!  
  ([GameResultViewController.swift]&#8203;:contentReference[oaicite:3]{index=3})

- **Veri Saklama:**  
  Oyuncu bilgileri ve skorlar, `UserDefaults` aracılığıyla saklanır; böylece ilerlemenizi kolayca takip edebilirsiniz.

- **Kullanıcı Arayüzü:**  
  Modern tasarımıyla gradient arka plan ve özenle stilize edilmiş etiketler (label’lar) sayesinde görsel olarak da keyifli bir deneyim sunar.

## Kurulum ve Çalıştırma
1. **Projeyi Açın:**  
   Projeyi Xcode’da açın.
2. **Derleme:**  
   Projeyi derleyip iOS simülatöründe veya gerçek bir cihazda çalıştırın.
3. **Oyuna Başlayın:**  
   - İlk olarak, isim giriş ekranında geçerli bir isim girip devam butonuna tıklayın.  
   - Ardından, seviye seçimi ekranında istediğiniz zorluk seviyesini belirleyin.
4. **Oyun:**  
   Ekranda beliren sincaplara dokunarak puan kazanın ve yüksek skorları kırmaya çalışın!

## Dosya Yapısı
- **SignUpViewController.swift:**  
  Kullanıcı isim girişini yönetir ve oyuncuyu seviye seçim ekranına yönlendirir.

- **LevelSelectionViewController.swift:**  
  Oyuncunun seçtiği zorluk seviyesine göre sincapların görünme süresini ayarlar.

- **ViewController.swift:**  
  Oyun mekanikleri ve ana fonksiyonları içerir.  
  - Oyun süresi, skor hesaplaması ve sincapların rastgele görünme işlemleri burada gerçekleştirilir.
  - Seçilen zorluk seviyesine göre yüksek skorlar takip edilir.

- **GameResultViewController.swift:**  
  Oyun sonuçlarını gösterir; skor, seviye ve yüksek skor bilgileri ile yeni rekorları kutlar.

- **SceneDelegate.swift:**  
  Uygulamanın yaşam döngüsü ve sahne yönetimini gerçekleştirir.

## Geliştirici Bilgileri
- **Geliştirici:** Sercan Yeşilyurt
- **Oluşturulma Tarihleri:**  
  - SceneDelegate ve ViewController: 7 Şubat 2025  
  - Diğer dosyalar: 13 Şubat 2025

## Gelecek Planları & Geliştirme
catchGame halen geliştirilmekte olan bir projedir. Gelecekte:
- Daha fazla seviye ve zorluk eklenmesi,
- Yeni oyun modları ve özelliklerin entegre edilmesi,
- Kullanıcı geri bildirimlerine dayalı iyileştirmeler,
- Ve daha birçok heyecan verici özellik eklenmesi planlanmaktadır!
