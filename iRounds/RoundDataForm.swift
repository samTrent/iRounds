//
//  RoundDataForm.swift
//  iRounds
//
//  Created by Sam Trent on 11/15/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import Foundation

struct RoundLocation
{
   var locationName: String
   var activity: String
   var numberOfParticipants: Int = 0
}

class createFitnessCenterRoundForm
{
    var Mainlocation: String
    var listOfRoundLocations: [RoundLocation] = []
    
    init()
    {
      Mainlocation = "FitnessCenter"
        
      listOfRoundLocations = [RoundLocation(locationName: "Hart Gym", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Wrestling Room", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Aux Gym West", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Aux Gym East", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Pool", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Dance Room", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Foyer", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Fitness Studio", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Racque Ball Court 1", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Racque Ball Court 2", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Racque Ball Court 3", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Racque Ball Court 4", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Racque Ball Court 5", activity: "", numberOfParticipants: 0),]
        
    }
}

class createICenterRoundForm
{
    var Mainlocation: String
    var listOfRoundLocations: [RoundLocation] = []
    
    init()
    {
      Mainlocation = "FitnessCenter"
        
      listOfRoundLocations = [RoundLocation(locationName: "Court 1", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 2", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 3", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 4", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 5", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 6", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 7", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 8", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 9", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Court 10", activity: "", numberOfParticipants: 0),
                              RoundLocation(locationName: "Track", activity: "", numberOfParticipants: 0)]
        
    }
}
