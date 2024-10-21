module Evergreen.V11.Types exposing (..)

import Evergreen.V11.Bridge
import Evergreen.V11.Main
import Lamdera


type alias FrontendModel =
    Evergreen.V11.Main.Model


type alias BackendModel =
    { smashedLikes : Int
    }


type alias FrontendMsg =
    Evergreen.V11.Main.Msg


type alias ToBackend =
    Evergreen.V11.Bridge.ToBackend


type BackendMsg
    = OnConnect Lamdera.SessionId Lamdera.ClientId


type ToFrontend
    = NewSmashedLikes Int
