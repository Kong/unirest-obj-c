/*
 * Mashape Objective-C Client library.
 *
 * Copyright (C) 2012 Mashape, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * The author of this software is Mashape, Inc.
 * For any question or feedback please contact us at: support@mashape.com
 *
 */

#import "Authentication.h"

@interface Authentication ()
    @property (readwrite) NSMutableDictionary* headers;
    @property (readwrite) NSMutableDictionary* parameters;
@end

@implementation Authentication

@synthesize headers;
@synthesize parameters;

- (Authentication*) init {
    self = [super init];
    self.headers = [[NSMutableDictionary alloc]init];
    self.parameters = [[NSMutableDictionary alloc]init];
    return self;
}

@end
