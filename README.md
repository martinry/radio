Similarity, uniqueness of Swedish radio stations
================
Martin Rydén

See **radio.R** for full script including data scraping. Presented data
is from past 7 days (July
1st).

## How many songs were played?

#### Total number of songs (including duplicates) played between 2021-06-25 and 2021-07-01

| Station        | Number of songs |
| :------------- | --------------: |
| Din Gata       |            2956 |
| mixmegapol     |            2580 |
| rix            |            2561 |
| lugnafavoriter |            2509 |
| banditrock     |            2174 |
| nrj            |            2019 |
| rockklassiker  |            2010 |
| P3             |            2010 |
| P4             |            1457 |

## Uniqueness

#### Percentage of unique songs (within stations) – low % means high repetitiveness

| Station        | Unique songs | All songs | % unique |
| :------------- | -----------: | --------: | -------: |
| P4             |          996 |      1457 |       68 |
| P3             |         1088 |      2010 |       54 |
| rockklassiker  |          518 |      2010 |       26 |
| Din Gata       |          714 |      2956 |       24 |
| banditrock     |          508 |      2174 |       23 |
| nrj            |          385 |      2019 |       19 |
| mixmegapol     |          375 |      2580 |       15 |
| lugnafavoriter |          346 |      2509 |       14 |
| rix            |          292 |      2561 |       11 |

## Similarity

#### What radio stations played the same songs the most?

![Counts of same song being played between sets of stations, highest
degree of similarity between P3 and
P4.](radio_files/figure-gfm/unnamed-chunk-4-1.png)

## Similarity heatmap

<div class="figure">

<img src="radio_files/figure-gfm/unnamed-chunk-5-1.png" alt="Similarity heatmap based on counts of same song played between sets of radio stations. Log-transformed and centered plots to emphasize dissimilarity." width="40%" /><img src="radio_files/figure-gfm/unnamed-chunk-5-2.png" alt="Similarity heatmap based on counts of same song played between sets of radio stations. Log-transformed and centered plots to emphasize dissimilarity." width="40%" /><img src="radio_files/figure-gfm/unnamed-chunk-5-3.png" alt="Similarity heatmap based on counts of same song played between sets of radio stations. Log-transformed and centered plots to emphasize dissimilarity." width="40%" />

<p class="caption">

Similarity heatmap based on counts of same song played between sets of
radio stations. Log-transformed and centered plots to emphasize
dissimilarity.

</p>

</div>
