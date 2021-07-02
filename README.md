Similarity, uniqueness of Swedish radio stations
================
Martin Rydén

See **radio.R** for full script including data scraping. Presented data
is from past 7 days (July 2nd). Song identity is assumed based on name -
different songs with same name will be counted as the same. Scraped data
may be incorrect due to spelling variants, missing data, incomplete
sources etc. Only publicly available data is
used.

## How many songs were played?

#### Total number of songs (including duplicates) played between 2021-06-26 and 2021-07-02

| Station         | Number of songs |
| :-------------- | --------------: |
| Din Gata        |            5376 |
| P3              |            3548 |
| P4              |            2452 |
| Mix Megapol     |            2319 |
| RixFM           |            2295 |
| Lugna Favoriter |            2263 |
| Bandit Rock     |            1954 |
| P2              |            1910 |
| NRJ             |            1883 |
| Rockklassiker   |            1803 |

## Uniqueness

#### Percentage of unique songs (within stations) – low % means high repetitiveness

| Station         | Unique songs | All songs | % unique |
| :-------------- | -----------: | --------: | -------: |
| P2              |          908 |      1910 |       48 |
| P4              |          848 |      2452 |       35 |
| Rockklassiker   |          522 |      1803 |       29 |
| P3              |          996 |      3548 |       28 |
| Bandit Rock     |          499 |      1954 |       26 |
| NRJ             |          366 |      1883 |       19 |
| Mix Megapol     |          370 |      2319 |       16 |
| Lugna Favoriter |          345 |      2263 |       15 |
| Din Gata        |          693 |      5376 |       13 |
| RixFM           |          278 |      2295 |       12 |

## Similarity

#### What radio stations played the same songs the most?

![Counts of same song being played between sets of stations, highest
degree of similarity between P3 and
P4.](radio_files/figure-gfm/unnamed-chunk-4-1.png)

## Similarity heatmap

<div class="figure">

<img src="radio_files/figure-gfm/unnamed-chunk-5-1.png" alt="Similarity heatmap based on counts of same song played between sets of radio stations. Log-transformed and centered plots to emphasize dissimilarity." width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-5-2.png" alt="Similarity heatmap based on counts of same song played between sets of radio stations. Log-transformed and centered plots to emphasize dissimilarity." width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-5-3.png" alt="Similarity heatmap based on counts of same song played between sets of radio stations. Log-transformed and centered plots to emphasize dissimilarity." width="50%" />

<p class="caption">

Similarity heatmap based on counts of same song played between sets of
radio stations. Log-transformed and centered plots to emphasize
dissimilarity.

</p>

</div>

## Timepoint analysis

#### Are certain songs played at a certain time?

For each group of stations, we investigate their shared top 12 songs and
plot them as ridge plots
(density/24h).

<img src="radio_files/figure-gfm/unnamed-chunk-6-1.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-6-2.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-6-3.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-6-4.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-6-5.png" width="50%" />
