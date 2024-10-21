module Evergreen.V11.Main.Pages.Model exposing (..)

import Evergreen.V11.Pages.Home_
import Evergreen.V11.Pages.NotFound_
import Evergreen.V11.Pages.Spelling
import Evergreen.V11.Pages.Spelling2


type Model
    = Home_ Evergreen.V11.Pages.Home_.Model
    | Spelling Evergreen.V11.Pages.Spelling.Model
    | Spelling2 Evergreen.V11.Pages.Spelling2.Model
    | NotFound_ Evergreen.V11.Pages.NotFound_.Model
    | Redirecting_
    | Loading_
