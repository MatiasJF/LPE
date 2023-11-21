# install.packages(c("forecast", "ggplot2"))
library(forecast)
library(ggplot2)

#conjunto de datos 
data("AirPassengers")

# convertir a serie temporal
pasajeros <- ts(AirPassengers, frequency = 12)

train_len <- floor(length(pasajeros) * 0.8)
train <- pasajeros[1:train_len]
test <- pasajeros[(train_len + 1):length(pasajeros)]

# Análisis exploratorio y grafica de la seria
summary1 <- summary(train)
plot(pasajeros, main = "Pasajeros Aéreos Mensuales", xlab = "Mes", ylab = "Pasajeros")

# Meter la serie en un modelo arima
modelo_pasajeros <- auto.arima(train)

# Resumen del modelo
summary2 <- summary(modelo_pasajeros)

# Ver si los residuos no son importantes
checkresiduals(modelo_pasajeros)

# Predecir para los próximos 4 años años, 48 meses
predicciones <- forecast(modelo_pasajeros, h = 48)

# Plot de las predicciones
plot(predicciones, main = "PrediccionPasajeros Aéreos Mensuales", xlab = "Mes", ylab = "Pasajeros")

# Plot de los resultados de el modelo
plot(modelo_pasajeros, main = "Modelo")

acc <- accuracy(predicciones$mean, datos_prueba)

