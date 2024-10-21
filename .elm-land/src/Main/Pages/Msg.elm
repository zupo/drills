module Main.Pages.Msg exposing (Msg(..))

import Pages.Home_
import Pages.Spelling
import Pages.Spelling2
import Pages.NotFound_


type Msg
    = Home_ Pages.Home_.Msg
    | Spelling Pages.Spelling.Msg
    | Spelling2 Pages.Spelling2.Msg
    | NotFound_ Pages.NotFound_.Msg
