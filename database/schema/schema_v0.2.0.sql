CREATE TABLE "Artist" (
  "artist_id" bigint PRIMARY KEY,
  "artist_name" text NOT NULL,
  "spotify_artist_id" text UNIQUE NOT NULL,
  "artist_type" text NOT NULL,
  "city" text,
  "state_province" text,
  "country" text,
  "year_formed" integer,
  "is_active" boolean DEFAULT true,
  "current_label_id" bigint
);

CREATE TABLE "Song" (
  "song_id" bigint PRIMARY KEY,
  "song_title" text NOT NULL,
  "spotify_track_id" text UNIQUE NOT NULL,
  "isrc" text UNIQUE,
  "release_date" date,
  "duration_ms" integer NOT NULL,
  "track_number" integer,
  "disc_number" integer,
  "is_explicit" boolean
);

CREATE TABLE "Album" (
  "album_id" bigint PRIMARY KEY,
  "album_title" text NOT NULL,
  "spotify_album_id" text UNIQUE NOT NULL,
  "album_type" text NOT NULL,
  "release_date" date,
  "total_tracks" integer,
  "album_art_url" text,
  "label_id" bigint
);

CREATE TABLE "Label" (
  "label_id" bigint PRIMARY KEY,
  "label_name" text NOT NULL,
  "musicbrainz_label_id" text UNIQUE,
  "country" text,
  "city" text,
  "year_founded" integer,
  "is_active" boolean,
  "official_website" text
);

CREATE TABLE "Genre" (
  "genre_id" bigint PRIMARY KEY,
  "genre_name" text UNIQUE NOT NULL,
  "parent_genre_id" bigint,
  "description" text
);

CREATE TABLE "ArtistGenre" (
  "artist_id" bigint,
  "genre_id" bigint,
  PRIMARY KEY ("artist_id", "genre_id")
);

CREATE TABLE "SongGenre" (
  "song_id" bigint,
  "genre_id" bigint,
  PRIMARY KEY ("song_id", "genre_id")
);

CREATE TABLE "AlbumGenre" (
  "album_id" bigint,
  "genre_id" bigint,
  PRIMARY KEY ("album_id", "genre_id")
);

CREATE TABLE "AudioFeature" (
  "song_id" bigint PRIMARY KEY,
  "danceability" float,
  "energy" float,
  "valence" float,
  "acousticness" float,
  "instrumentalness" float,
  "speechiness" float,
  "liveness" float,
  "loudness_db" float,
  "tempo_bpm" float,
  "musical_key" integer,
  "musical_mode" integer,
  "time_signature" integer
);

CREATE TABLE "StreamingPlatform" (
  "platform_id" bigint PRIMARY KEY,
  "platform_name" text UNIQUE NOT NULL,
  "official_website" text,
  "api_available" boolean NOT NULL DEFAULT false,
  "is_active" boolean NOT NULL DEFAULT true
);

CREATE TABLE "StreamingHistory" (
  "streaming_history_id" bigint PRIMARY KEY,
  "song_id" bigint NOT NULL,
  "platform_id" bigint NOT NULL,
  "snapshot_date" date NOT NULL,
  "stream_count" bigint
);

CREATE TABLE "SocialPlatform" (
  "social_platform_id" bigint PRIMARY KEY,
  "platform_name" text UNIQUE NOT NULL,
  "official_website" text,
  "api_available" boolean NOT NULL DEFAULT false,
  "is_active" boolean NOT NULL DEFAULT true
);

CREATE TABLE "SocialMetrics" (
  "social_metric_id" bigint PRIMARY KEY,
  "artist_id" bigint NOT NULL,
  "social_platform_id" bigint NOT NULL,
  "snapshot_date" date NOT NULL,
  "follower_count" bigint,
  "following_count" bigint,
  "total_posts" bigint,
  "total_likes" bigint,
  "total_comments" bigint
);

CREATE TABLE "Lyrics" (
  "lyrics_id" bigint PRIMARY KEY,
  "song_id" bigint NOT NULL,
  "language" text,
  "lyrics_available" boolean NOT NULL DEFAULT false,
  "lyrics_source" text,
  "copyright_status" text
);

CREATE TABLE "TourEvent" (
  "tour_event_id" bigint PRIMARY KEY,
  "artist_id" bigint NOT NULL,
  "event_name" text,
  "venue_name" text,
  "city" text,
  "state_province" text,
  "country" text,
  "event_date" date NOT NULL,
  "festival_name" text,
  "headliner" boolean NOT NULL DEFAULT false
);

CREATE TABLE "MediaOutlet" (
  "media_outlet_id" bigint PRIMARY KEY,
  "outlet_name" text UNIQUE NOT NULL,
  "outlet_type" text,
  "official_website" text,
  "country" text
);

CREATE TABLE "MediaCoverage" (
  "media_coverage_id" bigint PRIMARY KEY,
  "artist_id" bigint NOT NULL,
  "media_outlet_id" bigint NOT NULL,
  "article_title" text NOT NULL,
  "media_type" text NOT NULL,
  "publication_date" date NOT NULL,
  "article_url" text,
  "sentiment" text
);

CREATE TABLE "PlaylistAppearance" (
  "playlist_appearance_id" bigint PRIMARY KEY,
  "song_id" bigint NOT NULL,
  "platform_id" bigint NOT NULL,
  "playlist_name" text NOT NULL,
  "playlist_type" text,
  "appearance_date" date NOT NULL,
  "removal_date" date,
  "playlist_followers" bigint
);

ALTER TABLE "Artist" ADD FOREIGN KEY ("current_label_id") REFERENCES "Label" ("label_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Album" ADD FOREIGN KEY ("label_id") REFERENCES "Label" ("label_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "AudioFeature" ADD FOREIGN KEY ("song_id") REFERENCES "Song" ("song_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "StreamingHistory" ADD FOREIGN KEY ("song_id") REFERENCES "Song" ("song_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "StreamingHistory" ADD FOREIGN KEY ("platform_id") REFERENCES "StreamingPlatform" ("platform_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "SocialMetrics" ADD FOREIGN KEY ("artist_id") REFERENCES "Artist" ("artist_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "SocialMetrics" ADD FOREIGN KEY ("social_platform_id") REFERENCES "SocialPlatform" ("social_platform_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Lyrics" ADD FOREIGN KEY ("song_id") REFERENCES "Song" ("song_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "TourEvent" ADD FOREIGN KEY ("artist_id") REFERENCES "Artist" ("artist_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "MediaCoverage" ADD FOREIGN KEY ("artist_id") REFERENCES "Artist" ("artist_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "MediaCoverage" ADD FOREIGN KEY ("media_outlet_id") REFERENCES "MediaOutlet" ("media_outlet_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "PlaylistAppearance" ADD FOREIGN KEY ("song_id") REFERENCES "Song" ("song_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "PlaylistAppearance" ADD FOREIGN KEY ("platform_id") REFERENCES "StreamingPlatform" ("platform_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "ArtistGenre" ADD FOREIGN KEY ("artist_id") REFERENCES "Artist" ("artist_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "ArtistGenre" ADD FOREIGN KEY ("genre_id") REFERENCES "Genre" ("genre_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "SongGenre" ADD FOREIGN KEY ("song_id") REFERENCES "Song" ("song_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "SongGenre" ADD FOREIGN KEY ("genre_id") REFERENCES "Genre" ("genre_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "AlbumGenre" ADD FOREIGN KEY ("album_id") REFERENCES "Album" ("album_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "AlbumGenre" ADD FOREIGN KEY ("genre_id") REFERENCES "Genre" ("genre_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Genre" ADD FOREIGN KEY ("parent_genre_id") REFERENCES "Genre" ("genre_id") DEFERRABLE INITIALLY IMMEDIATE;
