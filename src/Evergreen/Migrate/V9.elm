module Evergreen.Migrate.V9 exposing (..)

{-| This migration file was automatically generated by the lamdera compiler.

It includes:

  - A migration for each of the 6 Lamdera core types that has changed
  - A function named `migrate_ModuleName_TypeName` for each changed/custom type

Expect to see:

  - `Unimplementеd` values as placeholders wherever I was unable to figure out a clear migration path for you
  - `@NOTICE` comments for things you should know about, i.e. new custom type constructors that won't get any
    value mappings from the old type by default

You can edit this file however you wish! It won't be generated again.

See <https://dashboard.lamdera.app/docs/evergreen> for more info.

-}

import Evergreen.V3.Main
import Evergreen.V3.Main.Pages.Model
import Evergreen.V3.Main.Pages.Msg
import Evergreen.V3.Pages.Home_
import Evergreen.V3.Pages.NotFound_
import Evergreen.V3.Pages.Spelling
import Evergreen.V3.Shared
import Evergreen.V3.Shared.Model
import Evergreen.V3.Shared.Msg
import Evergreen.V3.Types
import Evergreen.V9.Main
import Evergreen.V9.Main.Pages.Model
import Evergreen.V9.Main.Pages.Msg
import Evergreen.V9.Pages.Home_
import Evergreen.V9.Pages.NotFound_
import Evergreen.V9.Pages.Spelling
import Evergreen.V9.Shared
import Evergreen.V9.Shared.Model
import Evergreen.V9.Shared.Msg
import Evergreen.V9.Types
import Lamdera.Migrations exposing (..)
import List


frontendModel : Evergreen.V3.Types.FrontendModel -> ModelMigration Evergreen.V9.Types.FrontendModel Evergreen.V9.Types.FrontendMsg
frontendModel old =
    ModelReset


backendModel : Evergreen.V3.Types.BackendModel -> ModelMigration Evergreen.V9.Types.BackendModel Evergreen.V9.Types.BackendMsg
backendModel old =
    ModelUnchanged


frontendMsg : Evergreen.V3.Types.FrontendMsg -> MsgMigration Evergreen.V9.Types.FrontendMsg Evergreen.V9.Types.FrontendMsg
frontendMsg old =
    MsgOldValueIgnored


toBackend : Evergreen.V3.Types.ToBackend -> MsgMigration Evergreen.V9.Types.ToBackend Evergreen.V9.Types.BackendMsg
toBackend old =
    MsgUnchanged


backendMsg : Evergreen.V3.Types.BackendMsg -> MsgMigration Evergreen.V9.Types.BackendMsg Evergreen.V9.Types.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Evergreen.V3.Types.ToFrontend -> MsgMigration Evergreen.V9.Types.ToFrontend Evergreen.V9.Types.FrontendMsg
toFrontend old =
    MsgUnchanged