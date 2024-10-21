module Pages.Home_ exposing (Model, Msg(..), page)

import Bridge
import Css
import Dict
import Effect exposing (Effect)
import Html.Styled exposing (a, button, div, h2, span, text)
import Html.Styled.Attributes exposing (css)
import Lamdera
import Page exposing (Page)
import Pages.Spelling exposing (Player(..), playerToString)
import Route exposing (Route)
import Route.Path
import Shared
import String.Extra exposing (toSentenceCase)
import Tailwind.Breakpoints exposing (sm)
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Utils
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view shared
        }



-- INIT


type alias Model =
    {}


init : () -> ( Model, Effect Msg )
init _ =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = SmashedLikeButton


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SmashedLikeButton ->
            ( model
            , Effect.sendCmd <| Lamdera.sendToBackend Bridge.SmashedLikeButton
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view _ _ =
    let
        startButton : Player -> Html.Styled.Html Msg
        startButton player =
            let
                playerString : String
                playerString =
                    playerToString player

                capitalizedPlayerString : String
                capitalizedPlayerString =
                    toSentenceCase playerString
            in
            a
                [ Utils.hrefQS
                    { path = Route.Path.Spelling
                    , query = Dict.fromList [ ( "player", playerString ) ]
                    }
                , css
                    [ Tw.rounded_md
                    , Tw.bg_color Theme.indigo_600
                    , Tw.text_base
                    , Tw.font_medium
                    , Tw.text_color Theme.white
                    , Tw.px_5
                    , Tw.py_3
                    , Tw.m_2
                    , Tw.shadow_md
                    , Css.hover [ Tw.bg_color Theme.indigo_700 ]
                    ]
                ]
                [ button [] [ "[" ++ capitalizedPlayerString ++ "] Start" |> text ]
                ]
    in
    { title = "Choose a Drill"
    , body =
        [ div
            [ css
                [ Tw.flex
                , Tw.flex_col
                , Tw.h_screen
                , Tw.justify_center
                , Tw.items_center
                ]
            ]
            [ h2
                [ css
                    [ Tw.text_3xl
                    , Tw.font_bold
                    , Tw.tracking_tight
                    , Tw.text_color Theme.gray_900
                    , Tw.text_center
                    , sm [ Tw.text_4xl ]
                    ]
                ]
                [ span [ css [ Tw.block ] ] [ text "Ready to practice spellings?" ]
                , span [ css [ Tw.block ] ] [ text "Press start!" ]
                ]
            , div [ css [ Tw.mt_8, Tw.flex, Tw.justify_center ] ]
                [ div [ css [ Tw.inline_flex ] ]
                    [ startButton Oskar, startButton Rina ]
                ]
            ]
        ]
    }
