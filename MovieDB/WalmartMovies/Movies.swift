//
//  Movies.swift
//  TheMovieDB
//
//  Created by Nehemiah Horace on 5/16/17.
//  Copyright © 2017 Nehemiah Horace. All rights reserved.
//

import Foundation

struct Movies {
    
    fileprivate var _id: String!
    fileprivate var _originalTitle: String!
    fileprivate var _posterPath: String!
    fileprivate var _voteAverage: String!
    
    var uid: String {
        return _id
    }
    
    var originalTitle: String {
        return _originalTitle
    }
    
    var posterPath: String {
        return _posterPath
    }
    
    var voteAverage: String {
        return _voteAverage
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        // Within the Friend, or Key, the following properties are children
        
        if let id = dictionary["id"] as? String {
            self._id = id
        }
        
        if let originalTitle = dictionary["original_title"] as? String {
            self._originalTitle = originalTitle
        }
        
        if let posterPath = dictionary["poster_path"] as? String {
            self._posterPath = posterPath
        }
        
        if let voteAverage = dictionary["vote_average"] as? String {
            self._voteAverage = voteAverage
        }
    }
    
}
