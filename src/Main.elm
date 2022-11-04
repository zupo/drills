port module Main exposing (..)

import Array
import Browser exposing (Document)
import Html exposing (..)
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
    ( { state = Welcome, actual = "", expected = Nothing, words = Array.fromList [ "dog", "cat", "house" ], currentWordIndex = 0 }, Cmd.none )


loadWord : Model -> Model
loadWord model =
    { model | expected = Array.get model.currentWordIndex model.words }



-- PORTS


port say : String -> Cmd msg



-- UPDATE


type Msg
    = KeyInput String
    | ButtonRepeat
    | ButtonNext


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyInput newContent ->
            ( { model | actual = newContent }, Cmd.none )

        ButtonRepeat ->
            ( model, Maybe.withDefault "" model.expected |> say )

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
            , body = [ welcomeBody ]
            }

        Playing ->
            { title = title
            , body = [ playingBody model ]
            }

        Finished ->
            { title = title
            , body = [ finishedBody ]
            }


welcomeBody : Html Msg
welcomeBody =
    div [ class "flex flex-col justify-center items-center" ]
        [ div [ class "py-12" ]
            [ h2 [ class "text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl" ]
                [ span [ class "block" ]
                    [ text "Ready to practice spellings?" ]
                , span [ class "block" ]
                    [ text "Press start!" ]
                ]
            , div [ class "mt-8 flex justify-center" ]
                [ div [ class "inline-flex rounded-md shadow" ]
                    [ a [ class "inline-flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-5 py-3 text-base font-medium text-white hover:bg-indigo-700" ]
                        [ button [ onClick ButtonNext ] [ text "Start" ] ]
                    ]
                ]
            ]
        ]


playingBody : Model -> Html Msg
playingBody model =
    div [ class "flex flex-col justify-center items-center" ]
        [ div [ class "mx-auto max-w-7xl py-12 px-4 text-center sm:px-6 lg:py-16 lg:px-8" ]
            [ input
                [ class "block rounded-full border-gray-300 px-4 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
                , type_ "text"
                , attribute "autofocus" ""
                , placeholder "start typing"
                , value model.actual
                , onInput KeyInput
                ]
                []
            , button [ class "py-3", onClick ButtonRepeat ] [ text "📢" ]
            , viewValidation model
            ]
        ]


finishedBody =
    div [ class "flex flex-col justify-center items-center" ]
        [ div [ class "py-12" ]
            [ h2 [ class "text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl" ]
                [ span [ class "block" ]
                    [ text "Finished!" ]
                ]
            ]
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    case model.expected of
        Just expected ->
            if String.length model.actual < 3 then
                div [] []

            else if model.actual == expected then
                div []
                    [ h2 [ class "text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl py-4" ]
                        [ text "Correct!" ]
                    , a [ class "inline-flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-5 py-1 text-base font-medium text-white hover:bg-indigo-700" ]
                        [ button [ onClick ButtonNext ] [ text "Next word" ] ]
                    ]

            else
                div [ style "color" "orange" ] [ text "Keep trying!" ]

        Nothing ->
            text "Initialization error: missing words"
