module Main.Pages.Msg exposing (Msg(..))

import Pages.Home_
import Pages.Spelling
import Pages.NotFound_


type Msg
    = Home_ Pages.Home_.Msg
    | Spelling Pages.Spelling.Msg
    | NotFound_ Pages.NotFound_.Msg
