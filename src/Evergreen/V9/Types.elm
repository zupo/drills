module Evergreen.V9.Types exposing (..)

import Evergreen.V9.Bridge
import Evergreen.V9.Main
import Lamdera


type alias FrontendModel =
    Evergreen.V9.Main.Model


type alias BackendModel =
    { smashedLikes : Int
    }


type alias FrontendMsg =
    Evergreen.V9.Main.Msg


type alias ToBackend =
    Evergreen.V9.Bridge.ToBackend


type BackendMsg
    = OnConnect Lamdera.SessionId Lamdera.ClientId


type ToFrontend
    = NewSmashedLikes Int
