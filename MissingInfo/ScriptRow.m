//
//  ScriptRow.m
//  MissingInfo
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import "ScriptRow.h"

@implementation ScriptRow

const NSString* EPF_SONG = @"epf_song";
const NSString* EPF_COLLECTION = @"epf_collection";
const NSString* EPF_SONG_MATCH = @"epf_song_match";
const NSString* EPF_COLLECTION_MATCH = @"epf_collection_match";

-(id)initWithColumn:(NSArray*)column
{
    self = [super init];
    
    title = @"";
    album = @"";
    artist = @"";
    itunesUrl = [NSURL URLWithString:@""];
    albumArtworkUrl = [NSURL URLWithString:@""];
    previewUrl = [NSURL URLWithString:@""];
    
    originalReleaseDate = @"";
    pLine = @"";
    copyright = @"";
    isrc = @"";
    upc = @"";
    labelStudio = @"";
    contentProviderName = @"";
    albumCopyright = @"";
    albumPLine = @"";
    
    
    if (column != nil && column.count > 6)
    {
        score = [(NSString *) column[0] intValue];
        title = column[1];
        album = column[2];
        artist = column[3];
        itunesUrl =  [NSURL URLWithString:column[4]];
        albumArtworkUrl = [NSURL URLWithString:column[5]];
        previewUrl = [NSURL URLWithString:column[6]];
        [self checkArtist];
        [self extractCollectionId];
        [self extractItunesSongId];
    }
    
    return self;
}

-(void)checkArtist{
    NSLog(@"Checking artist");
}

-(void)extractCollectionId{
    NSString *collectionString = [[itunesUrl lastPathComponent] stringByReplacingOccurrencesOfString:@"id" withString:@""];
    if (collectionString != nil)
    {
        collectionId = [collectionString intValue];
    } else
    {
        NSLog(@"Error. Malformed URL");
    }
}

-(void)extractItunesSongId{
    
    NSArray *pairsArray = [[itunesUrl query] componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *parametersDictionary = [[NSMutableDictionary alloc] initWithCapacity:[pairsArray count]];
    for(NSString *pairString in pairsArray){
        
        NSArray *valuesArray = [pairString componentsSeparatedByString:@"="];
        if([valuesArray count]==2){
            [parametersDictionary setValue:[valuesArray objectAtIndex:1] forKey:[valuesArray objectAtIndex:0]];
        }
    }
    NSString *itunesSongIdString = [parametersDictionary objectForKey:@"i"];
    
    if (itunesSongIdString != nil)
    {
        itunesSongId = [itunesSongIdString intValue];
    } else
    {
        NSLog(@"Error. Malformed URL %@", [itunesUrl query]);
    }
}








-(NSString*) getEpfSongQuery
{
    return [NSString stringWithFormat:@"SELECT original_release_date, p_line, copyright FROM %@ WHERE song_id=%i", EPF_SONG, itunesSongId];
}

-(NSString*) getEpfSongMatchQuery
{
    return [NSString stringWithFormat:@"SELECT isrc FROM %@ WHERE song_id=%i", EPF_SONG_MATCH, itunesSongId];
}


-(NSString*) getEpfCollectionMatchQuery
{
    return [NSString stringWithFormat:@"SELECT upc FROM %@ WHERE collection_id=%i", EPF_COLLECTION_MATCH, collectionId];
}


-(NSString*) getEpfCollectionQuery
{
    return [NSString stringWithFormat:@"SELECT label_studio, content_provider_name, copyright, p_line FROM %@ WHERE collection_id=%i", EPF_COLLECTION, collectionId];
}


-(void)updateWithEpfSong:(NSArray*)result
{
    NSArray *data = [self fetchFirstRow:result];
    if (data && data.count == 3 )
    {
        originalReleaseDate = data[0];
        pLine = data[1];
        copyright = data[2];
    }
}

-(void)updateWithEpfSongMatch:(NSArray*)result
{
    NSArray *data = [self fetchFirstRow:result];
    if (data && data.count == 1 )
    {
        isrc = data[0];
    }
}


-(void)updateWithEpfCollectionMatch:(NSArray*)result
{
    NSArray *data = [self fetchFirstRow:result];
    if (data && data.count == 1 )
    {
        upc = data[0];
    }
}


-(void)updateWithEpfCollection:(NSArray*)result
{
    NSArray *data = [self fetchFirstRow:result];
    if (data && data.count == 4 )
    {
        labelStudio = data[0];
        contentProviderName = data[1];
        albumCopyright = data[2];
        albumPLine = data[3];
    }
}


-(NSArray*)fetchFirstRow:(NSArray*)result
{
    if (result != nil && result.count > 0)
    {
        return result[0];
    }
    return nil;
}


-(NSString*)toString
{
    return [NSString stringWithFormat:@"%i\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@",
            score, title, album, artist, itunesUrl, albumArtworkUrl, previewUrl, originalReleaseDate, pLine, copyright, isrc, upc, labelStudio,
            contentProviderName, albumCopyright, albumPLine];
}


@end
