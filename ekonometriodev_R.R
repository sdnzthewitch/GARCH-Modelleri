library(readxl)
CevreKirliligi_1_ <- read_excel("C:/Users/DELL/Downloads/CevreKirliligi (1).xlsx", 
                                col_types = c("numeric", "numeric", "numeric", 
                                              "numeric", "numeric"))
View(CevreKirliligi_1_)

veri <- CevreKirliligi_1_

head(veri)  # Veri setini g�rselle�tirme

# Pop�lasyon Zaman Serisi
populasyon_serisi <- ts(veri$pop, start = 1968, end = 2018, frequency = 1)

# Karbondioksit Emisyonu Zaman Serisi
co2_serisi <- ts(veri$co2, start = 1968, end = 2018, frequency = 1)

# Ki�i Ba��na Gayri Safi Milli Has�la (GDP) Zaman Serisi
gdp_serisi <- ts(veri$gdp, start = 1968, end = 2018, frequency = 1)

# Pop�lasyon Zaman Serisi G�rselle�tirme
plot(populasyon_serisi, main = "Pop�lasyon Zaman Serisi", xlab = "Y�l", ylab = "Pop�lasyon")

# Karbondioksit Emisyonu Zaman Serisi G�rselle�tirme
plot(co2_serisi, main = "Karbondioksit Emisyonu Zaman Serisi", xlab = "Y�l", ylab = "CO2 Emisyonu")

# GDP Zaman Serisi G�rselle�tirme
plot(gdp_serisi, main = "GDP Zaman Serisi", xlab = "Y�l", ylab = "GDP")

# Pop�lasyon Zaman Serisi ��in ACF ve PACF Grafikleri
acf(populasyon_serisi)
pacf(populasyon_serisi)

# Karbondioksit Emisyonu Zaman Serisi ��in ACF ve PACF Grafikleri
acf(co2_serisi)
pacf(co2_serisi)

# GDP Zaman Serisi ��in ACF ve PACF Grafikleri
acf(gdp_serisi)
pacf(gdp_serisi)

# tseries paketini y�kleme
install.packages("tseries")
library(tseries)

# Pop�lasyon Zaman Serisi Dura�anl�k Kontrol�
adf.test(populasyon_serisi)
kpss.test(populasyon_serisi)

# Karbondioksit Emisyonu Zaman Serisi Dura�anl�k Kontrol�
adf.test(co2_serisi)
kpss.test(co2_serisi)

# GDP Zaman Serisi Dura�anl�k Kontrol�
adf.test(gdp_serisi)
kpss.test(gdp_serisi)

# rugarch paketini y�kleme
install.packages("rugarch")
library(rugarch)

# GARCH Modeli Spesifikasyonu
spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)), 
                   mean.model = list(armaOrder = c(0, 0), include.mean = FALSE), 
                   distribution.model = "norm")

# GARCH Modeli Uygulama
garch_fit <- ugarchfit(spec = spec, data = gdp_serisi)

# Model Sonu�lar�n� G�r�nt�leme
print(garch_fit)