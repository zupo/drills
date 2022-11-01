port module Main exposing (..)

import Array
import Browser exposing (Document)
import Html exposing (Attribute, Html, button, div, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.document { init = init, update = update, subscriptions = subscriptions, view = view }



-- MODEL


type State
    = Welcome
    | Playing
    | Finished


type alias Model =
    { state : State
    , actual : String
    , expected : Maybe String
    , words : Array.Array String
    , currentWordIndex : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { state = Welcome, actual = "", expected = Nothing, words = Array.fromList [ "dog", "cat", "house " ], currentWordIndex = 0 }, Cmd.none )


loadWord : Model -> Model
loadWord model =
    { model | expected = Array.get model.currentWordIndex model.words }



-- PORTS


port say : String -> Cmd msg



-- UPDATE


type Msg
    = KeyInput String
    | ButtonNext


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyInput newContent ->
            ( { model | actual = newContent }, Cmd.none )

        ButtonNext ->
            case model.state of
                Welcome ->
                    let
                        updated_model =
                            loadWord model
                    in
                    case updated_model.expected of
                        Just expected ->
                            ( { updated_model | state = Playing }, say expected )

                        Nothing ->
                            ( { model | state = Finished }, Cmd.none )

                Playing ->
                    let
                        updated_model =
                            loadWord { model | currentWordIndex = model.currentWordIndex + 1, actual = "" }
                    in
                    case updated_model.expected of
                        Just expected ->
                            ( updated_model, say expected )

                        Nothing ->
                            ( { model | state = Finished }, say "Well done!" )

                Finished ->
                    ( { model | currentWordIndex = 0, actual = "", expected = Nothing }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    let
        title =
            "Spellings"
    in
    case model.state of
        Welcome ->
            { title = title
            , body =
                [ div []
                    [ text "welcome"
                    , button [ onClick ButtonNext ] [ text "start" ]
                    ]
                ]
            }

        Playing ->
            { title = title
            , body =
                [ div []
                    [ input [ placeholder "Start typing!", value model.actual, onInput KeyInput, attribute "autofocus" "" ] []
                    , viewValidation model
                    ]
                ]
            }

        Finished ->
            { title = title
            , body =
                [ div []
                    [ text "finished"
                    ]
                ]
            }



--(button [ onClick ButtonNext ] [ text "-" ])


viewValidation : Model -> Html Msg
viewValidation model =
    case model.expected of
        Just expected ->
            if model.actual == expected then
                div [ style "color" "green" ] [ text "OK", button [ onClick ButtonNext ] [ text "next" ] ]

            else
                div [ style "color" "red" ] [ text "Keep trying!" ]

        Nothing ->
            text "Initialization error: missing words"
