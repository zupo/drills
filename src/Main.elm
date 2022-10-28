module Main exposing (..)

import Html exposing (p, text)
import Html.Attributes exposing (class)

import Array

import Browser exposing (Document)
import Html exposing (Html, Attribute, button, div, input, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
  Browser.document { init = init, update = update, subscriptions = subscriptions, view = view }

-- MODEL

type alias Model =
  { actual : String,
    expected : Maybe String,
    words: Array.Array String,
    currentWordIndex: Int
  }


init : () -> (Model, Cmd Msg)
init _ =
  (loadWord { actual = "", expected = Nothing, words = Array.fromList ["foo", "bar", "baz"] , currentWordIndex = 0}, Cmd.none)

loadWord: Model -> Model
loadWord model =
  { model | expected = Array.get model.currentWordIndex model.words }


-- UPDATE


type Msg
  = KeyInput String
  | ButtonNext


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    KeyInput newContent ->
      ({ model | actual = newContent }, Cmd.none)
    ButtonNext ->
      ( loadWord { model | currentWordIndex = model.currentWordIndex+1} , Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW


view : Model -> Document Msg
view model =
  {
    title = "Spellings",
    body = [
  div []
    [ input [ placeholder "Start typing!", value model.actual, onInput KeyInput, attribute "autofocus" ""] []
    , viewValidation model ]
    ]
  }


--(button [ onClick ButtonNext ] [ text "-" ])
viewValidation : Model -> Html Msg
viewValidation model =
  case model.expected of
    Just expected ->
      if model.actual == expected then
        div [ style "color" "green" ] [ text "OK", button [ onClick ButtonNext ] [text "next"] ]
      else
        div [ style "color" "red" ] [ text "Keep trying!" ]

    Nothing ->
      text "Initialization error: missing words"
