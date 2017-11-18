//
//  UILabel+HTML.m
//  Grammar
//
//  Created by Tuan Vu on 11/18/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

#import "UILabel+HTML.h"

@implementation UILabel (HTML)
- (void) setHtml: (NSString*) html
{
    NSError *err = nil;
    self.attributedText =
    [[NSAttributedString alloc]
     initWithData: [html dataUsingEncoding:NSUTF16StringEncoding]
     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
     documentAttributes: nil
     error: &err];
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
}

@end
