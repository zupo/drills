module Main exposing (..)

import Html exposing (p, text)
import Html.Attributes exposing (class)

import Browser exposing (Document)
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

--main =
--  p [ class "text-sm" ] [ text "Hello!"]

main =
  Browser.document { init = init, update = update, subscriptions = subscriptions, view = view }

-- MODEL

type alias Model =
  { actual : String,
    expected : String
  }


init : () -> (Model, Cmd Msg)
init _ =
  ({ actual = "", expected = "hello" }, Cmd.none)


-- UPDATE


type Msg
  = Change String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Change newContent ->
      ({ model | actual = newContent }, Cmd.none)


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
    [ input [ placeholder "Start typing!", value model.actual, onInput Change, attribute "autofocus" ""] []
    , viewValidation model ]
    ]
  }



viewValidation : Model -> Html msg
viewValidation model =
  if model.actual == model.expected then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Keep trying!" ]
