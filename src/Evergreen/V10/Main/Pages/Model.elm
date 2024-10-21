module Evergreen.V10.Main.Pages.Model exposing (..)

import Evergreen.V10.Pages.Home_
import Evergreen.V10.Pages.NotFound_
import Evergreen.V10.Pages.Spelling
import Evergreen.V10.Pages.Spelling2


type Model
    = Home_ Evergreen.V10.Pages.Home_.Model
    | Spelling Evergreen.V10.Pages.Spelling.Model
    | Spelling2 Evergreen.V10.Pages.Spelling2.Model
    | NotFound_ Evergreen.V10.Pages.NotFound_.Model
    | Redirecting_
    | Loading_
