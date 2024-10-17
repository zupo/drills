module Types exposing (BackendModel, BackendMsg(..), FrontendModel, FrontendMsg, ToBackend, ToFrontend(..))

import Bridge
import Main as ElmLand


type alias FrontendModel =
    ElmLand.Model


type alias BackendModel =
    { smashedLikes : Int
    }


type alias FrontendMsg =
    ElmLand.Msg


type alias ToBackend =
    Bridge.ToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NewSmashedLikes Int
