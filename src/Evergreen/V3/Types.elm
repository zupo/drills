module Evergreen.V3.Types exposing (..)

import Evergreen.V3.Bridge
import Evergreen.V3.Main
import Lamdera


type alias FrontendModel =
    Evergreen.V3.Main.Model


type alias BackendModel =
    { smashedLikes : Int
    }


type alias FrontendMsg =
    Evergreen.V3.Main.Msg


type alias ToBackend =
    Evergreen.V3.Bridge.ToBackend


type BackendMsg
    = OnConnect Lamdera.SessionId Lamdera.ClientId


type ToFrontend
    = NewSmashedLikes Int
