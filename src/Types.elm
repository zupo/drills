module Types exposing (BackendModel, BackendMsg(..), FrontendModel, FrontendMsg(..), ToBackend(..), ToFrontend(..))

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , title : String
    }


type alias BackendModel =
    { title : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
