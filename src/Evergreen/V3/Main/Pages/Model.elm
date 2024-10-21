module Evergreen.V3.Main.Pages.Model exposing (..)

import Evergreen.V3.Pages.Home_
import Evergreen.V3.Pages.NotFound_
import Evergreen.V3.Pages.Spelling


type Model
    = Home_ Evergreen.V3.Pages.Home_.Model
    | Spelling Evergreen.V3.Pages.Spelling.Model
    | NotFound_ Evergreen.V3.Pages.NotFound_.Model
    | Redirecting_
    | Loading_
