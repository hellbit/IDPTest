//
//  IDPTestTests.m
//  IDPTestTests
//
//  Created by HeLLBiT on 11/7/13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import <Kiwi.h>

#import "IDPModel.h"

static NSInteger const kIDPTimeOut = 3;

SPEC_BEGIN(IDPTestTests)

registerMatchers(@"IDP");

describe(@"IDPModel", ^{
    
    __block IDPModel *model;
    
    beforeEach(^{
        model = [[[IDPModel alloc] init] autorelease];
        
    });
    
    context(@"", ^{
        context(@"after creating", ^{
            it(@"it should not be nil", ^{
                [[model should] beNonNil];
            });
            it(@"it should be kind of class IDPObservableObject class", ^{
                [[model should] beKindOfClass:[IDPObservableObject class]];
            });
            it(@"it should be 'IDPModel' class", ^{
                [[model should] beMemberOfClass:[IDPModel class]];
            });
            it(@"it should conform to protocol IDPModel", ^{
                [[model should] conformToProtocol:@protocol(IDPModel)];
            });
            it(@"it should have model ready state", ^{
                [[theValue(model.state) should] equal:theValue(IDPModelReady)];
            });
            it(@"observer should must be empty", ^{
                [[model.observers should] beEmpty];
            });
        });
        
        context(@"after loading", ^{
            beforeAll(^{
                [[theValue([model load]) should] beTrue];
            });
            it(@"it should be model loading state", ^{
                [[theValue(model.state) should] equal:theValue(IDPModelLoading)];
            });
        });
    });
    
    context(@"", ^{
        IDPModel <IDPModelObserver>*observer = [KWMock nullMockForProtocol:@protocol(IDPModelObserver)];
        
        beforeEach(^{
            [[theBlock(^{
                [model addObserver:observer];
            }) should] change:^{ return (NSInteger)[model.observers count]; } by:+1];
        });
        afterEach(^{
            [[theBlock(^{
                [model removeObserver:observer];
            }) should] change:^{ return (NSInteger)[model.observers count]; } by:-1];
        });
        
        context(@"after finishing", ^{
            it(@"must have state finish", ^{
                [model finishLoading];
                [[theValue(model.state) should] equal:theValue(IDPModelFinished)];
            });
            it(@"should notify observers of success loading", ^{
                [[[observer should] receive] modelDidLoad:model];
                [model finishLoading];
            });
        });
        
        context(@"cancel when loading", ^{
            beforeEach(^{
                [[theValue([model load]) should] beTrue];
                [[theValue(model.state) should] equal:theValue(IDPModelLoading)];
            });
            it(@"it should be model cancel state", ^{
                [model cancel];
                [[theValue(model.state) should] equal:theValue(IDPModelCancelled)];
            });
            it(@"it should notify observers of cancel loading", ^{
                [[[observer should] receive] modelDidCancelLoading:model];
                [model cancel];
            });
            
            it(@"it should recive clean up", ^{
                [[[model should] receive] cleanup];
                [model cancel];
            });
        });
        
        context(@"fail loading", ^{
            it(@"it should be model fail state", ^{
                [model failLoading];
                [[theValue(model.state) should] equal:theValue(IDPModelFailed)];
            });
            it(@"it should notify observers of fail loading", ^{
                [[[observer should] receive] modelDidFailToLoad:model];
                [model failLoading];
            });
            it(@"it should recive clean up", ^{
                [[[model should] receive] cleanup];
                [model failLoading];
            });
        });
        
        context(@"after dump", ^{
            beforeEach(^{
                [[theValue(model.state) shouldNot] equal:theValue(IDPModelUnloaded)];
            });
            it(@"it should notify observers of fail loading and state unload", ^{
                [[[observer should] receive] modelDidUnload:model];
                [model dump];
                [[theValue(model.state) should] equal:theValue(IDPModelUnloaded)];
            });
            it(@"it should recive clean up and state unload", ^{
                [[[model should] receive] cleanup];
                [model dump];
            });
        });
        
        context(@"load after finish", ^{
            beforeEach(^{
                [model finishLoading];
                [[theValue(model.state) should] equal:theValue(IDPModelFinished)];
            });
            it(@"it should notify observers of success loading", ^{
                [[theValue([model load]) should] beFalse];
                [[[observer should] receive] modelDidLoad:model];
                [model finishLoading];
            });
        });
    });
});

SPEC_END