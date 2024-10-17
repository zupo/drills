module Evergreen.V12.Main.Pages.Model exposing (..)

import Evergreen.V12.Pages.Home_
import Evergreen.V12.Pages.NotFound_


type Model
    = Home_ Evergreen.V12.Pages.Home_.Model
    | NotFound_ Evergreen.V12.Pages.NotFound_.Model
    | Redirecting_
    | Loading_
