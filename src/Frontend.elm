module Frontend exposing (Model, app)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Html
import Lamdera
import Types exposing (FrontendModel, FrontendMsg(..), ToFrontend(..))
import Url


type alias Model =
    FrontendModel


app :
    { init : Lamdera.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
    , view : Model -> Browser.Document FrontendMsg
    , update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
    , updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
    , subscriptions : Model -> Sub FrontendMsg
    , onUrlRequest : UrlRequest -> FrontendMsg
    , onUrlChange : Url.Url -> FrontendMsg
    }
app =
    Lamdera.frontend
        { init = \_ _ -> init
        , update = update
        , updateFromBackend = updateFromBackend
        , view =
            \_ ->
                { title = "Lamdera"
                , body = [ Html.text "Hello, World!" ]
                }
        , subscriptions = \_ -> Sub.none
        , onUrlChange = \_ -> NoOpFrontendMsg
        , onUrlRequest = \_ -> NoOpFrontendMsg
        }


init : ( Model, Cmd FrontendMsg )
init =
    ( { message = "foo" }, Cmd.none )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        NoOpFrontendMsg ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )
