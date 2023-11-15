# install.packages(c("forecast", "datasets"))
library(forecast)
library(datasets)

temperaturas <- as.numeric(LakeHuron)

# convertir a serie temporal
temperaturas <- ts(temperaturas, frequency = 12)

# Análisis exploratorio
summary1 <- summary(temperaturas)

# Plot temperaturas
plot(temperaturas, main = "Temperaturas Mensuales de LakeHuron", xlab = "Mes", ylab = "Temperatura")

# Meter la serie en un modelo arima
modelo_temperaturas <- auto.arima(temperaturas)

# Resumen del modelo
summary2 <- summary(modelo_temperaturas)

# Ver si los residuos no son importantes
checkresiduals(modelo_temperaturas)

# Predicción para los próximos 12 meses
predicciones_temperaturas <- forecast(modelo_temperaturas, h = 12)

# Plot predicciones
plot(predicciones_temperaturas, main = "Predicción de Temperaturas Mensuales", xlab = "Mes", ylab = "Temperatura")