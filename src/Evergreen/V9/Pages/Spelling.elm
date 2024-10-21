module Evergreen.V9.Pages.Spelling exposing (..)

import Browser.Dom


type State
    = Playing
    | Finished


type Word
    = Ring
    | Sang
    | Wing
    | King
    | Going
    | Bring
    | Strong
    | Wrong
    | Thing
    | Spring


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
