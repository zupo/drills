port module Main exposing (..)

import Array
import Browser exposing (Document)
import Html exposing (Attribute, Html, button, div, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.document { init = init, update = update, subscriptions = subscriptions, view = view }



-- MODEL


type alias Model =
    { actual : String
    , expected : String
    , words : Array.Array String
    , currentWordIndex : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( loadWord { actual = "", expected = "", words = Array.fromList [ "foo", "bar", "baz" ], currentWordIndex = 0 }, Cmd.none )


loadWord : Model -> Model
loadWord model =
    { model | expected = Maybe.withDefault "" (Array.get model.currentWordIndex model.words) }



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
            let
                updated_model =
                    loadWord { model | currentWordIndex = model.currentWordIndex + 1, actual = "" }
            in
            ( updated_model, say updated_model.expected )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Spellings"
    , body =
        [ div []
            [ input [ placeholder "Start typing!", value model.actual, onInput KeyInput, attribute "autofocus" "" ] []
            , viewValidation model
            ]
        ]
    }



--(button [ onClick ButtonNext ] [ text "-" ])


viewValidation : Model -> Html Msg
viewValidation model =
    if model.actual == model.expected then
        div [ style "color" "green" ] [ text "OK", button [ onClick ButtonNext ] [ text "next" ] ]

    else
        div [ style "color" "red" ] [ text "Keep trying!" ]
