module Evergreen.V9.Pages.Spelling2 exposing (..)

import Browser.Dom


type State
    = Playing
    | Finished


type Word
    = Puddle
    | Ocean
    | Planet
    | Pond
    | Space
    | Stone
    | Fog
    | Foggy
    | Storm
    | Arid


type alias Model =
    { state : State
    , actual : String
    , expected : Word
    , remaining : List Word
    , gifs_random_index : Int
    }


type Msg
    = KeyInput String
    | ButtonRepeat
    | ButtonNext
    | RandomNumber Int
    | Focus (Result Browser.Dom.Error ())
