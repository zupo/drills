module Evergreen.V12.Types exposing (..)

import Evergreen.V12.Bridge
import Evergreen.V12.Main
import Lamdera


type alias FrontendModel =
    Evergreen.V12.Main.Model


type alias BackendModel =
    { smashedLikes : Int
    }


type alias FrontendMsg =
    Evergreen.V12.Main.Msg


type alias ToBackend =
    Evergreen.V12.Bridge.ToBackend


type BackendMsg
    = OnConnect Lamdera.SessionId Lamdera.ClientId


type ToFrontend
    = NewSmashedLikes Int
