Similarity, uniqueness of Swedish radio stations
================
Martin Rydén

Last updated on: 2021-07-02 17:19:10

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
| Din Gata        |            5800 |
| P3              |            3902 |
| P4              |            2714 |
| Mix Megapol     |            2534 |
| Rix FM          |            2503 |
| Lugna Favoriter |            2490 |
| Retro FM        |            2355 |
| Bandit Rock     |            2150 |
| P2              |            2078 |
| NRJ             |            2055 |
| Rockklassiker   |            1971 |
| Pirate Rock     |            1948 |

## Uniqueness

#### Percentage of unique songs (within stations) – low % means high repetitiveness

| Station         | Unique songs | All songs | % unique |
| :-------------- | -----------: | --------: | -------: |
| P2              |          985 |      2078 |       47 |
| Pirate Rock     |          873 |      1948 |       45 |
| Retro FM        |          971 |      2355 |       41 |
| P4              |          928 |      2714 |       34 |
| Rockklassiker   |          526 |      1971 |       27 |
| P3              |         1058 |      3902 |       27 |
| Bandit Rock     |          508 |      2150 |       24 |
| NRJ             |          378 |      2055 |       18 |
| Mix Megapol     |          372 |      2534 |       15 |
| Lugna Favoriter |          346 |      2490 |       14 |
| Din Gata        |          699 |      5800 |       12 |
| Rix FM          |          279 |      2503 |       11 |

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

<img src="radio_files/figure-gfm/unnamed-chunk-7-1.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-7-2.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-7-3.png" width="50%" />

#### Classical

![](radio_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

#### Rock

![](radio_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

Above plots show shared top 12 songs but has a bias toward stations that
play more songs and is more repetitive. We can reduce the plots to only
show songs that has been played at least a few times on each
station.

#### Pairwise comparisons, shared titles (inclusive)

<img src="radio_files/figure-gfm/unnamed-chunk-11-1.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-11-2.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-11-3.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-11-4.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-11-5.png" width="50%" /><img src="radio_files/figure-gfm/unnamed-chunk-11-6.png" width="50%" />
