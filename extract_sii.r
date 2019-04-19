# rm(list = ls())

#install.packages('httr')

library(httr)
library(jsonlite)

####### lista de Direcciones Regionales

url = 'https://www4.sii.cl/mapasui/services/data/mapasFacadeService/listDireccionesRegionales'

jsonRequest <- '{"metaData":{"namespace":"cl.sii.sdi.lob.bbrr.mapas.data.api.interfaces.MapasFacadeService/listDireccionesRegionales","conversationId":"UNAUTHENTICATED-CALL190.44.204.112","transactionId":"ea17b50b-8706-9d7f-5dbe-7b1dcd0a8b19"}}'

fromJsonBody <- fromJSON(jsonRequest, simplifyVector = FALSE)

listDireccionesRegionales <- content(POST(url = url, body = fromJsonBody, encode = "json"),"text")

jsonDireccionesRegionales <- jsonlite::fromJSON(listDireccionesRegionales)



for(d in jsonDireccionesRegionales$data$nombre){
  print(d)
}

####### 

# Extrae
urlComunas = 'https://www4.sii.cl/mapasui/services/data/mapasFacadeService/listComunas'

jsonComunasRequest <- '{"metaData":{"namespace":"cl.sii.sdi.lob.bbrr.mapas.data.api.interfaces.MapasFacadeService/listComunas","conversationId":"UNAUTHENTICATED-CALL190.44.204.112","transactionId":"42d8d906-349a-9772-2de1-2a53903a60b0"}}'
#{"metaData":{"namespace":"cl.sii.sdi.lob.bbrr.mapas.data.api.interfaces.MapasFacadeService/listComunas","conversationId":"UNAUTHENTICATED-CALL186.11.43.56","transactionId":"fe4aad8b-f681-7960-876f-cdfd03af40d6"}}


fromJsonComunasBody <- fromJSON(jsonComunasRequest, simplifyVector = FALSE)

resolvePostComunas <- POST(url = urlComunas, body = fromJsonComunasBody, encode = "json")

listComunas <- content(resolvePostComunas,"text")

write(listComunas,"listaComunas.json")

# carga

jsonComunas <- jsonlite::fromJSON("listaComunas.json")

dfComunas <- data.frame(codigo = jsonComunas$data$codigo, comuna = jsonComunas$data$nombre)

muestra <- read.csv("muestra.txt",sep = ";")

mergeComunasMuestra <- merge(dfComunas,muestra,by = "comuna", all.y = TRUE)

#### Esto Falta


dfDatosMuestra <- data.frame(codigo = unlist(mergeComunasMuestra$codigo),manzana = unlist(mergeComunasMuestra$manzana), predio = unlist(mergeComunasMuestra$predio))


for(dato in dfDatosMuestra){
  print(paste("feo ->",dato))
}

dato



#### sacando un dato

####### 

# Extrae
urlPredioNacional = 'https://www4.sii.cl/mapasui/services/data/mapasFacadeService/getPredioNacional'


for(i in data) {
comuna = 5505
manzana = 13
predio = 116

jsonPredioNacionalRequest <- paste('{"metaData":{"namespace":"cl.sii.sdi.lob.bbrr.mapas.data.api.interfaces.MapasFacadeService/getPredioNacional","conversationId":"UNAUTHENTICATED-CALL190.44.204.112","transactionId":"198e298e-6077-a600-c55b-5945abb958fa"},"data":{"predio":{"comuna":"',comuna,'","manzana":"',manzana,'","predio":"',predio,'"},"servicios":[]}}',sep = "")
#{"metaData":{"namespace":"cl.sii.sdi.lob.bbrr.mapas.data.api.interfaces.MapasFacadeService/getPredioNacional","conversationId":"UNAUTHENTICATED-CALL190.44.204.112","transactionId":"e6899913-9d1b-b689-f35a-585afe29fa7a"},"data":{"predio":{"comuna":"5505","manzana":"13","predio":"16"},"servicios":[{"comuna":5505,"layer":"sii:BR_CART_AH_MUESTRAS","style":"AH_MUESTRA"}]}}
#{"metaData":{"namespace":"cl.sii.sdi.lob.bbrr.mapas.data.api.interfaces.MapasFacadeService/getPredioNacional","conversationId":"UNAUTHENTICATED-CALL186.11.43.56","transactionId":"8b0c313a-e40c-e1cb-2342-f36fea31a702"},"data":{"predio":{"comuna":"5505","manzana":"13","predio":"116"},"servicios":[]}}
fromJsonPredioNacionalBody <- fromJSON(jsonPredioNacionalRequest, simplifyVector = FALSE)

resolvePostPredioNacional <- POST(url = urlPredioNacional, body = fromJsonPredioNacionalBody, encode = "json")

predioNacional <- content(resolvePostPredioNacional,"text")

write(predioNacional,paste("prediosNacionales/PredioNacional-",comuna,"-",manzana,"-",predio,".json",sep = ""))
}
#options(encodingencoding  = "utf8")
jsonPredioNacional <- jsonlite::fromJSON(paste("prediosNacionales/PredioNacional-",comuna,"-",manzana,"-",predio,".json",sep = ""))



