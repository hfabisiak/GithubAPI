//
//  AppDelegateSpec.swift
//  GithubAPITests
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

@testable import GithubAPI
import Foundation
import Quick
import Nimble

class AppDelegateSpec: QuickSpec {
    
    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!
            
            beforeEach {
                sut = AppDelegate()
            }
            
            afterEach {
                sut = nil
            }
            
            context("App did finish launching") {
                var didFinishLaunching: Bool!
                
                beforeEach {
                    didFinishLaunching = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }
                
                afterEach {
                    didFinishLaunching = nil
                }
                
                it("should launch with the value of true") {
                    expect(didFinishLaunching) == true
                }
                
                describe("window") {
                    it("should not be nil") {
                        expect(sut.window).toNot(beNil())
                    }
                    
                    it("should have size of the screen") {
                        expect(sut.window?.frame.size) == UIScreen.main.bounds.size
                    }
                    
                    describe("root view controller") {
                        it("should have UINavigationController set as a root view controller") {
                            expect(sut.window?.rootViewController).to(beAnInstanceOf(UINavigationController.self))
                        }
                        
                        it("should have UINavigationController with SearchViewController as root view controller") {
                            expect((sut.window?.rootViewController as! UINavigationController).viewControllers.first).to(beAnInstanceOf(SearchViewController.self))
                        }
                    }
                    
                    it("should be a key window") {
                        expect(sut.window?.isKeyWindow) == true
                    }
                }
                
            }
            
        }
    }
    
    
}
