module Evergreen.V12.Main.Pages.Msg exposing (..)

import Evergreen.V12.Pages.Home_
import Evergreen.V12.Pages.NotFound_
import Evergreen.V12.Pages.Spelling


type Msg
    = Home_ Evergreen.V12.Pages.Home_.Msg
    | Spelling Evergreen.V12.Pages.Spelling.Msg
    | NotFound_ Evergreen.V12.Pages.NotFound_.Msg
