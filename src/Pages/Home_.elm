module Pages.Home_ exposing (Model, Msg(..), page)

import Bridge
import Css
import Effect exposing (Effect)
import Html.Styled exposing (a, button, div, h2, span, text)
import Html.Styled.Attributes exposing (css, href)
import Lamdera
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Tailwind.Breakpoints exposing (sm)
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
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
                [ div [ css [ Tw.inline_flex, Tw.rounded_md, Tw.shadow ] ]
                    [ a
                        [ href "/spelling"
                        , css
                            [ Tw.rounded_md
                            , Tw.bg_color Theme.indigo_600
                            , Tw.text_base
                            , Tw.font_medium
                            , Tw.text_color Theme.white
                            , Tw.mx_3
                            , Css.hover [ Tw.bg_color Theme.indigo_700 ]
                            ]
                        ]
                        [ button [ css [ Tw.px_5, Tw.py_3 ] ] [ text "[Oskar] Start" ] ]
                    , a
                        [ href "/spelling2"
                        , css
                            [ Tw.rounded_md
                            , Tw.bg_color Theme.indigo_600
                            , Tw.text_base
                            , Tw.font_medium
                            , Tw.text_color Theme.white
                            , Tw.mx_3
                            , Css.hover [ Tw.bg_color Theme.indigo_700 ]
                            ]
                        ]
                        [ button [ css [ Tw.px_5, Tw.py_3 ] ] [ text "[Rina] Start" ] ]
                    ]
                ]
            ]
        ]
    }
