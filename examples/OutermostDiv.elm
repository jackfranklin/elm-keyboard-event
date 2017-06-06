module Main exposing (..)

import Dom
import Html exposing (Html, Attribute, p, div, h1, h3, text, program, pre)
import Html.Attributes exposing (tabindex, id, style)
import Html.Events exposing (on)
import Json.Decode as Json
import Keyboard.Event exposing (KeyboardEvent, decodeKeyboardEvent)
import Task


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type Msg
    = HandleKeyboardEvent KeyboardEvent
    | NoOp


type alias Model =
    { lastEvent : Maybe KeyboardEvent
    }


init : ( Model, Cmd Msg )
init =
    ( { lastEvent = Nothing }
    , Dom.focus "outermost"
        |> Task.attempt (always NoOp)
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandleKeyboardEvent event ->
            ( { model | lastEvent = Just event }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div
        [ on "keydown" <|
            Json.map HandleKeyboardEvent decodeKeyboardEvent
        , tabindex 0
        , id "outermost"
        , style
            [ ( "position", "absolute" )
            , ( "height", "100%" )
            , ( "width", "100%" )
            , ( "overflow", "hidden" )
            , ( "outline", "none" )
            ]
        ]
        [ div []
            [ leftSide model
            , rightSide
            ]
        ]


leftSide : Model -> Html Msg
leftSide model =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "left", "0px" )
            , ( "right", "65%" )
            , ( "height", "100%" )
            , ( "margin", "18px" )
            , ( "overflow", "hidden" )
            ]
        ]
        [ h1 [] [ text "Outermost Div" ]
        , h3 [] [ text "An example of attaching a keydown listener to the outermost div you create." ]
        , p [] [ text "Press a key, and I'll display the event below." ]
        , viewEvent model.lastEvent
        ]


viewEvent : Maybe KeyboardEvent -> Html Msg
viewEvent maybeEvent =
    case maybeEvent of
        Just event ->
            pre []
                [ text <|
                    String.join "\n"
                        [ "altKey: " ++ toString event.altKey
                        , "ctrlKey: " ++ toString event.ctrlKey
                        , "key: " ++ toString event.key
                        , "keyCode: " ++ toString event.keyCode
                        , "metaKey: " ++ toString event.metaKey
                        , "repeat: " ++ toString event.repeat
                        , "shiftKey: " ++ toString event.shiftKey
                        ]
                ]

        Nothing ->
            p [] [ text "No event yet" ]


rightSide : Html Msg
rightSide =
    pre
        [ style
            [ ( "position", "absolute" )
            , ( "left", "35%" )
            , ( "right", "0px" )
            , ( "height", "100%" )
            , ( "margin", "18px" )
            , ( "overflow", "auto" )
            ]
        ]
        [ text source ]


source : String
source =
    """
module Main exposing (..)

import Dom
import Html exposing (Html, Attribute, p, div, h1, h3, text, program, pre)
import Html.Attributes exposing (tabindex, id, style)
import Html.Events exposing (on)
import Json.Decode as Json
import Keyboard.Event exposing (KeyboardEvent, decodeKeyboardEvent)
import Task


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type Msg
    = HandleKeyboardEvent KeyboardEvent
    | NoOp


type alias Model =
    { lastEvent : Maybe KeyboardEvent
    }


init : ( Model, Cmd Msg )
init =
    ( { lastEvent = Nothing }
    , Dom.focus "outermost"
        |> Task.attempt (always NoOp)
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandleKeyboardEvent event ->
            ( { model | lastEvent = Just event }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div
        [ on "keydown" <|
            Json.map HandleKeyboardEvent decodeKeyboardEvent
        , tabindex 0
        , id "outermost"
        , style
            [ ( "position", "absolute" )
            , ( "height", "100%" )
            , ( "width", "100%" )
            , ( "overflow", "hidden" )
            , ( "outline", "none" )
            ]
        ]
        [ div []
            [ leftSide model
            , rightSide
            ]
        ]


leftSide : Model -> Html Msg
leftSide model =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "left", "0px" )
            , ( "right", "35%" )
            , ( "height", "100%" )
            , ( "margin", "18px" )
            , ( "overflow", "hidden" )
            ]
        ]
        [ h1 [] [ text "Outermost Div" ]
        , h3 [] [ text "An example of attaching a keydown listener to the outermost div you create." ]
        , p [] [ text "Press a key, and I'll display the event below." ]
        , viewEvent model.lastEvent
        ]


viewEvent : Maybe KeyboardEvent -> Html Msg
viewEvent maybeEvent =
    case maybeEvent of
        Just event ->
            pre []
                [ text <|
                    String.join "\\n"
                        [ "altKey: " ++ toString event.altKey
                        , "ctrlKey: " ++ toString event.ctrlKey
                        , "key: " ++ toString event.key
                        , "keyCode: " ++ toString event.keyCode
                        , "metaKey: " ++ toString event.metaKey
                        , "repeat: " ++ toString event.repeat
                        , "shiftKey: " ++ toString event.shiftKey
                        ]
                ]

        Nothing ->
            p [] [ text "No event yet" ]


rightSide : Html Msg
rightSide =
    pre
        [ style
            [ ( "position", "absolute" )
            , ( "left", "35%" )
            , ( "right", "0px" )
            , ( "height", "100%" )
            , ( "margin", "18px" )
            , ( "overflow", "auto" )
            ]
        ]
        [ text source ]


source : String
source =
    "To avoid infinite recursion, I shall not repeat the source here."
"""