module Evergreen.V11.Main.Pages.Msg exposing (..)

import Evergreen.V11.Pages.Home_
import Evergreen.V11.Pages.NotFound_
import Evergreen.V11.Pages.Spelling
import Evergreen.V11.Pages.Spelling2


type Msg
    = Home_ Evergreen.V11.Pages.Home_.Msg
    | Spelling Evergreen.V11.Pages.Spelling.Msg
    | Spelling2 Evergreen.V11.Pages.Spelling2.Msg
    | NotFound_ Evergreen.V11.Pages.NotFound_.Msg
