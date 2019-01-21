install.packages("rvest")

library('rvest')

###pregunta b###

#Inicializar la variable archivo con el nombre de mi pagina
archivo<- 'Tarea5.html'

#Leer el archivo
webpage <- read_html(archivo)

#Extraer noticia
contenidoNoticia<-html_nodes(webpage, ".justificado")

#Pasar la info a texto
textoNoticia<-html_text(contenidoNoticia)

#Ver la info
print(textoNoticia)

# los \n representan tabulaciones

#eliminar los \n, comillas puntos y comas del texto
textoNoticia <- gsub("\n","",textoNoticia)
textoNoticia <- gsub("\"","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub(",","",textoNoticia)
textoNoticia <- gsub("\t","",textoNoticia)
textoNoticia <- gsub("\r","",textoNoticia)


print(textoNoticia)

#separar palabras por espacio
splitEspacioNoticia <- strsplit(textoNoticia," ")[[1]]

#pasar palabras a minusculas
splitEspacioNoticia <- tolower(splitEspacioNoticia)

#contar palabras
unlistNoticias <- unlist(splitEspacioNoticia)
tablapalabras <- table(unlistNoticias)

#pasar informacion a un data frame
dfPalabrasNoticia <- as.data.frame(tablapalabras)

#almacenar info en csv
write.csv(dfPalabrasNoticia,file="PalabrasNoticia.csv")

#almacenar info en txt
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt")


###pregunta c ###

#extraer contenidos de la tabla a traves del tag table
contenidoTabla <- html_nodes(webpage, "table")

#extraer elementos de la tabla
tablaProductosExtraida <- html_table(contenidoTabla[[1]])

#ver el contenido de la posicion 1,2 en la tabla
print(tablaProductosExtraida[1,2])


#Limpiar $ comas y puntos de la tabla
tablaProductosExtraida$Precio <- gsub("\\$","",tablaProductosExtraida$Precio)
tablaProductosExtraida$Precio <- gsub("[.]","",tablaProductosExtraida$Precio)
tablaProductosExtraida$Precio <- as.numeric(gsub(",",".",tablaProductosExtraida$Precio))



print(tablaProductosExtraida)


#Graficos####

library('ggplot2')

#Grafico de barra
tablaProductosExtraida %>%
  ggplot()+
  aes(x=Producto, y=Precio) +
  geom_bar(stat="identity")
