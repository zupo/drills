module Pages.Spelling exposing (Model, Msg, Player(..), State, Word, page, playerToString)

import Array
import Browser.Dom as Dom
import Browser.Navigation exposing (load)
import Css exposing (focus, hover)
import Dict
import Effect exposing (Effect)
import Html.Styled exposing (Html, a, button, div, h2, img, input, span, text)
import Html.Styled.Attributes exposing (class, css, href, id, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Page exposing (Page)
import Random
import Route exposing (Route)
import Route.Path
import Shared
import Tailwind.Breakpoints exposing (sm)
import Tailwind.Theme as Theme
import Tailwind.Utilities as Tw
import Task exposing (Task)
import Time exposing (Posix)
import Utils
import View exposing (View)


page : Shared.Model -> Route () -> Page Model Msg
page _ route =
    Page.new
        { init = init route
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Word =
    String


words : Maybe Player -> List Word
words player =
    case player of
        Just Rina ->
            [ "business"
            , "actor"
            , "businesswoman"
            , "businessman"
            , "factory"
            , "artist"
            , "designer"
            , "astronaut"
            , "fire fighter"
            , "engineer"
            ]

        Just Oskar ->
            [ "right"
            , "light"
            , "night"
            , "bright"
            , "might"
            , "tonight"
            , "sunlight"
            , "I"
            , "bye"
            , "my"
            ]

        Nothing ->
            []


gifs : List String
gifs =
    [ "https://64.media.tumblr.com/dde0fdf5c5109dba56dbeacf2094276e/tumblr_nwbnk7qbGf1rfm34io1_250.gifv"
    , "https://64.media.tumblr.com/eca79024cec4cc949874bef677c23de8/tumblr_mxbta5zEaa1rg35k5o1_400.gifv"
    , "https://64.media.tumblr.com/e196446b73231a6a463fde8e4b6a0ac6/tumblr_mwvvibAaZL1slwrsuo1_250.gifv"
    , "https://media0.giphy.com/media/pxGKhhlMv2Awg/giphy.gif?cid=790b761183f42390c7d7e30d5a9b347678b01db9190b18ac&rid=giphy.gif&ct=g"
    , "https://64.media.tumblr.com/7c3f783885aa929972f37dc92b4787a8/tumblr_mylv6yuJ6n1ra8x2co1_400.gifv"
    , "https://media1.giphy.com/media/1HKaikaFqDt7i/giphy.gif?cid=790b761112f03b66b3d07105db0e4727e470dee50fa24104&rid=giphy.gif&ct=g"
    , "https://media4.giphy.com/media/12c7MQi3q492Hm/giphy.gif?cid=790b7611fad4b59bd7be72ed4f6451e95c4b28be52144363&rid=giphy.gif&ct=g"
    , "https://media3.giphy.com/media/mM08Ca5WLdJw4/giphy.gif?cid=790b7611d83b826b5378c55df4974a9c19869081e25fbecc&rid=giphy.gif&ct=g"
    , "https://media0.giphy.com/media/100MY9QRHJe9DG/giphy.gif?cid=790b7611c681db7ea34b7fb7ebb89cfa3a2ccf6d34ee08c8&rid=giphy.gif&ct=g"
    , "https://media0.giphy.com/media/JhUZYdpnqrgcM/giphy.gif?cid=790b761193bb4a6655e2bf1328a61570790970242369a44c&rid=giphy.gif&ct=g"
    , "https://media0.giphy.com/media/XNdoIMwndQfqE/giphy.gif?cid=790b7611782871e02d96a8d81cb891f43dfe2dca1b676a7a&rid=giphy.gif&ct=g"
    , "https://media2.giphy.com/media/13tks6KkV5Crzq/giphy.gif?cid=790b761102a45c5029bc331ab8abe863f51c0aaac63f17f4&rid=giphy.gif&ct=g"
    , "https://media2.giphy.com/media/ioYrOflf6vfXO/giphy.gif?cid=790b7611879c54f4760b50aeb7394879b1c3b2afea948845&rid=giphy.gif&ct=g"
    , "https://media3.giphy.com/media/Y260AqiEPWewE/giphy.gif?cid=790b7611d7d7f42740e997572ffd0d09e6d4a482177afbe6&rid=giphy.gif&ct=g"
    , "https://media0.giphy.com/media/XVHVUJm4ElVbq/giphy.gif?cid=790b761193c3e001acb1cf6fa8293a542a01617eaa05a576&rid=giphy.gif&ct=g"
    , "https://media1.giphy.com/media/W2FXGIVejFptc6CSxY/giphy.gif?cid=790b7611ff953c275e24a4b78cc3bc794f0ed616a5ea4290&rid=giphy.gif&ct=g"
    , "https://media3.giphy.com/media/jgM9t6pPY0www/giphy.gif?cid=790b7611dd2900d4ff6cea3445011b1f8ecd6b3686aceec2&rid=giphy.gif&ct=g"
    , "https://media1.giphy.com/media/tBxyh2hbwMiqc/giphy.gif?cid=790b7611133255dea7a82693869aadb1e15280dbbb65d7cc&rid=giphy.gif&ct=g"
    , "https://media4.giphy.com/media/WPWrU2AeK3aV2/giphy.gif?cid=790b7611c0fa24dcedd86f62c741bda2be35c765800e68c7&rid=giphy.gif&ct=g"
    ]



-- INIT


type alias Model =
    { state : State
    , actual : String
    , expected : Word
    , remaining : List Word
    , gifs_random_index : Int
    , startTime : Maybe Posix
    , elapsed : Int
    , player : Maybe Player
    }


type State
    = Playing
    | Correct
    | Finished


type Player
    = Rina
    | Oskar


playerToString : Player -> String
playerToString player =
    case player of
        Rina ->
            "rina"

        Oskar ->
            "oskar"


init : Route () -> () -> ( Model, Effect Msg )
init route () =
    let
        player : Maybe Player
        player =
            loadPlayer route

        expected : Word
        expected =
            List.head (words player) |> Maybe.withDefault "" |> String.toLower

        remaining : List Word
        remaining =
            List.tail (words player) |> Maybe.withDefault []

        effects : List (Effect Msg)
        effects =
            if remaining == [] then
                [ load "/" |> Effect.sendCmd ]

            else
                [ List.length gifs |> oneToX |> Random.generate RandomNumber |> Effect.sendCmd
                , Task.perform GotStartTime Time.now |> Effect.sendCmd
                , expected |> Effect.say
                , focusElement "actual"
                ]
    in
    ( { state = Playing
      , actual = ""
      , expected = expected
      , remaining = remaining
      , gifs_random_index = 0
      , startTime = Nothing
      , elapsed = 0
      , player = loadPlayer route
      }
    , Effect.batch effects
    )


loadPlayer : Route () -> Maybe Player
loadPlayer route =
    let
        player : String
        player =
            Dict.get "player" route.query |> Maybe.withDefault "" |> String.toLower
    in
    case player of
        "rina" ->
            Just Rina

        "oskar" ->
            Just Oskar

        _ ->
            Nothing



-- UPDATE


nextWord : Model -> Model
nextWord model =
    case model.remaining of
        [] ->
            { model | state = Finished }

        x :: xs ->
            { model | expected = x |> String.toLower, remaining = xs, actual = "", state = Playing }


type Msg
    = KeyInput String
    | ButtonRepeat
    | ButtonNext
    | RandomNumber Int
    | Focus (Result Dom.Error ())
    | GotStartTime Posix
    | Tick Posix


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        RandomNumber x ->
            ( { model | gifs_random_index = x - 1 }, Effect.none )

        Focus _ ->
            ( model, Effect.none )

        GotStartTime time ->
            ( { model | startTime = Just time }, Effect.none )

        Tick currentTime ->
            case model.startTime of
                Just start ->
                    let
                        elapsed : Int
                        elapsed =
                            Time.posixToMillis currentTime - Time.posixToMillis start
                    in
                    ( { model | elapsed = elapsed }, Effect.none )

                Nothing ->
                    ( model, Effect.none )

        KeyInput newContent ->
            let
                actual : String
                actual =
                    newContent |> String.trim |> String.toLower
            in
            if actual == model.expected then
                ( { model | actual = actual, state = Correct }, focusElement "next-word" )

            else
                ( { model | actual = actual }, Effect.none )

        ButtonRepeat ->
            ( model
            , Effect.batch [ model.expected |> Effect.say, focusElement "actual" ]
            )

        ButtonNext ->
            case model.state of
                Playing ->
                    ( model, Effect.none )

                Correct ->
                    let
                        updated_model : Model
                        updated_model =
                            nextWord model
                    in
                    if updated_model.state == Finished then
                        ( updated_model, Effect.say "Well done!" )

                    else
                        ( updated_model
                        , Effect.batch
                            [ updated_model.expected |> Effect.say
                            , Task.perform GotStartTime (nowPlusElapsed model.elapsed) |> Effect.sendCmd
                            , focusElement "actual"
                            ]
                        )

                Finished ->
                    ( model, Effect.none )


nowPlusElapsed : Int -> Task Never Posix
nowPlusElapsed elapsed =
    Time.now
        |> Task.map
            (\currentTime ->
                let
                    currentMillis : Int
                    currentMillis =
                        Time.posixToMillis currentTime

                    futureMillis : Int
                    futureMillis =
                        currentMillis - elapsed
                in
                Time.millisToPosix futureMillis
            )


oneToX : Int -> Random.Generator Int
oneToX x =
    Random.int 1 x


focusElement : String -> Effect Msg
focusElement id =
    Dom.focus id |> Task.attempt Focus |> Effect.sendCmd



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.state of
        Playing ->
            Time.every 1000 Tick

        _ ->
            Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Spellings"
    , body =
        [ text ("Elapsed time: " ++ (toFloat model.elapsed / 1000 |> round |> String.fromInt) ++ " seconds")
        , div [ css [ Tw.flex, Tw.flex_col, Tw.h_screen, Tw.justify_center, Tw.items_center ] ] (content model)
        ]
    }


content : Model -> List (Html Msg)
content model =
    case model.state of
        Playing ->
            contentPlaying model

        Correct ->
            contentCorrect model

        Finished ->
            contentFinished model


contentPlaying : Model -> List (Html Msg)
contentPlaying model =
    [ input
        [ css [ Tw.block, Tw.rounded_full, Tw.border_color Theme.gray_300, Tw.px_4, Tw.shadow_sm, focus [ Tw.border_color Theme.indigo_500, Tw.ring_color Theme.indigo_500 ], sm [ Tw.text_sm ] ]
        , type_ "text"
        , id "actual"
        , placeholder "start typing"
        , value model.actual
        , onInput KeyInput
        ]
        []
    , button [ css [ Tw.py_3 ], onClick ButtonRepeat ] [ text "📢" ]
    ]


contentCorrect : Model -> List (Html Msg)
contentCorrect model =
    [ h2
        [ css [ Tw.text_3xl, Tw.font_bold, Tw.tracking_tight, Tw.text_color Theme.gray_900, sm [ Tw.text_4xl, Tw.py_4 ] ]
        ]
        [ text "Correct!" ]
    , a
        [ css [ Tw.rounded_md, Tw.border, Tw.border_color Theme.transparent, Tw.bg_color Theme.indigo_600, Tw.text_base, Tw.font_medium, Tw.text_color Theme.white, hover [ Tw.bg_color Theme.indigo_700 ] ]
        , href ""
        ]
        [ button
            [ onClick ButtonNext
            , css [ Tw.px_5, Tw.py_1 ]
            , id "next-word"
            ]
            [ text "Next word" ]
        ]
    , img
        [ src ("https://cataas.com/cat/says/" ++ model.expected |> String.toLower)
        , css [ Tw.py_4, Tw.h_1over2 ]
        ]
        []
    ]


contentFinished : Model -> List (Html Msg)
contentFinished model =
    [ h2 [ css [ Tw.text_3xl, Tw.font_bold, Tw.tracking_tight, Tw.text_color Theme.gray_900, sm [ Tw.text_4xl ] ] ]
        [ span [ class "block" ]
            [ text "Finished!" ]
        ]
    , span [] [ text ("It took you " ++ (toFloat model.elapsed / 1000 |> round |> String.fromInt) ++ " seconds") ]
    , img
        [ Array.fromList gifs |> Array.get model.gifs_random_index |> Maybe.withDefault "" |> src
        , css [ Tw.py_4, Tw.h_1over2 ]
        ]
        []
    , a [ Utils.href Route.Path.Home_ ] [ text "Back to Start" ]
    ]
