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
| Din Gata        |            5664 |
| P3              |            3742 |
| P4              |            2620 |
| Mix Megapol     |            2454 |
| RixFM           |            2415 |
| Lugna Favoriter |            2401 |
| Bandit Rock     |            2073 |
| P2              |            2006 |
| NRJ             |            1992 |
| Rockklassiker   |            1904 |

## Uniqueness

#### Percentage of unique songs (within stations) – low % means high repetitiveness

| Station         | Unique songs | All songs | % unique |
| :-------------- | -----------: | --------: | -------: |
| P2              |          951 |      2006 |       47 |
| P4              |          893 |      2620 |       34 |
| Rockklassiker   |          525 |      1904 |       28 |
| P3              |         1030 |      3742 |       28 |
| Bandit Rock     |          506 |      2073 |       24 |
| NRJ             |          374 |      1992 |       19 |
| Mix Megapol     |          372 |      2454 |       15 |
| Lugna Favoriter |          345 |      2401 |       14 |
| RixFM           |          279 |      2415 |       12 |
| Din Gata        |          697 |      5664 |       12 |

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

#### Pop, miscellaneous

<img src="radio_files/figure-gfm/unnamed-chunk-7-1.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-7-2.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-7-3.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-7-4.png" width="50%" />

#### Classical

![](radio_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

#### Rock

![](radio_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->
