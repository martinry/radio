
# Collect data ----

library(data.table)
library(dplyr)
library(xml2)
library(rvest)
library(purrr)
library(magrittr)

# Fetch from onlineradiobox.com

stations <- data.table(c("banditrock", "rix", "lugnafavoriter", "mixmegapol", "rockklassiker", "nrj"),
					   c("Bandit Rock", "RixFM", "Lugna Favoriter", "Mix Megapol", "Rockklassiker", "NRJ"))

get_url <- function(x, i) {
	paste0("https://onlineradiobox.com/se/", x, "/playlist/", i)
}

get_table <- function(wurl) {
	wnodes <- wurl %>%
		read_html %>% 
		html_table
	
	wnodes[[1]]
}

days <- 0:6

combined <- data.table()

for(m in 1:stations[, .N]){
	for(i in days) {
		wurl <- get_url(stations$V1[m], i)
		
		tab <- get_table(wurl)
		
		tab$X1 <- sub("Live", format(Sys.time(), "%H:%M"), tab$X1)
		tab$X3 <- stations$V2[m]
		combined <- rbindlist(list(combined, tab), fill = T)
	}
}

names(combined) <- c("Timestamp", "Title", "Station")

# Fetch from sverigesradio.se

dates <- c("2021-07-02", "2021-07-01", "2021-06-30", "2021-06-29", "2021-06-28", "2021-06-27", "2021-06-26")

# programid:
# Din Gata: 2576
# P2:		2562
# P3:		164
# P4:		207
programid <- data.table("Station" = c("Din Gata", "P2", "P3", "P4"), "id" =  c("2576", "2562", "164", "207"))

get_url <- function(x, i) {
	paste0("https://sverigesradio.se/latlista.aspx?programid=", x, "&date=", i)
}

get_table <- function(wurl) {
	wnodes <- wurl %>%
		read_html %>% 
		html_nodes("ul") %>% 
		purrr::map_df(~{
			tibble::tibble(
				Timestamp = html_nodes(.x, '.track-list-item__time-wrapper') %>% xml_contents() %>% as.character() %>% trimws(),
				Title = html_nodes(.x, '.track-list-item__title > .heading') %>% xml_contents() %>% as.character() %>% trimws()
				)
		})
	}



for(m in 1:programid[, .N]) {
	for(i in dates) {
		tab <- get_url(programid[m]$id, i) %>% get_table()
		
		tab$Station <- programid[m]$Station
		
		names(tab) <- c("Timestamp", "Title", "Station")
		
		tab$Timestamp <- sub("\\.", ":", tab$Timestamp)
		
		combined <- rbindlist(list(combined, tab), fill = T)
	}
}

# Clean up

to_remove <- c("STOP AD BREAK", "AIS AD BREAK", "ADBREAK INSERT")
combined <- combined[!(Title %in% to_remove)]

# Song - Artist
song_artist <- c("NRJ", "Rockklassiker")
combined[Station %in% song_artist]$Title %<>% sub(" - .*", "", .) %>% tolower()

# Artist - Song
combined[!(Station %in% song_artist)]$Title %<>% sub(".* - ", "", .) %>% tolower()

# Write to file ----
fwrite(combined, file = "~/radio/data/combined.csv")

# Analysis ----
count_by_station <- combined[, .N, by = "Station"]

#			  Station    N
#	1:     Bandit Rock 2242
#	2:           RixFM 2646
#	3: Lugna Favoriter 2586
#	4:     Mix Megapol 2657
#	5:   Rockklassiker 2073
#	6:             NRJ 2095
#	7:        Din Gata 6098
#	8:              P2 2278
#	9:              P3 4150
#	10:             P4 2956

unique_by_station <- unique(combined, by = c("Station", "Title"))

unique_by_station <- unique_by_station[, .N, by = "Station"]

unique_by_station$Total <- count_by_station$N

# Ratio = percent unique songs i.e. measure of uniqueness
unique_by_station$Ratio <- unique_by_station$N/unique_by_station$Total * 100

# Group songs by Station
songs_by_group <- combined[,list(list(unique(Station))), by="Title"]

# Which songs have been played by more than one station?
songs_by_group <- songs_by_group[lengths(songs_by_group$V1) > 1]

dt = rbindlist(
	lapply(songs_by_group$V1, function(x) data.table(t(x))),
	fill = TRUE
)

combs <- t(combn(sort(na.omit(unique(unlist(dt)))), 2))
freqs <- apply(combs, 1, function(C) {
	sum(apply(dt, 1, function(a) all(C %in% a, na.rm = TRUE)))
})
combsDF <- as.data.frame(combs)
combsDF$freq <- freqs
combsDF

combsnew <- data.table(paste0(combsDF$V1, " - ", combsDF$V2), combsDF$freq)

combsnew$setby <- combsDF$V1

library(ggplot2)
library(ggthemes)
library(RColorBrewer)

ggplot(combsnew, aes(x = V1, y = V2, fill = setby)) +
	scale_fill_manual(values = brewer.pal(n = 10, name = "Set3"), name = "") +
	xlab("Stations") + ylab("# times played same song (i.e. similarity)") +
	coord_flip() +
	geom_bar(stat = "identity") +
	ggthemes::theme_few()

library(pheatmap)

M <- reshape2::dcast(combsDF, V2~V1, value.var="freq")

rownames(M) <- M$V2
M <- M[, 2:ncol(M)]

M <- M[ , order(names(M))]
M <- M[order(rownames(M)),]

pheatmap(M, cluster_rows=F, cluster_cols=F, na_col="white", main = "Raw counts")
pheatmap(log10(M+1e-2), cluster_rows=F, cluster_cols=F, na_col="white", main = "log10 counts")
pheatmap(scale(M, center = T, scale = F), cluster_rows=F, cluster_cols=F, na_col="white", main = "Centered counts")



combined$time <- as.POSIXct(strptime(combined$Timestamp, format = "%H:%M")) 

library(ggridges)
library(scales)

lims <- as.POSIXct(strptime(c("00:00", "23:59"), 
							format = "%H:%M"))

ggplot(combined, aes(x = time, y = Station, fill = Station)) + geom_density_ridges(scale = 1) +
	scale_x_datetime(breaks = date_breaks("4 hours"), labels = date_format("%H:%M")) +
	scale_fill_manual(values = brewer.pal(n = 10, name = "Set3"), name = "")

joy_plot <- function(stations) {
	combined_top <- combined[Station %in% stations]
	combined_top_titles <- combined_top[, .N, by = "Title"]
	combined_top_titles <- combined_top_titles[order(N, decreasing = T)][1:12]
	combined_top <- combined_top[Title %in% combined_top_titles$Title]
	combined_top$Title <- as.factor(combined_top$Title)
	combined_top$Station <- as.factor(combined_top$Station)
	
	ggplot(combined_top, aes(x = time, y = Title, fill = Title, height = ..scaled..)) +
		geom_density_ridges(stat = "density", trim = F, scale = 0.6) +
		scale_x_datetime(breaks = date_breaks("4 hours"), labels = date_format("%H:%M"), limits = lims) +
		scale_fill_manual(values = brewer.pal(n = 12, name = "Set3"), name = "") +
		
		guides(fill = F) +
		theme_clean() +
		theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
		facet_grid(~ Station)
}

joy_plot(c("P3", "P4", "NRJ", "RixFM", "Mix Megapol"))
joy_plot(c("P3", "Din Gata"))
joy_plot(c("NRJ", "RixFM"))
joy_plot(c("Rockklassiker", "Bandit Rock"))
joy_plot(c("Lugna Favoriter", "NRJ", "P4", "Mix Megapol"))
joy_plot("P2")
