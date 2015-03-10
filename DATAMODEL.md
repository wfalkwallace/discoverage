#Class Model

### BananaTree
  - location
  - no. of bananas
  - func findBananasInRegion () // For map

### LocationSingleton
  - get location
  - query parse w/ loc
  - adopt any Animals returned
  - grab any bananas in area

### Animal
  - owner: User
  - health: Int
  - name: String
  - sprite: String
  - location: Location
  - func adopt (User)
  - func feed ()
  - func getUserAnimals ()

### User
  - [(banana, timestamp)]
  - number of bananas: Int
  - facebook id/info
  - current location
  - func grabBanana (BananaTree)
