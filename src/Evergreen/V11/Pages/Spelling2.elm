module Evergreen.V11.Pages.Spelling2 exposing (..)

import Browser.Dom
import Time


type State
    = Playing
    | Correct
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
    , startTime : Maybe Time.Posix
    , elapsed : Int
    }


type Msg
    = KeyInput String
    | ButtonRepeat
    | ButtonNext
    | RandomNumber Int
    | Focus (Result Browser.Dom.Error ())
    | GotStartTime Time.Posix
    | Tick Time.Posix
