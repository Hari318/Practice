//
//  DependencyComposition.swift
//  Sample
//
//  Created by Hari on 20/05/23.
//

import UIKit

protocol FeedLoader{
    func loadFeed(completion: @escaping(([String])->Void))
}

struct Reachability{
    static let networkAvailable = false
}
class FeedViewController: UIViewController{
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.loadFeed { loadedFeeds in
            // do something
        }
    }
}

class RemoteFeedLoader: FeedLoader{
    func loadFeed(completion: @escaping (([String]) -> Void)) {
        // do something
    }
}

class LocalFeedLoader: FeedLoader{
    func loadFeed(completion: @escaping (([String]) -> Void)) {
        // do something
    }
}

class RemoteWithLocalFallBackLoader: FeedLoader {
    var remote: RemoteFeedLoader!
    var local: LocalFeedLoader!
    
    init(remoteFeedLoader: RemoteFeedLoader, localFeedLoader: LocalFeedLoader) {
        self.remote = remoteFeedLoader
        self.local = localFeedLoader
    }
    
    func loadFeed(completion: @escaping (([String]) -> Void)) {
        let load = Reachability.networkAvailable ? remote.loadFeed : local.loadFeed
        load(completion)
    }
}

let vcRemote = FeedViewController(loader: RemoteFeedLoader())
let vcLocal = FeedViewController(loader: LocalFeedLoader())
let vcRemoteWithLocal = FeedViewController(loader: RemoteWithLocalFallBackLoader(remoteFeedLoader: RemoteFeedLoader(), localFeedLoader: LocalFeedLoader()))
