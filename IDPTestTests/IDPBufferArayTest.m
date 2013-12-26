//
//  IDPBufferAray.m
//  IDPTest
//
//  Created by HeLLBiT on 12/25/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "IDPBufferArray.h"
#import <Kiwi.h>

SPEC_BEGIN(IDPBufferArrayTest)

registerMatchers(@"IDP");

describe(@"IDPBufferArray", ^{

    __block IDPBufferArray *buffer = nil;
    
    beforeEach(^{
        buffer = [[[IDPBufferArray alloc] init] autorelease];
    });
    
    context(@"", ^{
        context(@"after creating", ^{
            it(@"it should not be nil", ^{
                [[buffer should] beNonNil];
            });
            it(@"it should be king of IDPMutableArray class", ^{
                [[buffer should] beKindOfClass:[IDPMutableArray class]];
            });
            it(@"it should be member IDPBufferArray class", ^{
                [[buffer should] beMemberOfClass:[IDPBufferArray class]];
            });
            it(@"it should must be empty", ^{
                [[buffer should] beEmpty];
            });
            it(@"it should must respond to selectors push: and pop", ^{
                [[buffer should] respondToSelector:@selector(push:)];
                [[buffer should] respondToSelector:@selector(pop)];
            });
        });
        context(@"", ^{
            __block NSObject *object;
            
            beforeEach(^{
                object = [[[NSObject alloc] init] autorelease];
            });
            
            it(@"after push object, it shold count +1", ^{
                [[theBlock(^{
                    [buffer push:object];
                }) should] change:^NSInteger{
                    return [buffer count];
                } by: 1];
            });
            
            it(@"after pop, it shold count -1", ^{
                [[theBlock(^{
                    [buffer push:object];
                    [buffer pop];
                }) should] change:^NSInteger{
                    return [buffer count];
                } by: 0];
            });
            
            it(@"if buffer has no object, pop return nil", ^{
                [buffer stub:@selector(pop) andReturn:nil];
            });
            
        });
    });
});


SPEC_END