module Evergreen.V12.Pages.Spelling exposing (..)

import Browser.Dom
import Time


type State
    = Playing
    | Correct
    | Finished


type alias Word =
    String


type Player
    = Rina
    | Oskar


type alias Model =
    { state : State
    , actual : String
    , expected : Word
    , remaining : List Word
    , gifs_random_index : Int
    , startTime : Maybe Time.Posix
    , elapsed : Int
    , player : Maybe Player
    }


type Msg
    = KeyInput String
    | ButtonRepeat
    | ButtonNext
    | RandomNumber Int
    | Focus (Result Browser.Dom.Error ())
    | GotStartTime Time.Posix
    | Tick Time.Posix
