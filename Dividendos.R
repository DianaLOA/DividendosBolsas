
#rm(list = ls())
#install.packages('httr')

library(httr)

library(jsonlite)



####### lista de Direcciones Regionales

dividendosFinales <- data.frame()



int = 1



fecha = '2019-04-18'

pagina = int

int <- int+1

requestAjax = '1'



url <- paste('http://www.bolsadesantiago.com/mercado/Paginas/dividendos.aspx?RequestAjax=',requestAjax,'&hdnPag=',pagina,'&NEMO=&fechaPagoIni=',fecha,sep = "")



print(url)



jsonRequest <- '{}'



fromJsonBody <- fromJSON(jsonRequest, simplifyVector = FALSE)



listDireccionesRegionales <- content(POST(url = url, body = fromJsonBody, encode = "json"),"text")



jsonDireccionesRegionales <- jsonlite::fromJSON(listDireccionesRegionales)



dfDividendos <- as.data.frame(jsonDireccionesRegionales$dividendos)



length(dfDividendos)





while(length(dfDividendos)>0){
  
  fecha = '2019-04-18'
  
  pagina = int
  
  int <- int+1
  
  requestAjax = '1'
  
  
  
  url <- paste('http://www.bolsadesantiago.com/mercado/Paginas/dividendos.aspx?RequestAjax=',requestAjax,'&hdnPag=',pagina,'&NEMO=&fechaPagoIni=',fecha,sep = "")
  
  
  
  print(url)
  
  
  
  jsonRequest <- '{}'
  
  
  
  fromJsonBody <- fromJSON(jsonRequest, simplifyVector = FALSE)
  
  
  
  listDireccionesRegionales <- content(POST(url = url, body = fromJsonBody, encode = "json"),"text")
  
  
  
  jsonDireccionesRegionales <- jsonlite::fromJSON(listDireccionesRegionales)
  
  
  
  dfDividendos <- as.data.frame(jsonDireccionesRegionales$dividendos)
  
  
  
  length(dfDividendos)
  
}





for(d in jsonDireccionesRegionales$dividendos$Nemo){
  
  print(d)
  
}












