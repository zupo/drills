module Evergreen.V3.Pages.Spelling exposing (..)

import Browser.Dom


type State
    = Playing
    | Finished


type Word
    = Short
    | Born
    | Horse
    | More
    | Before
    | Morning
    | Score
    | Door
    | Wore
    | Shore


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
