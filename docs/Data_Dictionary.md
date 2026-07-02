# Data Dictionary

**Project:** A&R Intelligence Platform

**Version:** 0.1.1

**Last Updated:** June 2026

---

## Overview

The Data Dictionary serves as the main reference point for all data entities, attributes, relationships, and metadata used within the A&R Intelligence Platform.

This document defines the structure of the platform's data before implementation in PostgreSQL. It is intended to ensure consistency, maintainability, and transparency during the development process.

The Data Dictionary is not a static document and will evolve as new features, data sources, and machine learning models are added to the platform.

## Entities

1. Artist
2. Song
3. Album
4. Label
5. Genre
6. Artist Genre
7. Song Genre
8. Album Genre
9. Audio Feature
10. Streaming Platform
11. Streaming History
12. Social Platform
13. Social Metrics
14. Lyrics
15. Tour Event
16. Media Outlet
17. Media Coverage
18. Playlist Appearance

---

# Entity: Artist

## Description

The Artist entity represents a musical artist or band tracked by the A&R Intelligence Platform.

It serves as the central entity within the platform and provides the foundation for connecting artist-related information, including songs, albums, streaming metrics, social media activity, playlists, touring history, news, and predictive analytics.

## Purpose

The Artist entity provides a unique, persistent representation of every artist and band analyzed by the platform. It serves as the primary reference point for all artist-level data and enables the integration of information collected from multiple external sources into a single profile.

### Related Entities

- Label
- Genre

## Potential Data Sources

- Spotify Web API
- MusicBrainz
- Genius API
- Last.fm API
- YouTube Data API
- Songkick API
- Setlist.fm API

## Attributes

| Attribute          | Data Type | Nullable | Source      | Used in ML | Description                                                                                       |
|--------------------|-----------|----------|-------------|------------|---------------------------------------------------------------------------------------------------|
| artist_id          | BIGINT    | No       | Internal    | No         | Unique internal identifier.                                                                       |
| artist_name        | TEXT      | No       | Spotify     | No         | Official artist name.                                                                             |
| spotify_artist_id  | TEXT      | No       | Spotify     | No         | Spotify unique identifier.                                                                        |
| artist_type        | TEXT      | No       | Derived     | Yes        | Solo, duo, band, etc.                                                                             |
| city               | TEXT      | Yes      | MusicBrainz | Yes        | City of origin of the band or artist                                                              |
| state_province     | TEXT      | Yes      | MusicBrainz | Yes        | State or province of origin of the band or artist                                                 |
| country            | TEXT      | Yes      | MusicBrainz | Yes        | Country of origin of the band or artist                                                           |
| year_formed        | INTEGER   | Yes      | MusicBrainz | Yes        | Year the artist or band was formed                                                                |
| is_active          | BOOLEAN   | Yes      | Derived     | Yes        | Indicates if artist is currently releasing music                                                  |
| current_label_id   | BIGINT    | Yes      | Derived     | Yes        | References the artist's current record label. NULL indicates the artist is currently independent. |

## Design Notes

- The Artist entity intentionally stores only relatively stable information.
- Time-varying information such as streaming metrics, followers, and popularity scores will be stored in separate entities.
- Albums, songs, genres, labels, and tour history are modeled separately to reduce redundancy and improve flexibility.

## Future Considerations

The following attributes may be considered in future versions of the platform:

- Artist aliases
- Official website
- Management company
- Booking agency
- Years active (range)
- Pronouns
- Biography
- Photos

---

# Entity: Song

## Description

The Song entity represents an individual musical recording tracked by the A&R Intelligence Platform.

It serves as the primary representation of a recorded work and provides the foundation for connecting song-related information, including albums, artists, genres, lyrics, audio features, streaming metrics, playlist appearances, and predictive analytics.

## Purpose

The Song entity provides a unique, persistent representation of every musical recording analyzed by the platform. It serves as the primary reference point for all song-level data and enables the integration of information collected from multiple external sources into a single profile.

### Related Entities

- Artist
- Album
- Genre

## Potential Data Sources

- Spotify Web API
- MusicBrainz
- Genius API
- Last.fm API
- YouTube Data API

## Attributes

| Attribute        | Data Type | Nullable | Source   | Used in ML | Description                                                |
|------------------|-----------|----------|----------|------------|------------------------------------------------------------|
| song_id          | BIGINT    | No       | Internal | No         | Unique internal identifier.                                |
| song_title       | TEXT      | No       | Spotify  | No         | Official song title.                                       |
| spotify_track_id | TEXT      | No       | Spotify  | No         | Spotify unique track identifier.                           |
| isrc             | TEXT      | Yes      | Spotify  | No         | International Standard Recording Code.                     |
| release_date     | DATE      | Yes      | Spotify  | Yes        | Official release date of the recording.                    |
| duration_ms      | INTEGER   | No       | Spotify  | Yes        | Song duration in milliseconds.                             |
| track_number     | INTEGER   | Yes      | Spotify  | No         | Position on the album.                                     |
| disc_number      | INTEGER   | Yes      | Spotify  | No         | Disc number for multi-disc releases.                       |
| is_explicit      | BOOLEAN   | Yes      | Spotify  | Yes        | Indicates whether the recording contains explicit content. |

## Design Notes

- The Song entity intentionally stores only relatively stable information.
- Audio features are modeled separately because they describe musical characteristics rather than song identity.
- Streaming history, playlist appearances, and popularity metrics are stored separately as they change over time.
- Lyrics are stored separately to support text analysis and natural language processing.

## Future Considerations

The following enhancements may be considered in future versions of the Song entity:

- Alternative song titles
- Recording version (live, acoustic, remix, etc.)
- Language
- Producer credits
- Songwriter credits

---

# Entity: Album

## Description

The Album entity represents a musical release tracked by the A&R Intelligence Platform.

It serves as the primary representation of an album, EP, single release, compilation, or other collection of recordings and provides the foundation for connecting album-related information, including artists, songs, streaming metrics, artwork, and predictive analytics.

## Purpose

The Album entity provides a unique, persistent representation of every musical release analyzed by the platform. It serves as the primary reference point for all album-level data and enables the integration of information collected from multiple external sources into a single profile.

### Related Entities

- Artist
- Genre

## Potential Data Sources

- Spotify Web API
- MusicBrainz
- Last.fm API
- YouTube Data API

## Attributes

| Attribute        | Data Type | Nullable | Source   | Used in ML | Description                          |
|------------------|-----------|----------|----------|------------|--------------------------------------|
| album_id         | BIGINT    | No       | Internal | No         | Unique internal identifier.          |
| album_title      | TEXT      | No       | Spotify  | No         | Official album title.                |
| spotify_album_id | TEXT      | No       | Spotify  | No         | Spotify unique album identifier.     |
| album_type       | TEXT      | No       | Spotify  | Yes        | Album, EP, single, compilation, etc. |
| release_date     | DATE      | Yes      | Spotify  | Yes        | Official release date.               |
| total_tracks     | INTEGER   | Yes      | Spotify  | Yes        | Number of tracks on the release.     |
| album_art_url    | TEXT      | Yes      | Spotify  | No         | URL to the album artwork.            |
| label_id         | BIGINT    | Yes      | Spotify  | Yes        | Label credited for the release.      |

## Design Notes

- The Album entity intentionally stores only relatively stable information.
- Individual songs are modeled separately to allow song-level analysis.
- Streaming metrics are stored separately because they change over time.
- Album artwork is stored as a URL rather than an image to reduce storage requirements.

## Future Considerations

The following enhancements may be considered in future versions of the Album entity:

- Deluxe edition indicator
- Remaster indicator
- UPC
- Copyright information
- Producer credits
- Recording location

---

# Entity: Label

## Description

The Label entity represents a record label tracked by the A&R Intelligence Platform.

It serves as the primary representation of organizations responsible for signing, developing, distributing, and promoting musical artists and their releases. The Label entity provides the foundation for connecting artists, albums, industry relationships, and predictive analytics.

## Purpose

The Label entity provides a unique, persistent representation of every record label analyzed by the platform. It enables the platform to associate artists and releases with the organizations responsible for their distribution and development while supporting A&R analysis and industry insights.

### Related Entities

- Artist
- Album

## Potential Data Sources

- MusicBrainz
- Discogs
- Spotify Web API
- Official Label Websites

## Attributes

| Attribute            | Data Type | Nullable | Source           | Used in ML | Description                                      |
|----------------------|-----------|----------|------------------|------------|--------------------------------------------------|
| label_id             | BIGINT    | No       | Internal         | No         | Unique internal identifier.                      |
| label_name           | TEXT      | No       | MusicBrainz      | No         | Official record label name.                      |
| musicbrainz_label_id | TEXT      | Yes      | MusicBrainz      | No         | MusicBrainz unique label identifier.             |
| country              | TEXT      | Yes      | MusicBrainz      | Yes        | Country where the label is headquartered.        |
| city                 | TEXT      | Yes      | MusicBrainz      | Yes        | City where the label is headquartered.           |
| year_founded         | INTEGER   | Yes      | MusicBrainz      | Yes        | Year the label was established.                  |
| is_active            | BOOLEAN   | Yes      | Derived          | Yes        | Indicates whether the label is currently active. |
| official_website     | TEXT      | Yes      | Official Website | No         | Official website of the record label.            |

## Design Notes

- The Label entity intentionally stores only relatively stable organizational information.
- Artists and albums are modeled separately to allow historical tracking of label affiliations.
- Organizational changes, acquisitions, and ownership structures may be modeled separately in future versions.

## Future Considerations

The following enhancements may be considered in future versions of the Label entity:

- Parent company
- Subsidiary labels
- Distributor
- Logo
- Social media accounts
- Headquarters address
- Founders

---

# Entity: Genre

## Description

The Genre entity represents a musical genre or subgenre tracked by the A&R Intelligence Platform.

It serves as the primary representation of musical classifications and provides the foundation for organizing artists, songs, albums, and similarity analyses based on musical style.

## Purpose

The Genre entity provides a unique, persistent representation of musical genres used throughout the platform. It enables consistent categorization of artists and recordings while supporting recommendation systems, similarity analysis, discovery, and machine learning.

### Related Entities

- Artist
- Song
- Album

## Potential Data Sources

- Spotify Web API
- MusicBrainz
- Discogs
- Last.fm

## Attributes

| Attribute       | Data Type | Nullable | Source   | Used in ML | Description                                 |
|-----------------|-----------|----------|----------|------------|---------------------------------------------|
| genre_id        | BIGINT    | No       | Internal | No         | Unique internal identifier.                 |
| genre_name      | TEXT      | No       | Spotify  | Yes        | Official genre or subgenre name.            |
| parent_genre_id | BIGINT    | Yes      | Internal | Yes        | References the parent genre, if applicable. |
| description     | TEXT      | Yes      | Internal | No         | Brief description of the musical style.     |

## Design Notes

- Genres are modeled as their own entity to ensure consistent classification across artists, albums, and songs.
- A genre may optionally belong to a broader parent genre, allowing hierarchical organization.
- Artists, songs, and albums may each be associated with multiple genres through relationship tables.

## Future Considerations

The following enhancements may be considered in future versions of the Genre entity:

- Genre popularity
- Example artists
- Origin year
- Country of origin
- Typical BPM range
- Typical instruments

# Entity: Artist Genre

## Description

The Artist Genre entity represents the association between artists and their musical genres.

It resolves the many-to-many relationship between Artist and Genre, allowing artists to be classified under multiple genres while enabling each genre to be associated with multiple artists.

## Purpose

The Artist Genre entity provides a standardized relationship between artists and genres throughout the platform. It enables flexible genre classification while maintaining database normalization and supporting genre-based analytics, recommendations, and machine learning.

### Related Entities

- Artist
- Genre

## Potential Data Sources

- Derived

## Attributes

| Attribute | Data Type | Nullable | Source   | Used in ML | Description                       |
|-----------|-----------|----------|----------|------------|-----------------------------------|
| artist_id | BIGINT    | No       | Internal | No         | References the associated artist. |
| genre_id  | BIGINT    | No       | Internal | No         | References the associated genre.  |

## Design Notes

- Artist Genre is a junction table used to resolve the many-to-many relationship between Artist and Genre.
- Each record represents a single artist-genre association.
- The combination of artist_id and genre_id should be unique to prevent duplicate relationships.

## Future Considerations

The following enhancements may be considered in future versions of the Artist Genre entity:

- Primary genre indicator
- Confidence score
- Genre source

# Entity: Song Genre

## Description

The Song Genre entity represents the association between songs and their musical genres.

It resolves the many-to-many relationship between Song and Genre, allowing songs to be classified under multiple genres while enabling each genre to be associated with multiple songs.

## Purpose

The Song Genre entity provides a standardized relationship between songs and genres throughout the platform. It enables flexible genre classification while maintaining database normalization and supporting song-level analytics, similarity analysis, recommendation systems, and machine learning.

### Related Entities

- Song
- Genre

## Potential Data Sources

- Derived

## Attributes

| Attribute | Data Type | Nullable | Source   | Used in ML | Description                      |
|-----------|-----------|----------|----------|------------|----------------------------------|
| song_id   | BIGINT    | No       | Internal | No         | References the associated song.  |
| genre_id  | BIGINT    | No       | Internal | No         | References the associated genre. |

## Design Notes

- Song Genre is a junction table used to resolve the many-to-many relationship between Song and Genre.
- Each record represents a single song-genre association.
- The combination of song_id and genre_id should be unique to prevent duplicate relationships.

## Future Considerations

The following enhancements may be considered in future versions of the Song Genre entity:

- Primary genre indicator
- Confidence score
- Genre source

# Entity: Album Genre

## Description

The Album Genre entity represents the association between albums and their musical genres.

It resolves the many-to-many relationship between Album and Genre, allowing albums to be classified under multiple genres while enabling each genre to be associated with multiple albums.

## Purpose

The Album Genre entity provides a standardized relationship between albums and genres throughout the platform. It enables flexible genre classification while maintaining database normalization and supporting album-level analytics and recommendation systems.

### Related Entities

- Album
- Genre

## Potential Data Sources

- Derived

## Attributes

| Attribute | Data Type | Nullable | Source   | Used in ML | Description                      |
|-----------|-----------|----------|----------|------------|----------------------------------|
| album_id  | BIGINT    | No       | Internal | No         | References the associated album. |
| genre_id  | BIGINT    | No       | Internal | No         | References the associated genre. |

## Design Notes

- Album Genre is a junction table used to resolve the many-to-many relationship between Album and Genre.
- Each record represents a single album-genre association.
- The combination of album_id and genre_id should be unique to prevent duplicate relationships.

## Future Considerations

The following enhancements may be considered in future versions of the Album Genre entity:

- Primary genre indicator
- Confidence score
- Genre source

---

# Entity: Audio Feature

## Description

The Audio Feature entity represents the measurable acoustic characteristics of a musical recording tracked by the A&R Intelligence Platform.

It provides a quantitative description of how a song sounds and serves as the foundation for similarity analysis, recommendation systems, clustering, predictive analytics, and machine learning.

## Purpose

The Audio Feature entity provides a standardized representation of the musical properties of a recording. It enables objective comparison between songs while supporting advanced analytics, discovery, and predictive modeling.

### Related Entities

- Song

## Potential Data Sources

- Spotify Web API
- Essentia (Future)
- Librosa (Future)

## Attributes

| Attribute        | Data Type | Nullable | Source   | Used in ML | Description                                              |
|------------------|-----------|----------|----------|------------|----------------------------------------------------------|
| audio_feature_id | BIGINT    | No       | Internal | No         | Unique internal identifier.                              |
| song_id          | BIGINT    | No       | Internal | No         | References the associated song.                          |
| danceability     | FLOAT     | Yes      | Spotify  | Yes        | Measure of how suitable a track is for dancing (0–1).    |
| energy           | FLOAT     | Yes      | Spotify  | Yes        | Perceived intensity and activity of the recording (0–1). |
| valence          | FLOAT     | Yes      | Spotify  | Yes        | Musical positiveness conveyed by the recording (0–1).    |
| acousticness     | FLOAT     | Yes      | Spotify  | Yes        | Confidence that the recording is acoustic (0–1).         |
| instrumentalness | FLOAT     | Yes      | Spotify  | Yes        | Likelihood the recording contains no vocals (0–1).       |
| speechiness      | FLOAT     | Yes      | Spotify  | Yes        | Presence of spoken words (0–1).                          |
| liveness         | FLOAT     | Yes      | Spotify  | Yes        | Probability that the recording was performed live (0–1). |
| loudness_db      | FLOAT     | Yes      | Spotify  | Yes        | Average loudness in decibels.                            |
| tempo_bpm        | FLOAT     | Yes      | Spotify  | Yes        | Estimated tempo in beats per minute.                     |
| musical_key      | INTEGER   | Yes      | Spotify  | Yes        | Estimated musical key.                                   |
| musical_mode     | INTEGER   | Yes      | Spotify  | Yes        | Major or minor mode.                                     |
| time_signature   | INTEGER   | Yes      | Spotify  | Yes        | Estimated time signature.                                |

## Design Notes

- Audio features are intentionally modeled separately from the Song entity because they describe acoustic characteristics rather than song identity.
- Most audio features are continuous numerical variables, making them ideal inputs for machine learning models.
- Audio features may originate from Spotify or future feature extraction pipelines developed within the platform.

## Future Considerations

The following enhancements may be considered in future versions of the Audio Feature entity:

- Spectral centroid
- Spectral bandwidth
- Chroma features
- MFCC coefficients
- Harmonic-to-noise ratio
- Rhythm descriptors

---

# Entity: Streaming Platform

## Description

The Streaming Platform entity represents digital music streaming services tracked by the A&R Intelligence Platform.

It serves as the primary representation of streaming platforms from which listening metrics, engagement statistics, and historical performance data are collected.

## Purpose

The Streaming Platform entity provides a standardized representation of digital music services used throughout the platform. It enables consistent collection and comparison of streaming metrics while supporting historical analysis across multiple streaming providers.

### Related Entities

None

## Potential Data Sources

- Internal
- Spotify Web API
- Apple Music API
- YouTube Data API
- Deezer API
- TIDAL API (Future)
- Amazon Music API (Future)

## Attributes

| Attribute        | Data Type | Nullable | Source           | Used in ML | Description                                         |
|------------------|-----------|----------|------------------|------------|-----------------------------------------------------|
| platform_id      | BIGINT    | No       | Internal         | No         | Unique internal identifier.                         |
| platform_name    | TEXT      | No       | Internal         | No         | Name of the streaming platform.                     |
| official_website | TEXT      | Yes      | Official Website | No         | Official website of the streaming platform.         |
| api_available    | BOOLEAN   | No       | Internal         | No         | Indicates whether a public API is available.        |
| is_active        | BOOLEAN   | No       | Internal         | No         | Indicates whether the platform is currently active. |

## Design Notes

- The Streaming Platform entity stores only platform-level information.
- Platform-specific streaming metrics are modeled separately within the Streaming History entity.
- New streaming platforms can be incorporated without requiring structural changes to the database.

## Future Considerations

The following enhancements may be considered in future versions of the Streaming Platform entity:

- Platform logo
- Launch year
- Headquarters
- Country availability
- Monthly active users
- API rate limits

---

---

# Entity: Streaming History

## Description

The Streaming History entity represents historical streaming performance snapshots collected from digital music platforms.

It serves as the foundation for monitoring audience growth, identifying trends, measuring momentum, and supporting predictive analytics by preserving streaming metrics over time.

## Purpose

The Streaming History entity provides a historical record of streaming metrics collected from multiple platforms. It enables longitudinal analysis, trend detection, growth calculations, and machine learning by maintaining time-series observations rather than only current values.

### Related Entities

- Song
- Album
- Artist

## Potential Data Sources

- Spotify Web API
- Apple Music API
- YouTube Data API
- Deezer API
- Chartmetric (Future)

## Attributes

| Attribute            | Data Type | Nullable | Source       | Used in ML | Description                                                 |
|----------------------|-----------|----------|--------------|------------|-------------------------------------------------------------|
| streaming_history_id | BIGINT    | No       | Internal     | No         | Unique internal identifier.                                 |
| song_id              | BIGINT    | No       | Internal     | No         | References the associated song.                             |
| platform_id          | BIGINT    | No       | Internal     | No         | References the streaming platform.                          |
| snapshot_date        | DATE      | No       | Internal     | Yes        | Date the metrics were collected.                            |
| stream_count         | BIGINT    | Yes      | Platform API | Yes        | Total number of streams recorded at the time of collection. |

## Design Notes

- Streaming History is intentionally modeled as a time-series entity to preserve historical observations.
- Historical records should never be overwritten. New observations are stored as additional records.
- Metrics are platform-specific and linked through the Streaming Platform entity.
- The entity is intentionally platform-agnostic, allowing additional streaming services to be incorporated without modifying the schema.

## Future Considerations

The following enhancements may be considered in future versions of the Streaming History entity:

- Regional streaming counts
- Playlist-driven streams
- Daily listener counts
- Platform-specific popularity metrics
- Skip rate
- Save rate
- Listener demographics

---

# Entity: Social Platform

## Description

The Social Platform entity represents social media platforms tracked by the A&R Intelligence Platform.

It serves as the primary representation of social media services from which artist engagement and audience metrics are collected.

## Purpose

The Social Platform entity provides a standardized representation of social media platforms used throughout the system. It enables consistent collection and comparison of social metrics while allowing new platforms to be incorporated without modifying the database schema.

### Related Entities

None

## Potential Data Sources

- Internal
- Instagram Graph API
- TikTok API
- YouTube Data API
- X API
- Facebook Graph API

## Attributes

| Attribute          | Data Type | Nullable | Source           | Used in ML | Description                                         |
|--------------------|-----------|----------|------------------|------------|-----------------------------------------------------|
| social_platform_id | BIGINT    | No       | Internal         | No         | Unique internal identifier.                         |
| platform_name      | TEXT      | No       | Internal         | No         | Name of the social media platform.                  |
| official_website   | TEXT      | Yes      | Official Website | No         | Official website of the platform.                   |
| api_available      | BOOLEAN   | No       | Internal         | No         | Indicates whether a public API is available.        |
| is_active          | BOOLEAN   | No       | Internal         | No         | Indicates whether the platform is currently active. |

## Design Notes

- The Social Platform entity stores only platform-level information.
- Platform-specific engagement metrics are modeled separately within the Social Metrics entity.
- New social media platforms can be incorporated without requiring structural changes to the database.

## Future Considerations

The following enhancements may be considered in future versions of the Social Platform entity:

- Platform logo
- Launch year
- Headquarters
- API rate limits

---

# Entity: Social Metrics

## Description

The Social Metrics entity represents historical snapshots of an artist's audience size and engagement across social media platforms.

It serves as the foundation for monitoring audience growth, measuring engagement, identifying trends, and supporting predictive analytics through time-series social media data.

## Purpose

The Social Metrics entity provides a historical record of artist engagement across multiple social media platforms. It enables longitudinal analysis, growth calculations, trend detection, and machine learning by preserving audience metrics collected over time.

### Related Entities

- Artist

## Potential Data Sources

- Instagram Graph API
- TikTok API
- YouTube Data API
- X API
- Facebook Graph API

## Attributes

| Attribute          | Data Type | Nullable | Source       | Used in ML | Description                                          |
|--------------------|-----------|----------|--------------|------------|------------------------------------------------------|
| social_metric_id   | BIGINT    | No       | Internal     | No         | Unique internal identifier.                          |
| artist_id          | BIGINT    | No       | Internal     | No         | References the associated artist.                    |
| social_platform_id | BIGINT    | No       | Internal     | No         | References the associated social media platform.     |
| snapshot_date      | DATE      | No       | Internal     | Yes        | Date the metrics were collected.                     |
| follower_count     | BIGINT    | Yes      | Platform API | Yes        | Total number of followers at the time of collection. |
| following_count    | BIGINT    | Yes      | Platform API | Yes        | Total number of accounts followed.                   |
| total_posts        | BIGINT    | Yes      | Platform API | Yes        | Total published posts.                               |
| total_likes        | BIGINT    | Yes      | Platform API | Yes        | Total likes received, when available.                |
| total_comments     | BIGINT    | Yes      | Platform API | Yes        | Total comments received, when available.             |

## Design Notes

- Social Metrics is intentionally modeled as a time-series entity to preserve historical observations.
- Historical records should never be overwritten. New observations are stored as additional records.
- Metrics are platform-specific and linked through the Social Platform entity.
- Platform-specific metrics that are unavailable should remain NULL rather than estimated.

## Future Considerations

The following enhancements may be considered in future versions of the Social Metrics entity:

- Engagement rate
- Shares
- Video views
- Story views
- Livestream statistics
- Audience demographics
- Geographic audience distribution

---

# Entity: Lyrics

## Description

The Lyrics entity represents the lyrical content associated with a musical recording tracked by the A&R Intelligence Platform.

It serves as the foundation for lyrical analysis, natural language processing, sentiment analysis, thematic classification, and other text-based analytics while maintaining metadata about lyric availability and sources.

## Purpose

The Lyrics entity provides a standardized representation of lyrical metadata and, where permitted, lyrical content associated with songs. It enables future text analytics, machine learning, and artist discovery while respecting licensing and copyright considerations.

### Related Entities

- Song

## Potential Data Sources

- Genius API
- Musixmatch API
- LyricFind (Licensed)
- Official Artist Websites

## Attributes

| Attribute        | Data Type | Nullable | Source   | Used in ML | Description                                               |
|------------------|-----------|----------|----------|------------|-----------------------------------------------------------|
| lyrics_id        | BIGINT    | No       | Internal | No         | Unique internal identifier.                               |
| song_id          | BIGINT    | No       | Internal | No         | References the associated song.                           |
| language         | TEXT      | Yes      | Derived  | Yes        | Primary language of the lyrics.                           |
| lyrics_available | BOOLEAN   | No       | Derived  | No         | Indicates whether lyrics are available.                   |
| lyrics_source    | TEXT      | Yes      | Internal | No         | Source from which lyrics or lyric metadata were obtained. |
| copyright_status | TEXT      | Yes      | Internal | No         | Indicates licensing or copyright status of the lyrics.    |

## Design Notes

- The Lyrics entity is intentionally separated from the Song entity because lyrical information represents textual content rather than song identity.
- Full lyrical text may not always be stored due to licensing and copyright restrictions.
- Metadata may be stored independently of lyrical content to support future analytics and data collection.

## Future Considerations

The following enhancements may be considered in future versions of the Lyrics entity:

- Full lyrical text (where licensing permits)
- Sentiment analysis
- Emotion classification
- Topic modeling
- Profanity score
- Readability metrics
- Keyword extraction
- AI-generated summaries

---

# Entity: Tour Event

## Description

The Tour Event entity represents an individual live performance tracked by the A&R Intelligence Platform.

It serves as the foundation for monitoring touring activity, geographic reach, venue progression, audience engagement, and live performance history.

## Purpose

The Tour Event entity provides a standardized representation of live performances associated with artists. It enables historical analysis of touring activity, venue growth, geographic expansion, and supports predictive analytics related to artist development.

### Related Entities

- Artist

## Potential Data Sources

- Songkick API
- Bandsintown API
- Setlist.fm API
- Ticketmaster API
- Official Artist Websites

## Attributes

| Attribute      | Data Type | Nullable | Source   | Used in ML | Description                                              |
|----------------|-----------|----------|----------|------------|----------------------------------------------------------|
| tour_event_id  | BIGINT    | No       | Internal | No         | Unique internal identifier.                              |
| artist_id      | BIGINT    | No       | Internal | No         | References the associated artist.                        |
| event_name     | TEXT      | Yes      | Songkick | No         | Official name of the event or tour stop.                 |
| venue_name     | TEXT      | Yes      | Songkick | Yes        | Venue where the performance occurred.                    |
| city           | TEXT      | Yes      | Songkick | Yes        | City where the performance took place.                   |
| state_province | TEXT      | Yes      | Songkick | Yes        | State or province where the performance took place.      |
| country        | TEXT      | Yes      | Songkick | Yes        | Country where the performance took place.                |
| event_date     | DATE      | No       | Songkick | Yes        | Date of the performance.                                 |
| festival_name  | TEXT      | Yes      | Songkick | Yes        | Festival associated with the performance, if applicable. |
| headliner      | BOOLEAN   | Yes      | Derived  | Yes        | Indicates whether the artist was the headlining act.     |

## Design Notes

- Tour Event is intentionally modeled as an event-based entity because live performances occur at specific locations and times.
- Each record represents a single performance rather than an entire tour.
- Geographic information is stored to support regional trend analysis and touring patterns.
- Additional performance statistics may be incorporated as data sources become available.

## Future Considerations

The following enhancements may be considered in future versions of the Tour Event entity:

- Venue capacity
- Estimated attendance
- Ticket sales
- Ticket sellout status
- Opening acts
- Supporting acts
- Setlist
- Performance duration
- Tour name

# Entity: Media Outlet

## Description

The Media Outlet entity represents organizations that publish music-related content, including news articles, interviews, reviews, podcasts, magazines, blogs, radio stations, and digital media.

It serves as the primary representation of media organizations referenced throughout the A&R Intelligence Platform and provides a standardized source for media coverage records.

## Purpose

The Media Outlet entity provides a unique, persistent representation of media organizations referenced by the A&R Intelligence Platform. It enables consistent identification of publications while reducing redundancy across media coverage records and supporting future media-related analytics.

### Related Entities

- Media Coverage

## Potential Data Sources

- Internal
- Official Media Websites
- Google News API
- GDELT Project

## Attributes

| Attribute        | Data Type | Nullable | Source           | Used in ML | Description                                                                      |
|------------------|-----------|----------|------------------|------------|----------------------------------------------------------------------------------|
| media_outlet_id  | BIGINT    | No       | Internal         | No         | Unique internal identifier.                                                      |
| outlet_name      | TEXT      | No       | Media Source     | No         | Official name of the media outlet or publication.                                |
| outlet_type      | TEXT      | Yes      | Derived          | Yes        | Type of outlet (Magazine, Blog, Podcast, Radio, YouTube Channel, Website, etc.). |
| official_website | TEXT      | Yes      | Official Website | No         | Official website of the media outlet.                                            |
| country          | TEXT      | Yes      | Derived          | Yes        | Country where the media outlet is headquartered.                                 |

## Design Notes

- The Media Outlet entity intentionally stores only relatively stable information.
- Media Coverage records reference Media Outlet rather than repeatedly storing publication names.
- New outlet metadata can be added without modifying existing media coverage records.

## Future Considerations

The following enhancements may be considered in future versions of the Media Outlet entity:

- Monthly readership
- Domain authority
- Social media accounts
- Publication focus
- Founding year
- Headquarters city
- RSS feed URL

---

# Entity: Media Coverage

## Description

The Media Coverage entity represents media mentions, interviews, reviews, announcements, and other forms of industry coverage associated with artists tracked by the A&R Intelligence Platform.

It serves as the foundation for monitoring industry attention, measuring public visibility, identifying emerging trends, and supporting predictive analytics through historical media activity.

## Purpose

The Media Coverage entity provides a historical record of artist appearances across music publications, online media, podcasts, radio, and other industry sources. It enables trend analysis, media momentum tracking, and supports machine learning by preserving media coverage over time.

### Related Entities

- Artist

## Potential Data Sources

- Google News API
- GDELT Project
- Music publication RSS feeds
- Official artist websites
- Podcast directories

## Attributes

| Attribute         | Data Type | Nullable | Source       | Used in ML | Description                                                             |
|-------------------|-----------|----------|--------------|------------|-------------------------------------------------------------------------|
| media_coverage_id | BIGINT    | No       | Internal     | No         | Unique internal identifier.                                             |
| artist_id         | BIGINT    | No       | Internal     | No         | References the associated artist.                                       |
| media_outlet_id   | BIGINT    | No       | Internal     | No         | References the media outlet that published the coverage.                |
| article_title     | TEXT      | No       | Media Source | Yes        | Title of the article or media feature.                                  |
| media_type        | TEXT      | No       | Derived      | Yes        | Type of coverage (News, Review, Interview, Podcast, Radio, Blog, etc.). |
| publication_date  | DATE      | No       | Media Source | Yes        | Date the media coverage was published.                                  |
| article_url       | TEXT      | Yes      | Media Source | No         | URL to the original media coverage.                                     |
| sentiment         | TEXT      | Yes      | Derived      | Yes        | Overall sentiment of the coverage (Positive, Neutral, Negative).        |

## Design Notes

- Media Coverage is intentionally modeled as an event-based entity because each media mention represents a distinct occurrence.
- The entity captures metadata about coverage rather than storing full article content.
- Historical records should never be overwritten, allowing long-term analysis of media attention.
- Sentiment may be manually assigned or generated through future natural language processing techniques.

## Future Considerations

The following enhancements may be considered in future versions of the Media Coverage entity:

- Publication authority score
- Estimated audience reach
- Topic classification
- AI-generated summaries
- Named entity extraction
- Quote extraction
- Mention prominence

---

# Entity: Playlist Appearance

## Description

The Playlist Appearance entity represents the inclusion of a song within a curated or algorithmic playlist tracked by the A&R Intelligence Platform.

It serves as the foundation for monitoring playlist exposure, identifying editorial recognition, measuring audience reach, and supporting predictive analytics through historical playlist activity.

## Purpose

The Playlist Appearance entity provides a historical record of playlist placements across multiple streaming platforms. It enables trend analysis, playlist growth monitoring, and machine learning by preserving playlist appearances over time.

### Related Entities

- Song
- Artist
- Streaming Platform

## Potential Data Sources

- Spotify Web API
- Apple Music API
- Deezer API
- Amazon Music API
- Chartmetric (Future)

## Attributes

| Attribute              | Data Type | Nullable | Source       | Used in ML | Description                                            |
|------------------------|-----------|----------|--------------|------------|--------------------------------------------------------|
| playlist_appearance_id | BIGINT    | No       | Internal     | No         | Unique internal identifier.                            |
| song_id                | BIGINT    | No       | Internal     | No         | References the associated song.                        |
| platform_id            | BIGINT    | No       | Internal     | No         | References the streaming platform.                     |
| playlist_name          | TEXT      | No       | Platform API | Yes        | Name of the playlist.                                  |
| playlist_type          | TEXT      | Yes      | Derived      | Yes        | Editorial, Algorithmic, User-Curated, Radio, etc.      |
| appearance_date        | DATE      | No       | Platform API | Yes        | Date the song was first observed on the playlist.      |
| removal_date           | DATE      | Yes      | Platform API | Yes        | Date the song was removed from the playlist, if known. |
| playlist_followers     | BIGINT    | Yes      | Platform API | Yes        | Number of followers or subscribers to the playlist.    |

## Design Notes

- Playlist Appearance is intentionally modeled as an event-based entity because playlist placements change over time.
- Each record represents a single appearance of a song on a playlist.
- Historical records should never be overwritten, allowing long-term analysis of playlist exposure.
- Playlist-specific metrics may vary between streaming platforms and should remain NULL when unavailable.

## Future Considerations

The following enhancements may be considered in future versions of the Playlist Appearance entity:

- Playlist position
- Estimated playlist reach
- Playlist genre
- Playlist curator
- Playlist popularity score
- Playlist description
- Daily position history
- AI-generated playlist similarity