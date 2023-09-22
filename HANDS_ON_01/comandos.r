
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

install.packages("tidyverse")

# Request servicio rest ---------------------------------------------------------------------------

exp_22145824 <- jsonlite::fromJSON("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
print(exp_221458324)
