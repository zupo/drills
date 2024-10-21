module Evergreen.V9.Main.Pages.Msg exposing (..)

import Evergreen.V9.Pages.Home_
import Evergreen.V9.Pages.NotFound_
import Evergreen.V9.Pages.Spelling
import Evergreen.V9.Pages.Spelling2


type Msg
    = Home_ Evergreen.V9.Pages.Home_.Msg
    | Spelling Evergreen.V9.Pages.Spelling.Msg
    | Spelling2 Evergreen.V9.Pages.Spelling2.Msg
    | NotFound_ Evergreen.V9.Pages.NotFound_.Msg
