//
//  AppDelegate.swift
//  PedigreeTable
//
//  Created by David Aghassi on 3/24/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  // Need to hard code this for the project, normally wouldn't do this:
  var pedigrees = [Pedigree]()


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    // Family 1 - Father, Mother, and three children
    let familyOneFather = Individual(id: 0, name: ("Robert", "Plant"), gender: Gender.MALE)
    let familyOneMother = Individual(id: 1, name: ("Linda", "Plant"), gender: Gender.FEMALE)
    
    let familyOneLisa = Individual(id: 2, name: ("Lisa", "Plant"), gender: Gender.FEMALE)
    familyOneLisa.father = familyOneFather
    familyOneLisa.mother = familyOneMother
    
    let familyOneJohn = Individual(id: 3, name: ("John", "Plant"), gender: Gender.MALE)
    familyOneJohn.father = familyOneFather
    familyOneJohn.mother = familyOneMother
    
    let familyOneDonna = Individual(id: 4, name: ("Donna", "Plant"), gender: Gender.FEMALE)
    familyOneDonna.father = familyOneFather
    familyOneDonna.mother = familyOneMother
    
    let familyOne = [familyOneFather, familyOneMother, familyOneLisa, familyOneJohn, familyOneDonna]
    let pedigreeOne = Pedigree(family: familyOne, proband: familyOneFather)
    pedigrees.append(pedigreeOne)
    
    // Family 2 - Four grandparents, two parents, two kids
    let familyTwofatherMother = Individual(id: 5, name: ("Lauren", "Smith"), gender: Gender.FEMALE)
    let familyTwofatherFather = Individual(id: 6, name: ("Ron", "Smith"), gender: Gender.FEMALE)
    
    let familyTwoFather = Individual(id: 7, name: ("Dale", "Smith"), gender: Gender.MALE)
    familyTwoFather.father = familyTwofatherFather
    familyTwoFather.mother = familyTwofatherMother
    
    let familyTwoMothersMother = Individual(id: 8, name: ("Sally", "Goodall"), gender: Gender.FEMALE)
    let familyTwoMothersFather = Individual(id: 9, name: ("George", "Goodall"), gender: Gender.MALE)
    
    let familyTwoMother = Individual(id: 10, name: ("Danielle", "Smith"), gender: Gender.FEMALE)
    familyTwoMother.father = familyTwoMothersFather
    familyTwoMother.mother = familyTwoMothersMother
    
    let familyTwoSon = Individual(id: 11, name: ("Jonny", "Smith"), gender: Gender.MALE)
    familyTwoSon.mother = familyTwoMother
    familyTwoSon.father = familyTwoFather
    
    let familyTwoDaughter = Individual(id: 12, name: ("Ronda", "Smith"), gender: Gender.FEMALE)
    familyTwoDaughter.mother = familyTwoMother
    familyTwoDaughter.father = familyTwoFather
    
    let familyTwo = [familyTwofatherFather, familyTwofatherMother, familyTwoMothersFather, familyTwoMothersMother, familyTwoFather, familyTwoMother, familyTwoSon, familyTwoDaughter]
    let pedigreeTwo = Pedigree(family: familyTwo, proband: familyTwofatherMother)
    pedigrees.append(pedigreeTwo)
    
    // Family 3 - Two shared grandparents, two parents, two children
    let familyThreeGrandfather = Individual(id: 13, name: ("Steven", "Pad"), gender: Gender.MALE)
    let familyThreeGrandmother = Individual(id: 14, name: ("Irene", "Pad"), gender: Gender.FEMALE)
    
    let familyThreeFather = Individual(id: 15, name: ("Randall", "Pad"), gender: Gender.MALE)
    familyThreeFather.father = familyThreeGrandfather
    familyThreeFather.mother = familyThreeGrandmother
    
    let familyThreeMother = Individual(id: 16, name: ("Ruth", "Pad"), gender: Gender.FEMALE)
    familyThreeMother.father = familyThreeGrandfather
    familyThreeMother.mother = familyThreeGrandmother
    
    let familyThreeSon = Individual(id: 17, name: ("Michael", "Pad"), gender: Gender.MALE)
    familyThreeSon.father = familyThreeFather
    familyThreeSon.mother = familyThreeMother
    
    let familyThreeDaughter = Individual(id: 18, name: ("Michelle", "Pad"), gender: Gender.FEMALE)
    familyThreeDaughter.father = familyThreeFather
    familyThreeDaughter.mother = familyThreeMother
    
    let familyThree = [familyThreeGrandfather, familyThreeGrandmother, familyThreeFather, familyThreeMother, familyThreeSon, familyThreeDaughter]
    let pedigreeThree = Pedigree(family: familyThree, proband: familyThreeGrandfather)
    pedigrees.append(pedigreeThree)
    
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

