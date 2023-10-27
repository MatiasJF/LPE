
# Script + Info ----------------------------------------------------------------------------------

# NOMBRE: Matias Jackson Fascioli
# EXP: 22145824
# Tema: HANDS_ON_01

#Git Comandos ---------------------------------------------------------------------------------------

# setwd --> set working directory
# getwd --> get working directory
# git status --> info sobre la repo
# git add <nombre> --> agrega el archivo <nombre> a la repo
# git add. --> agrega todos los archivos del directorio a la repo
# git commit -m "mensaje" --> agrega un mensaje al commit
# git push origin <brahch name>  --> sube los cambios a la repo en la rama especificada

# Cli commands -------------------------------------------------------------------------------------

# pwd  --> Path sobre el que se trabaja
# ls -->  para listado de directorio
# cd ..  --> para pasar a la carpeta anterior
# cd <nombre> para entrar en la carpeta <nombre>
# mkdir <nombre> --> crear directorio con <nombre>

# Shortcuts ----------------------------------------------------------------------------------------

# Ctrl + L --> limpia la consola
# Ctrl + R --> busca en el historial de comandos
# Ctrl + Shift + F10 --> corre el script
# Ctrl + Shift + F --> busca en el script
# Ctrl + Shift + C --> comenta la linea
# Sift + Enter --> ejecuta linea

# R Comandos ---------------------------------------------------------------------------------------

# rm(list=ls()) --> borra todas las variables del entorno
# ls() --> lista las variables del entorno
# install.packages("nombre") --> instala el paquete <nombre>
# library("nombre") --> carga el paquete <nombre>
# help("nombre") --> abre la ayuda del paquete <nombre>
# ?"nombre" --> abre la ayuda del paquete <nombre>
# data() --> lista los datasets disponibles
# data("nombre") --> carga el dataset <nombre>
# head("nombre") --> muestra las primeras 6 filas del dataset <nombre>

# Declarar variables -------------------------------------------------------------------------------
x <- 3 # asignacion simple
x <<- 3 # asignacion global
x = 3 # asignacion simple
x <- 3; y <- 4 # asignacion multiple

# Tipos de datos -----------------------------------------------------------------------------------
# numerico (double)
# integer
# character
# logical (binario)
# complex

# Operadores ---------------------------------------------------------------------------------------
# + - * / ^ %% %/%
# == != < > <= >=
# ! & |
# c() --> concatenar
# length() --> largo
# sum() --> suma
# mean() --> promedio
# median() --> mediana
# var() --> varianza
# sd() --> desviacion estandar
# min() --> minimo
# max() --> maximo
# print() --> imprimir por consola

# Condiionales -------------------------------------------------------------------------------------
# if (condicion) {expresion} else {expresion}
# if (condicion) {expresion} else if (condicion) {expresion} else {expresion}


# Declarar variables con su tipo -------------------------------------------------------------------
x <- 3L # integer
x <- 3.5 # double
x <- "hola" # character
x <- TRUE # logical
x <- 3+2i # complex

# Declarar Funciones -------------------------------------------------------------------------------
function(x) {return(x^2)}
function(x,y) {return (x^y)}

# LLamar a las funciones ---------------------------------------------------------------------------
f <- function(x) {x^2}
h <- function(x,y) {x = x^y; return(x+y)}
print(f(3))
print(h(3,2))

# Declarar vectores --------------------------------------------------------------------------------
vec <- c(1,2,3,4,5) # vector numerico
print(vec)

# Declarar matrices --------------------------------------------------------------------------------
mat <- matrix(1:9, nrow=3, ncol=3) # matriz numerica
print(mat)

# Declarar dataframes ------------------------------------------------------------------------------
df <- data.frame(a=1:3, b=4:6, c=7:9) # dataframe numerico
print(df)

# Declarar listas ---------------------------------------------------------------------------------
l <- list(a=1:3, b=4:6, c=7:9) # lista numerica
print(l)

# Declarar arrays ---------------------------------------------------------------------------------
a <- array(1:24, dim=c(2,3,4)) # array numerico
print(a)

# Intalar tidyverse -------------------------------------------------------------------------------

# install.packages (c("tidyverse", "dplyr", "janitor", "readr", "writexl","penxlsx","leaflet","htmlwidgets", "readxl"))

library(leaflet)
library(dplyr)
library(janitor)
library(readr)
library(writexl)
library(openxlsx)
library(readxl)
library(htmlwidgets)

# Cargar datos ------------------------------------------------------------------------------------

exp_22145824 <- jsonlite::fromJSON("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
df <- exp_22145824$ListaEESSPrecio # get readable table
df <- df %>%  janitor::clean_names() %>% glimpse()
clean_data <- df %>% readr::type_convert(locale = readr::locale(decimal_mark = ",")) %>% glimpse()



# Data Treating -----------------------------------------------------------

villa <- clean_data %>% select(precio_gasoleo_a , rotulo , direccion, localidad) %>% 
  filter(localidad == "VILLAVICIOSA DE ODON") %>% View()

boavi <- clean_data %>% select(precio_gasoleo_a , rotulo , direccion, localidad) %>% 
  filter(localidad == "VILLAVICIOSA DE ODON"|localidad == "BOADILLA DEL MONTE") %>% 
  arrange(precio_gasoleo_a) %>% View()

mad <- clean_data %>% select(precio_gasoleo_a , rotulo , direccion, localidad) %>% 
  filter(grepl(" MADRID", localidad)) %>% arrange(precio_gasoleo_a) %>% View()

mad <- clean_data %>% select(precio_gasoleo_a , rotulo , direccion, localidad) %>% 
  filter(grepl(" MADRID", localidad)) %>% arrange(precio_gasoleo_a) %>% as.data.frame()

# Storing Data ------------------------------------------------------------

writexl::write_xlsx(mad, "informes/informe_madrid.xlsx")
openxlsx::write.xlsx(mad, "informes/informe_madrid2.xlsx", rowNames = TRUE)

INFORME_VILLA <- write.csv(villa, "informes/gaso_villa.csv")

write_excel_csv(mad, "informes/Informe_madrid.xls")

# MAPAS DE GASOLINERAS -------------------------------------------------------

mapa_mad <- clean_data %>% select(rotulo, precio_gasoleo_a, direccion, municipio, provincia, latitud, longitud_wgs84) %>% 
  filter(provincia=="MADRID", precio_gasoleo_a < 1.55, grepl("BALLENOIL", rotulo)) %>% arrange(desc(precio_gasoleo_a))

mapa_mad %>% leaflet() %>% addTiles() %>% 
  addCircleMarkers(lat = ~latitud, lng = ~longitud_wgs84, popup = ~rotulo, label = ~precio_gasoleo_a)


# GASOLINERAS LOW COST ----------------------------------------------------

media_gas <- clean_data %>% select(rotulo, precio_gasoleo_a, direccion, municipio, provincia, latitud, longitud_wgs84) %>% 
  filter(provincia=="MADRID") %>% arrange(desc(precio_gasoleo_a))

media_gas <- clean_data %>% select(rotulo, precio_gasoleo_a, direccion, municipio, provincia, latitud, longitud_wgs84) %>% 
  arrange(desc(precio_gasoleo_a))

media_gas %>% group_by(rotulo) %>% summarise(media = mean(precio_gasoleo_a)) %>% 
  arrange(media) %>% write_excel_csv(media_gas, "informes/gasolineras_low_cost.xls") %>% filter(media < 1.55) %>% View()

media_gas %>% leaflet() %>% addTiles() %>% 
  addCircleMarkers(lat = ~latitud, lng = ~longitud_wgs84, popup = ~rotulo, label = ~precio_gasoleo_a) %>%  
  saveWidget("informes/low_cost/mapa_mad.html")

# GASOLINERAS LOW COST ----------------------------------------------------

media_gas <- clean_data %>% mutate(low_cost = !rotulo%in% c("REPSOL", "CEPSA", "Q8", "BP", "SHELL", "CAMPSA", "GALP"))


# COL NUEVA GAS LOW COST --------------------------------------------------

media_gas <- clean_data %>% group_by(rotulo) %>% summarise(media = mean(precio_gasoleo_a)) %>% 
  arrange(desc(media)) %>%  View()


media_gas <- clean_data %>% mutate(low_cost = !rotulo%in% c("REPSOL", "CEPSA", "Q8", "BP", "SHELL", "CAMPSA", "GALP")) %>% 
  select(rotulo, precio_gasoleo_a, direccion, municipio, provincia, latitud, longitud_wgs84, low_cost) %>% 
  filter(provincia=="MADRID") %>% arrange(desc(precio_gasoleo_a))


# MEDIA ANDALUCIA ---------------------------------------------------------

provincias_andalucia <- c("ALMERÍA", "CÁDIZ", "CÓRDOBA", "GRANADA", "HUELVA", "JAÉN", "MÁLAGA", "SEVILLA")

# clean_data <- clean_data %>% mutate(comunidad = ifelse(provincia %in% provincias_andalucia, "ANDALUCÍA", ""))

idcaa <- readxl::read_excel("HANDS_ON_01/codccaa_OFFCIAL.xls", skip = 1) %>% glimpse()

clean_data <- merge(clean_data, idcaa, by.x = "idccaa", by.y = "CODIGO", all.x = TRUE)

colnames(clean_data)[colnames(clean_data) == "LITERAL"] <- "comunidad"

media_andalucia <- clean_data %>% select(rotulo, comunidad,  precio_gasoleo_a, direccion, municipio, provincia, latitud, longitud_wgs84) %>% 
  filter(comunidad == "Andalucía") %>% arrange(desc(precio_gasoleo_a)) %>% glimpse()

precio_andalucia <- mean(media_andalucia$precio_gasoleo_a, na.rm = TRUE) %>% glimpse()

media_andalucia %>% group_by(rotulo) %>% summarise(media = mean(precio_gasoleo_a)) %>% 
  arrange(media) %>% write_excel_csv(media_andalucia, "informes/media_andalucia.xls") %>% View()

media_andalucia %>% leaflet() %>% addTiles() %>% 
  addCircleMarkers(lat = ~latitud, lng = ~longitud_wgs84, popup = ~rotulo, label = ~precio_gasoleo_a) %>% 
  saveWidget("informes/andalucia/mapa_andalucia.html")
 





