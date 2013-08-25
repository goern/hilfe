//
//  b4Location.h
//  hilfe
//
//  Created by Christoph Görn on 24.08.13.
//  Copyright (c) 2013 erd/G/eschoss. All rights reserved.
//

#import "JSONModel.h"

@interface b4Location : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* lat;
@property (strong, nonatomic) NSString* lon;
@property (strong, nonatomic) NSDate* created_at;

@end
