module Evergreen.V9.Main.Pages.Model exposing (..)

import Evergreen.V9.Pages.Home_
import Evergreen.V9.Pages.NotFound_
import Evergreen.V9.Pages.Spelling
import Evergreen.V9.Pages.Spelling2


type Model
    = Home_ Evergreen.V9.Pages.Home_.Model
    | Spelling Evergreen.V9.Pages.Spelling.Model
    | Spelling2 Evergreen.V9.Pages.Spelling2.Model
    | NotFound_ Evergreen.V9.Pages.NotFound_.Model
    | Redirecting_
    | Loading_
