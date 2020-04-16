library("ropenaq")
library("ggplot2")
library("dplyr")
library("viridis")

tbHanoi <- aq_measurements(city = "Hanoi", parameter = "pm25", date_from = as.character(Sys.Date()-1), limit = 1000)

tbJakarta <- aq_measurements(city = "Jakarta", parameter = "pm25", date_from = as.character(Sys.Date()-1), limit = 1000)

tbChennai <- aq_measurements(city = "Chennai", location = "US+Diplomatic+Post%3A+Chennai", parameter = "pm25", date_from = as.character(Sys.Date()-1), limit = 1000)


tbPM <- rbind(tbHanoi,
              tbJakarta,
              tbChennai)
tbPM <- filter(tbPM, value >= 0)

ggplot() + geom_line(data = tbPM,
                     aes(x = dateLocal, y = value, colour = location),
                     size = 1.5) +
  ylab(expression(paste("PM2.5 concentration (", mu, "g/",m^3,")"))) +
  theme(text  =  element_text(size = 15)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_viridis(discrete = TRUE)

tbIndia <- aq_measurements(country = "IN", city = "Delhi", 
                           location = "US+Diplomatic+Post%3A+New+Delhi",
                           parameter = "pm25",
                           date_from = as.character(Sys.Date()-1), limit = 1000)
tbIndia <- filter(tbIndia, value >= 0)
ggplot() + geom_line(data = tbIndia,
                     aes(x = dateLocal, y = value),
                     size = 1.5) +
  ylab(expression(paste("PM2.5 concentration (", mu, "g/",m^3,")"))) +
  theme(text  =  element_text(size = 15))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

dataGeo <- aq_locations()
dataGeo <- filter(dataGeo, location != "Test Prueba", location != "PA")


library("rworldmap")

worldMap <- map_data(map="world")

gg <- ggplot() + geom_map(data=worldMap, map=worldMap,
                          aes(map_id=region, x=long, y=lat),
                          fill = "grey60")  +
  geom_point(data = dataGeo, aes(x=longitude, y=latitude), size=1, col = "#EE9F8E") +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none",
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())+
  ggtitle("OpenAQ data sources with geographical coordinates") +
  theme(plot.title = element_text(lineheight=1, face="bold"))

gg



