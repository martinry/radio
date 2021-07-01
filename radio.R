
# Collect data ----

library(data.table)
library(dplyr)
library(xml2)
library(rvest)

# Fetch from onlineradiobox.com

stations <- c("banditrock", "rix", "lugnafavoriter", "mixmegapol", "rockklassiker", "nrj")

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

for(m in stations){
	for(i in days) {
		wurl <- get_url(m, i)
		
		tab <- get_table(wurl)
		tab$X1 <- m
		combined <- rbindlist(list(combined, tab), fill = T)
	}
}

names(combined) <- c("Station", "Song")

# Fetch from sverigesradio.se

dates <- c("2021-07-01", "2021-06-30", "2021-06-29", "2021-06-28", "2021-06-27", "2021-06-26", "2021-06-25")

# programid:
# Din Gata: 2576
# P3:		164
# P4:		207
programid <- c("2576", "164", "207")

get_url <- function(x, i) {
	paste0("https://sverigesradio.se/latlista.aspx?programid=", x, "&date=", i)
}

get_table <- function(wurl) {
	wnodes <- wurl %>%
		read_html %>% 
		html_nodes(".track-list-item__title > .heading") %>% 
		xml_contents() %>% as.character() %>% trimws() -> songs
}


	
tab <- get_url(programid[1], dates[1]) %>% get_table()

for(m in programid) {
	for(i in dates) {
		tab <- get_url(m, i) %>% get_table()
		if(m == "2576") {
			tab <- data.table(rep("Din Gata", length(tab)), tab)
			} else if(m == "164") {
				tab <- data.table(rep("P3", length(tab)), tab)
			} else if(m == "207") {
				tab <- data.table(rep("P4", length(tab)), tab)
			}
		
		names(tab) <- c("Station", "Song")
		
		combined <- rbindlist(list(combined, tab), fill = T)
	}
}

# Clean up

to_remove <- c("STOP AD BREAK", "AIS AD BREAK", "ADBREAK INSERT")

combined <- combined[!(Song %in% to_remove)]

# Song - Artist
combined[Station == "nrj"]$Song <- combined[Station == "nrj"]$Song %>% sub(" - .*", "", .)
combined[Station == "rockklassiker"]$Song <- combined[Station == "rockklassiker"]$Song %>% sub(" - .*", "", .)

# Artist - Song
combined[Station == "rix"]$Song <- combined[Station == "rix"]$Song %>% sub(".* - ", "", .)
combined[Station == "lugnafavoriter"]$Song <- combined[Station == "lugnafavoriter"]$Song %>% sub(".* - ", "", .)
combined[Station == "mixmegapol"]$Song <- combined[Station == "mixmegapol"]$Song %>% sub(".* - ", "", .)
combined[Station == "Din Gata"]$Song <- combined[Station == "Din Gata"]$Song %>% sub(".* - ", "", .)
combined[Station == "P3"]$Song <- combined[Station == "P3"]$Song %>% sub(".* - ", "", .)
combined[Station == "P4"]$Song <- combined[Station == "P4"]$Song %>% sub(".* - ", "", .)
combined[Station == "banditrock"]$Song <- combined[Station == "banditrock"]$Song %>% sub(".* - ", "", .)

combined$Song <- tolower(combined$Song)

# Write to file ----
# fwrite(combined, file = "combined.csv")

# Analysis ----
count_by_station <- combined[, .N, by = "Station"]

# Station    N
# 1:     banditrock 2135
# 2:            rix 2519
# 3: lugnafavoriter 2478
# 4:     mixmegapol 2539
# 5:  rockklassiker 1976
# 6:            nrj 1986
# 7:       Din Gata 2906
# 8:             P3 1977
# 9:             P4 1434

unique_by_station <- unique(combined, by = c("Station", "Song"))

unique_by_station <- unique_by_station[, .N, by = "Station"]

unique_by_station$Total <- count_by_station$N

# Ratio = percent unique songs i.e. measure of uniqueness
unique_by_station$Ratio <- unique_by_station$N/unique_by_station$Total * 100

# Group songs by Station
songs_by_group <- combined[,list(list(unique(Station))), by="Song"]

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
	scale_fill_manual(values = brewer.pal(n = 8, name = "Pastel2"), name = "") +
	xlab("Stations") + ylab("# times played same song (i.e. similarity)") +
	coord_flip() +
	geom_bar(stat = "identity") +
	ggthemes::theme_few()

library(pheatmap)

M <- dcast(combsDF, V2~V1, value.var="freq")

rownames(M) <- M$V2
M <- M[, 2:ncol(M)]

M <- M[ , order(names(M))]
M <- M[order(rownames(M)),]

pheatmap(M, cluster_rows=F, cluster_cols=F, na_col="white", main = "Raw counts")
pheatmap(log10(M), cluster_rows=F, cluster_cols=F, na_col="white", main = "log10 counts")
pheatmap(scale(M, center = T, scale = F), cluster_rows=F, cluster_cols=F, na_col="white", main = "Centered counts")


