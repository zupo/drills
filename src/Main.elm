port module Main exposing (..)

import Array
import Browser exposing (Document)
import Browser.Dom as Dom
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Random exposing (..)
import Task


main =
    Browser.document { init = init, update = update, subscriptions = subscriptions, view = view }


words =
    [ "air"
    , "fair"
    , "dairy"
    , "hair"
    , "pair"
    , "chair"
    , "fairy"
    , "stairs"
    , "she"
    , "we"
    ]


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



-- MODEL


type State
    = Welcome
    | Playing
    | Finished


type alias Model =
    { state : State
    , actual : String
    , expected : Maybe String
    , words : Array.Array String
    , currentWordIndex : Int
    , gifs_random_index : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { state = Welcome
      , actual = ""
      , expected = Nothing
      , words = Array.fromList words
      , currentWordIndex = 0
      , gifs_random_index = 0
      }
    , List.length gifs |> oneToX |> Random.generate RandomNumber
    )


loadWord : Model -> Model
loadWord model =
    { model | expected = Array.get model.currentWordIndex model.words }



-- PORTS


port say : String -> Cmd msg



-- UPDATE


type Msg
    = KeyInput String
    | ButtonRepeat
    | ButtonNext
    | RandomNumber Int
    | Focus (Result Dom.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RandomNumber x ->
            ( { model | gifs_random_index = x - 1 }, Cmd.none )

        Focus _ ->
            ( model, Cmd.none )

        KeyInput newContent ->
            ( { model | actual = newContent |> String.trim }, Cmd.none )

        ButtonRepeat ->
            ( model, Maybe.withDefault "" model.expected |> say )

        ButtonNext ->
            case model.state of
                Welcome ->
                    let
                        updated_model =
                            loadWord model
                    in
                    case updated_model.expected of
                        Just expected ->
                            ( { updated_model | state = Playing }, Cmd.batch [ say expected, focus "actual" ] )

                        Nothing ->
                            ( { model | state = Finished }, Cmd.none )

                Playing ->
                    let
                        updated_model =
                            loadWord { model | currentWordIndex = model.currentWordIndex + 1, actual = "" }
                    in
                    case updated_model.expected of
                        Just expected ->
                            ( updated_model, Cmd.batch [ say expected, focus "actual" ] )

                        Nothing ->
                            ( { model | state = Finished }, say "Well done!" )

                Finished ->
                    ( { model | currentWordIndex = 0, actual = "", expected = Nothing }, Cmd.none )


oneToX : Int -> Random.Generator Int
oneToX x =
    Random.int 1 x


focus : String -> Cmd Msg
focus id =
    Dom.focus id |> Task.attempt Focus



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Spellings"
    , body =
        [ div [ class "flex flex-col h-screen justify-center items-center" ] (content model)
        ]
    }


content : Model -> List (Html Msg)
content model =
    case model.state of
        Welcome ->
            contentWelcome model

        Playing ->
            contentPlaying model

        Finished ->
            contentFinished model


contentWelcome : Model -> List (Html Msg)
contentWelcome model =
    [ h2 [ class "text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl text-center" ]
        [ span [ class "block" ]
            [ text "Ready to practice spellings?" ]
        , span [ class "block" ]
            [ text "Press start!" ]
        ]
    , div [ class "mt-8 flex justify-center" ]
        [ div [ class "inline-flex rounded-md shadow" ]
            [ a [ class "rounded-md border border-transparent bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700" ]
                [ button [ onClick ButtonNext, class "px-5 py-3" ] [ text "Start" ] ]
            ]
        ]
    ]


contentPlaying : Model -> List (Html Msg)
contentPlaying model =
    case model.expected of
        Just expected ->
            let
                visible =
                    if model.actual == expected then
                        "visible"

                    else
                        "invisible"
            in
            [ input
                [ class "block rounded-full border-gray-300 px-4 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
                , type_ "text"
                , id "actual"
                , placeholder "start typing"
                , value model.actual
                , onInput KeyInput
                ]
                []
            , button [ class "py-3", onClick ButtonRepeat ] [ text "📢" ]
            , h2
                [ class "text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl py-4"
                , class visible
                ]
                [ text "Correct!" ]
            , a
                [ class "rounded-md border border-transparent bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700"
                , class visible
                ]
                [ button [ onClick ButtonNext, class "px-5 py-1" ] [ text "Next word" ] ]
            , img
                [ src ("https://cataas.com/cat/says/" ++ expected)
                , class "py-4 h-1/2"
                , class visible
                ]
                []
            ]

        Nothing ->
            [ text "Initialization error: missing words" ]


contentFinished : Model -> List (Html Msg)
contentFinished model =
    [ h2 [ class "text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl" ]
        [ span [ class "block" ]
            [ text "Finished!" ]
        ]
    , img
        [ Array.fromList gifs |> Array.get model.gifs_random_index |> Maybe.withDefault "" |> src
        , class "py-4 h-1/2"
        ]
        []
    ]


viewValidation : Model -> Html Msg
viewValidation model =
    case model.expected of
        Just expected ->
            if String.length model.actual < 3 then
                div [] []

            else if model.actual == expected then
                div []
                    [ div []
                        [ h2 [ class "text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl py-4" ]
                            [ text "Correct!" ]
                        , a [ class "inline-flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-5 py-1 text-base font-medium text-white hover:bg-indigo-700" ]
                            [ button [ onClick ButtonNext ] [ text "Next word" ] ]
                        ]
                    , img [ src ("https://cataas.com/cat/says/" ++ expected), class "h-1" ] []
                    ]

            else
                div [ style "color" "orange" ] [ text "Keep trying!" ]

        Nothing ->
            text "Initialization error: missing words"
