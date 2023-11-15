# install.packages(c("forecast", "quantmod"))
library(forecast)
library(quantmod)

# datos de precios de cierre de acciones de Apple (AAPL)
getSymbols("AAPL", src = "yahoo", from = "2022-01-01", to = Sys.Date())

# coger solo los precios de cierre
precios_cierre <- Cl(AAPL)

# convertir a serie temporal
precios_cierre <- ts(precios_cierre, frequency = 1)

# Análisis exploratorio y plot de precios
summary1 <- summary(precios_cierre)

plot(precios_cierre, main = "Precios de Cierre de AAPL", xlab = "Días", ylab = "Precio de Cierre")


# Meter la serie en un modelo arima
modelo_acciones <- auto.arima(precios_cierre)

# Resumen del modelo
summary2 <- summary(modelo_acciones)

# Ver si los residuos no son importantes
checkresiduals(modelo_acciones)

# Predicción para el proximo mes
predicciones_acciones <- forecast(modelo_acciones, h = 30)

# Plot de las predicciones
plot(predicciones_acciones, main = "Predicción de Precios de Cierre de AAPL", xlab = "Días", ylab = "Precio de Cierre")