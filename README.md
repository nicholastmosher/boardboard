# BoardBoard

A scoreBoard for Boardgames.

## Use cases

Phase 1: Individual players
- As a player, I would like to add friends and see my list of friends.
- As a player, I would like to be able to record match results with my friends.
- As a player, I would like to choose what type of match I am adding.
- As a player, I would like to see a list of past games I have played.
- As a player, I would like to be able to view past matches by game type, player, or date.
- As a player, I would like data visualization for previous matches.

Phase 2: Parties
- As a player, I would like to be able to create an join parties of friends.

## Data Model

Phase 1: Individual players
Player(player_id, email, name, password, joined_date)
Game(game_id, game_name, scoring_strategy)
Match(match_id, game_id, date_created, score_data, deleted)
PlayerInMatch(player_id, match_id)

Phase 2: Parties
Party(party_id, party_name, date_created)
PlayerInParty(player_id, party_id, date_joined)

## API Endpoints

```
POST /api/v1/player
Request JSON:
{
  email: String,
  name: String,
  password: String,
}

GET /api/v1/player
Response JSON:
{
  players: [
    { email: String, name: String, joined_date: Date }
  ]
}

=====================================================

POST /api/v1/match
Request:
{
  gameID: String,
  players: [ PlayerID ],
  scoreData: String,
  datePlayed: ?Date
}

PUT /api/v1/match/:match_id
Request:
{
  players: [ PlayerID ]?,
  scoreData: String?,
  datePlayed: Date?
}

DELETE /api/v1/match/:match_id
Response:
{
  status: String
}

GET /api/v1/match
  &playerId=Y
  &dateFrom=Z
  &dateTo=W
  &gameId=G
Response:
{
  matches: [
    { gameID: String,
      players: [ PlayerID ],
      scoreData: String,
      date: Date },
  ]
} 

GET /api/v1/match/:match_id
Response:
{
  gameID: String,
  players: [ PlayerID ],
  scoreData: String,
  date: Date
}
```
