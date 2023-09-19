package com.studiosol.cifraclub.local_songs

import LocalSongDto
import android.content.ContentUris
import android.content.Context
import android.provider.MediaStore

class LoadLocalSongs {
    companion object {
        private const val DURATION = MediaStore.Audio.Media.DURATION
        private const val _ID = MediaStore.Audio.Media._ID
        private const val TITLE = MediaStore.Audio.Media.TITLE
        private const val ARTIST = MediaStore.Audio.Media.ARTIST
        private const val IS_MUSIC = MediaStore.Audio.Media.IS_MUSIC
        private const val ALBUM_ID = MediaStore.Audio.Media.ALBUM_ID
    }

    fun fetchMedias(
        context: Context,
        artistName: String,
        songName: String,
    ): MutableList<LocalSongDto> {
        val songs = mutableListOf<LocalSongDto>()
        val projection = arrayOf(DURATION, _ID, TITLE, ARTIST, ALBUM_ID)

        val selection =
            String.format("%s LIKE ? AND %s LIKE ? AND %s != 0", ARTIST, TITLE, IS_MUSIC)

        val selectionArgs = arrayOf(
            "%$artistName%",
            "%$songName%"
        )

        val uri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
        context.contentResolver.query(
            uri,
            projection,
            selection,
            selectionArgs,
            null
        )?.use { cursor ->
            val durationColumnIndex = cursor.getColumnIndex(DURATION)
            val idColumnIndex = cursor.getColumnIndex(_ID)
            val titleColumnIndex = cursor.getColumnIndex(TITLE)
            val artistColumnIndex = cursor.getColumnIndex(ARTIST)
            val albumIdColumnIndex = cursor.getColumnIndex(ALBUM_ID)

            if (cursor.moveToNext()) {
                do {
                    val songDuration = cursor.getInt(durationColumnIndex)
                    val id = cursor.getLong(idColumnIndex)
                    val contentUri = ContentUris.withAppendedId(
                        MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
                        id
                    )
                    val cursorSongName = cursor.getString(titleColumnIndex)
                    val cursorArtistName = cursor.getString(artistColumnIndex)
                    val albumId = cursor.getString(albumIdColumnIndex)


                    val song = LocalSongDto(
                        songName = cursorSongName,
                        artistName = cursorArtistName,
                        path = contentUri.toString(),
                        duration = songDuration.toLong(),
                        albumId = albumId
                    )

                    songs.add(song);
                } while (cursor.moveToNext())
            }
            cursor.close()
        }
        return songs
    }
}