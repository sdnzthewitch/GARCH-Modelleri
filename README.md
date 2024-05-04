## GARCH-Modelleri
Veride GARCH Modeli

```
library(readxl)
CevreKirliligi_1_ <- read_excel("C:/Users/DELL/Downloads/CevreKirliligi (1).xlsx", 
                                col_types = c("numeric", "numeric", "numeric", 
                                              "numeric", "numeric"))
```
```
View(CevreKirliligi_1_)

veri <- CevreKirliligi_1_

head(veri)  # Veri setini görselleştirme
```
 Popülasyon Zaman Serisi
```
populasyon_serisi <- ts(veri$pop, start = 1968, end = 2018, frequency = 1)
```
 Karbondioksit Emisyonu Zaman Serisi
```
co2_serisi <- ts(veri$co2, start = 1968, end = 2018, frequency = 1)
```
 Kişi Başına Gayri Safi Milli Hasıla (GDP) Zaman Serisi
```
gdp_serisi <- ts(veri$gdp, start = 1968, end = 2018, frequency = 1)
```
 Popülasyon Zaman Serisi Görselleştirme
```
plot(populasyon_serisi, main = "Popülasyon Zaman Serisi", xlab = "Yıl", ylab = "Popülasyon")
```
 Karbondioksit Emisyonu Zaman Serisi Görselleştirme
```
plot(co2_serisi, main = "Karbondioksit Emisyonu Zaman Serisi", xlab = "Yıl", ylab = "CO2 Emisyonu")
```
 GDP Zaman Serisi Görselleştirme
```
plot(gdp_serisi, main = "GDP Zaman Serisi", xlab = "Yıl", ylab = "GDP")
```
 Popülasyon Zaman Serisi İçin ACF ve PACF Grafikleri
```
acf(populasyon_serisi)
pacf(populasyon_serisi)
```
 Karbondioksit Emisyonu Zaman Serisi İçin ACF ve PACF Grafikleri
```
acf(co2_serisi)
pacf(co2_serisi)
```
 GDP Zaman Serisi İçin ACF ve PACF Grafikleri
```
acf(gdp_serisi)
pacf(gdp_serisi)
```
 tseries paketini yükleme
```
install.packages("tseries")
library(tseries)
```
 Popülasyon Zaman Serisi Durağanlık Kontrolü
```
adf.test(populasyon_serisi)
kpss.test(populasyon_serisi)
```
 Karbondioksit Emisyonu Zaman Serisi Durağanlık Kontrolü
```
adf.test(co2_serisi)
kpss.test(co2_serisi)
```
 GDP Zaman Serisi Durağanlık Kontrolü
```
adf.test(gdp_serisi)
kpss.test(gdp_serisi)
```
 rugarch paketini yükleme
```
install.packages("rugarch")
library(rugarch)
```
 GARCH Modeli Spesifikasyonu
```
spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)), 
                   mean.model = list(armaOrder = c(0, 0), include.mean = FALSE), 
                   distribution.model = "norm")
```
 GARCH Modeli Uygulama
```
garch_fit <- ugarchfit(spec = spec, data = gdp_serisi)
```
 Model Sonuçlarını Görüntüleme
```
print(garch_fit)
```
