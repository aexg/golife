module Main exposing (Model, Msg(..), main, stars, update, view)

import Browser
import Html
import Html.Attributes exposing (class)
import Html.Events


type alias Model =
    Int


type Msg
    = Increase
    | Decrease


stars : Int -> Html.Html msg
stars rating =
    (String.repeat rating "★" ++ String.repeat (5 - rating) "☆") |> Html.text


view model =
    Html.div [ class "main" ]
        [ Html.button [ class "increase", Html.Events.onClick Increase ] [ Html.text "Increase" ]
        , Html.button [ class "decrease", Html.Events.onClick Decrease ] [ Html.text "Decrease" ]
        , Html.div [ class "starrating" ] [ stars model ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increase ->
            if model == 5 then
                model

            else
                model + 1

        Decrease ->
            if model == 1 then
                model

            else
                model - 1


main =
    Browser.sandbox { init = 1, view = view, update = update }
