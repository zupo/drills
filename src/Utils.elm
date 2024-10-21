module Utils exposing (href, hrefQS)

import Dict exposing (Dict)
import Html.Styled
import Html.Styled.Attributes
import Route
import Route.Path



-- These two are needed because Route.href and Route.Path.href emit
-- Html.Attribute msg, but we need Html.Styled.Attribute msg
-- Maybe in the future `elm-land customize routes` will support this
-- usecase


href : Route.Path.Path -> Html.Styled.Attribute msg
href path =
    Html.Styled.Attributes.href (Route.Path.toString path)


hrefQS : { path : Route.Path.Path, query : Dict String String } -> Html.Styled.Attribute msg
hrefQS route =
    Html.Styled.Attributes.href (Route.toString { path = route.path, query = route.query, hash = Nothing })
