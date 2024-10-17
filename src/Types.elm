module Types exposing (BackendModel, BackendMsg(..), FrontendModel, FrontendMsg(..), ToBackend(..), ToFrontend(..))


type alias BackendModel =
    { message : String
    }


type alias FrontendModel =
    { message : String
    }


type FrontendMsg
    = NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
