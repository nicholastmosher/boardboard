module Main exposing (..)

import Browser
import Element exposing (Element, el, text, row, column, alignRight, fill, width, rgb255, spacing, centerY, padding)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element exposing (rgb255, text)
import Element.Background as Background
import Element.Input as Input
import Html exposing (Html)


main =
    Browser.sandbox {init = init, update = update, view = view }

type alias Model = Int
init : Model
init = 0

type Msg =
    ClickMsg

update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickMsg -> model+1

view : Model -> Html Msg
view model =
     Element.layout []
            (column [] [row1,
            row2, myButton, (text(String.fromInt model))])



row1 =
    row [ width fill, centerY, spacing 30 ]
        [ myElement
        , myElement
        , el [ alignRight ] myElement
        ]

row2 =
    row [ width fill, centerY, spacing 30 ]
        [ myElement
        , myElement
        , el [ alignRight ] myElement
        ]


myElement : Element msg
myElement =
    el
        [ Background.color (rgb255 240 0 245)
        , Font.color (rgb255 255 255 255)
        , Border.rounded 3
        , padding 30
        ]
        (text "hahahha!")

blue =
    Element.rgb255 238 238 238

purple =
    Element.rgb255 200 200 200

myButton =
    Input.button
        [ Background.color blue
        , Element.focused
            [Background.color purple ]
        ]
        { onPress = Just ClickMsg
        , label = text "My Button"
        }