//
//  XMPPMessage+XEP_0359.m
//  XMPPFramework
//
//  Created by Chris Ballinger on 10/10/17.
//  Copyright © 2017 Chris Ballinger. All rights reserved.
//

#import "XMPPMessage+XEP_0359.h"
#import "NSXMLElement+XEP_0359.h"
#import "NSXMLElement+XMPP.h"

@implementation XMPPMessage (XEP_0359)

- (BOOL) hasValidStanzaId {
    XMPPJID *by = self.stanzaIdBy;
    if (!by || !self.stanzaId) {
        return NO;
    }
    XMPPJID *from = self.from;
    BOOL same = [by isEqualToJID:from options:XMPPJIDCompareBare];
    return same;
}

- (nullable NSXMLElement*) stanzaIdElement {
    NSXMLElement *sid = [self elementForName:XMPPStanzaIdElementName xmlns:XMPPStanzaIdXmlns];
    return sid;
}

- (NSString*) stanzaId {
    NSXMLElement *sid = [self stanzaIdElement];
    return [sid attributeStringValueForName:@"id"];
}

- (NSString*) originId {
    NSXMLElement *oid = [self elementForName:XMPPOriginIdElementName xmlns:XMPPStanzaIdXmlns];
    return [oid attributeStringValueForName:@"id"];
}

- (void) addOriginId:(nullable NSString*)originId {
    NSXMLElement *oid = [NSXMLElement originIdElementWithUniqueId:originId];
    [self addChild:oid];
}

- (XMPPJID*) stanzaIdBy {
    NSXMLElement *sid = [self stanzaIdElement];
    NSString *by = [sid attributeStringValueForName:@"by"];
    if (!by.length) { return nil; }
    XMPPJID *jid = [XMPPJID jidWithString:by];
    return jid;
}



@end
