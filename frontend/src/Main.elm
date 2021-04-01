module Main exposing (..)

import Browser
import Element exposing (Element, centerX, column, el, fill, height, padding, paddingXY, rgb255, row, text, width)
import Element.Background as Background
import Element exposing (text)
import Element.Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Input as Input exposing (labelLeft, placeholder)
import Html exposing (Html)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { page : Page
    , players: List Player
    , matches : List Match
    , nextPlayerId : Int
    , typedGameName : String
    , typedWinner : String
    , typedPlayerName : String
    }


type Page
    = MyMatches
    | AddMatch
    | AddPlayer
    | MyStats


type alias Match =
    { gameName : String
    , winner : String
    }


type alias Player =
    { id : Int
    , name : String
    , deleted : Bool
    }


addPlayer : Int -> String -> List Player -> List Player
addPlayer id name players =
    let
        player = { id = id, name = name, deleted = False }
    in
        players ++ [ player ]


init : Model
init =
    { page = MyMatches
    , players = []
    , matches = []
    , nextPlayerId = 0
    , typedGameName = ""
    , typedWinner = ""
    , typedPlayerName = ""
    }


type Msg
    = ClickMyMatches
    | ClickAddMatch
    | ClickAddPlayer
    | ClickMyStats
    | TypedGameName String
    | TypedWinnerName String
    | TypedPlayerName String
    | AddNewMatch
    | AddNewPlayer


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickMyMatches -> { model | page = MyMatches }

        ClickAddMatch -> { model | page = AddMatch }

        ClickAddPlayer -> { model | page = AddPlayer }

        ClickMyStats -> { model | page = MyStats }

        TypedGameName game -> { model | typedGameName = game }

        TypedWinnerName winner -> { model | typedWinner = winner }

        TypedPlayerName name -> { model | typedPlayerName = name }

        AddNewMatch ->
            { model
            | matches = updateMatches model.typedGameName model.typedWinner model.matches
            , typedGameName = ""
            , typedWinner = ""
            }

        AddNewPlayer ->
            { model
            | players = addPlayer model.nextPlayerId model.typedPlayerName model.players
            , nextPlayerId = model.nextPlayerId + 1
            , typedPlayerName = ""
            }


updateMatches : String -> String -> List Match -> List Match
updateMatches gameName winnerName oldMatches =
    let
        newMatch = { gameName = gameName, winner = winnerName }
    in
        oldMatches ++ [ newMatch ]


view : Model -> Html Msg
view model =
     Element.layout
        [ height fill
        , width fill
        ]
        (viewPage model)


viewPage model =
    column
        [ height fill
        , width fill
        ]
        [ viewPageWindow model
        , viewBottomNav model
        ]


viewPageWindow : Model -> Element Msg
viewPageWindow model =
    el
        [ height fill
        , width fill
        ]
    <|
        case model.page of
            MyMatches -> viewPageMyMatches model

            AddMatch -> viewPageAddMatch model

            AddPlayer -> viewPageAddPlayer model

            MyStats -> viewPageMyStats model


viewPageMyMatches : Model -> Element Msg
viewPageMyMatches model =
    column
        [ height fill
        , width fill
        , Background.color <| rgb255 120 100 120
        ]
        (List.map viewMatchItem model.matches)


viewMatchItem : Match -> Element Msg
viewMatchItem matchItem =
    row
        [ padding 20
        , width fill
        ]
        [ text ("Game: " ++ matchItem.gameName)
        , text ("Winner: " ++ matchItem.winner)
        ]


viewPageAddMatch : Model -> Element Msg
viewPageAddMatch model =
    column
        [ height fill
        , width fill
        , Background.color <| rgb255 100 200 100
        ]
        [ viewGameNameTextbox model
        , viewWinnerNameTextbox model
        , viewSubmitMatchButton model
        ]

viewGameNameTextbox : Model -> Element Msg
viewGameNameTextbox model =
    Input.text
        [
        ]
        { onChange = \gameName -> TypedGameName gameName
        , text = model.typedGameName
        , placeholder = Just <| placeholder [] (text "Game name")
        , label = labelLeft [] (text "Game name")
        }


viewWinnerNameTextbox : Model -> Element Msg
viewWinnerNameTextbox model =
    Input.text
        [
        ]
        { onChange = \winnerName -> TypedWinnerName winnerName
        , text = model.typedWinner
        , placeholder = Just <| placeholder [] (text "Winner name")
        , label = labelLeft [] (text "Winner name")
        }


viewSubmitMatchButton model =
    Input.button
        []
        { onPress = Just AddNewMatch
        , label = (text "Submit")
        }


viewPageAddPlayer model =
    column
        [ height fill
        , width fill
        , Background.color <| rgb255 30 150 180
        ]
        [ viewNewPlayerName model
        , viewAddPlayerSubmit model
        ]


viewNewPlayerName : Model -> Element Msg
viewNewPlayerName model =
    Input.text
        [
        ]
        { onChange = \playerName -> TypedPlayerName playerName
        , text =  model.typedPlayerName
        , placeholder = Just <| placeholder [] (text "Player name")
        , label = labelLeft [] (text "Player name")
        }


viewAddPlayerSubmit model =
    Input.button
        []
        { onPress = Just AddNewPlayer
        , label = (text "Submit")
        }


viewPageMyStats : Model -> Element Msg
viewPageMyStats model =
    el
        [ height fill
        , width fill
        , Background.color <| rgb255 100 100 200
        ]
        (text "MyStats")


viewBottomNav : Model -> Element Msg
viewBottomNav model =
    row
        [ width fill
        ]
        [ viewMyMatchesButton model
        , viewAddMatchesButton model
        , viewAddPlayerButton model
        , viewMyStatsButton model
        ]

viewBottomNavButton : String -> Msg -> Model -> Element Msg
viewBottomNavButton label msg model =
    el
        [ centerX
        , width fill
        , paddingXY 10 20
        , onClick msg
        , Background.color <| rgb255 100 100 150
        , Border.width <| 5
        , Border.color <| rgb255 50 50 60
        ]
        (text label)

viewMyMatchesButton : Model -> Element Msg
viewMyMatchesButton =
    viewBottomNavButton "My Matches" ClickMyMatches

viewAddMatchesButton : Model -> Element Msg
viewAddMatchesButton =
    viewBottomNavButton "Add Match" ClickAddMatch

viewAddPlayerButton : Model -> Element Msg
viewAddPlayerButton =
    viewBottomNavButton "Add Player" ClickAddPlayer

viewMyStatsButton : Model -> Element Msg
viewMyStatsButton =
    viewBottomNavButton "My Stats" ClickMyStats
