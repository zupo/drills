module Evergreen.V1.Types exposing (BackendModel, BackendMsg(..), FrontendModel, FrontendMsg(..), ToBackend(..), ToFrontend(..))

import Browser
import Browser.Navigation


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , title : String
    }


type alias BackendModel =
    { title : String
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
