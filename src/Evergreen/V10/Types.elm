module Evergreen.V10.Types exposing (..)

import Evergreen.V10.Bridge
import Evergreen.V10.Main
import Lamdera


type alias FrontendModel =
    Evergreen.V10.Main.Model


type alias BackendModel =
    { smashedLikes : Int
    }


type alias FrontendMsg =
    Evergreen.V10.Main.Msg


type alias ToBackend =
    Evergreen.V10.Bridge.ToBackend


type BackendMsg
    = OnConnect Lamdera.SessionId Lamdera.ClientId


type ToFrontend
    = NewSmashedLikes Int
