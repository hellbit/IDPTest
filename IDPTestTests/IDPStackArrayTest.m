//
//  IDPStackArrayTest.m
//  IDPTest
//
//  Created by HeLLBiT on 12/26/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "IDPStackArray.h"
#import <Kiwi.h>

SPEC_BEGIN(IDPStackArrayTest)

registerMatchers(@"IDP");

describe(@"IDPStackArray", ^{
    
    __block IDPStackArray *stack = nil;
    
    beforeEach(^{
        stack = [[[IDPStackArray alloc] init] autorelease];
    });
    
    context(@"", ^{
        context(@"after creating", ^{
            it(@"it should not be nil", ^{
                [[stack should] beNonNil];
            });
            it(@"it should be king of IDPMutableArray class", ^{
                [[stack should] beKindOfClass:[IDPMutableArray class]];
            });
            it(@"it should be member IDPStackArray class", ^{
                [[stack should] beMemberOfClass:[IDPStackArray class]];
            });
            it(@"it shold must respond to selectors \"push:\", \"pushArray:\", \"pop\", \"popToObject\"", ^{
                [[stack should] respondToSelector:@selector(push:)];
                [[stack should] respondToSelector:@selector(pushArray:)];
                [[stack should] respondToSelector:@selector(pop)];
                [[stack should] respondToSelector:@selector(popToObject:)];
            });
        });
        
        context(@"", ^{
            __block NSObject *object;
            
            beforeEach(^{
                object = [[[NSObject alloc] init] autorelease];
            });
            
            it(@"after push object, it should count +1", ^{
                [[theBlock(^{
                    [stack push:object];
                }) should] change:^NSInteger{
                    return [stack count];
                } by: 1];
            });
            it(@"after pop, it shold count -1", ^{
#warning fixed after fix IDPStackArray
//                [[theBlock(^{
//                    [stack push:object];
//                    [stack pop];
//                }) should] change:^NSInteger{
//                    return [stack count];
//                } by: 0];
            });
            
        });
    });
});

SPEC_END