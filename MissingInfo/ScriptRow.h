//
//  ScriptRow.h
//  MissingInfo
//
//  Created by Thibaut on 2/16/13.
//  Copyright (c) 2013 Thibaut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScriptRow : NSObject
{
    int score;
    NSString* title;
    NSString* album;
    NSString* artist;
    NSURL* itunesUrl;
    NSURL* albumArtworkUrl;
    NSURL* previewUrl;
    
    int collectionId;
    int itunesSongId;
    
    NSString* originalReleaseDate;
    NSString* pLine;
    NSString* copyright;
    NSString* isrc;
    NSString* upc;
    NSString* labelStudio;
    NSString* contentProviderName;
    NSString* albumCopyright;
    NSString* albumPLine;
}

-(void)checkArtist;
-(id)initWithColumn:(NSArray*)column;
-(void) extractCollectionId;
-(void) extractItunesSongId;

-(NSString*)getEpfSongQuery;
-(NSString*)getEpfSongMatchQuery;
-(NSString*)getEpfCollectionMatchQuery;
-(NSString*)getEpfCollectionQuery;

-(void)updateWithEpfSong:(NSArray*)result;
-(void)updateWithEpfSongMatch:(NSArray*)result;
-(void)updateWithEpfCollectionMatch:(NSArray*)result;
-(void)updateWithEpfCollection:(NSArray*)result;

-(NSString*)toString;

@end
