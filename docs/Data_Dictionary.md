# Data Dictionary

**Project:** A&R Intelligence Platform

**Version:** 0.1.0

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
6. Audio Features
7. Streaming History
8. Social Metrics
9. Lyrics
10. Tour Event
11. News Article
12. Playlist Appearance

---

# Entity: Artist

## Description

The Artist entity represents a musical artist or band tracked by the A&R Intelligence Platform.

It serves as the central entity within the platform and provides the foundation for connecting artist-related information, including songs, albums, streaming metrics, social media activity, playlists, touring history, news, and predictive analytics.

## Purpose

The Artist entity provides a unique, persistent representation of every artist and band analyzed by the platform. It serves as the primary reference point for all artist-level data and enables the integration of information collected from multiple external sources into a single profile.

## Relationships

### Parent Entities

None

### Child Entities

- Album
- Song
- Streaming History
- Social Metrics
- Tour Events
- News Articles

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

| Attribute          | Data Type | Nullable | Source      | Used in ML | Description                                               |
|--------------------|-----------|----------|-------------|------------|-----------------------------------------------------------|
| artist_id          | BIGINT    | No       | Internal    | No         | Unique internal identifier.                               |
| artist_name        | TEXT      | No       | Spotify     | No         | Official artist name.                                     |
| spotify_artist_id  | TEXT      | No       | Spotify     | No         | Spotify unique identifier.                                |
| artist_type        | TEXT      | No       | Derived     | Yes        | Solo, duo, band, etc.                                     |
| city               | TEXT      | Yes      | MusicBrainz | Yes        | City of origin of the band or artist                      |
| state_province     | TEXT      | Yes      | MusicBrainz | Yes        | State or province of origin of the band or artist         |
| country            | TEXT      | Yes      | MusicBrainz | Yes        | Country of origin of the band or artist                   |
| year_formed        | INTEGER   | Yes      | MusicBrainz | Yes        | Year the artist or band was formed                        |
| is_active          | BOOLEAN   | Yes      | Derived     | Yes        | Indicates if artist is currently releasing music          |
| is_signed          | BOOLEAN   | Yes      | Derived     | Yes        | Indicates if artist is currently signed to a record label |

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

## Relationships

### Child Entities

- Audio Features
- Streaming History
- Playlist Appearances
- Lyrics

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
| duration_ms      | INTEGER   | No       | Spotify  | Yes        | Song duration in seconds.                                  |
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

---

# Entity: Label

## Description

---

# Entity: Genre

## Description

---

# Entity: Audio Features

## Description

---

# Entity: Streaming History

## Description

---

# Entity: Social Metrics

## Description

---

# Entity: Lyrics

## Description

---

# Entity: Tour Event

## Description

---

# Entity: News Article

## Description

---

# Entity: Playlist Appearance

## Description