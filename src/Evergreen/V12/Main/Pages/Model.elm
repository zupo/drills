module Evergreen.V12.Main.Pages.Model exposing (..)

import Evergreen.V12.Pages.Home_
import Evergreen.V12.Pages.NotFound_
import Evergreen.V12.Pages.Spelling


type Model
    = Home_ Evergreen.V12.Pages.Home_.Model
    | Spelling Evergreen.V12.Pages.Spelling.Model
    | NotFound_ Evergreen.V12.Pages.NotFound_.Model
    | Redirecting_
    | Loading_
