module Evergreen.V10.Main.Pages.Msg exposing (..)

import Evergreen.V10.Pages.Home_
import Evergreen.V10.Pages.NotFound_
import Evergreen.V10.Pages.Spelling
import Evergreen.V10.Pages.Spelling2


type Msg
    = Home_ Evergreen.V10.Pages.Home_.Msg
    | Spelling Evergreen.V10.Pages.Spelling.Msg
    | Spelling2 Evergreen.V10.Pages.Spelling2.Msg
    | NotFound_ Evergreen.V10.Pages.NotFound_.Msg
