module Evergreen.V3.Main.Pages.Msg exposing (..)

import Evergreen.V3.Pages.Home_
import Evergreen.V3.Pages.NotFound_
import Evergreen.V3.Pages.Spelling


type Msg
    = Home_ Evergreen.V3.Pages.Home_.Msg
    | Spelling Evergreen.V3.Pages.Spelling.Msg
    | NotFound_ Evergreen.V3.Pages.NotFound_.Msg
