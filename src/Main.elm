module Main exposing (Model, Msg(..), Validation(..), main, model, update, validate, view, viewValidation)

import Browser
import Char exposing (isDigit, isLower, isUpper)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String


main =
    Browser.sandbox { init = init, update = update, view = view }


type Validation
    = None
    | Ok
    | Error String


type alias Model =
    { name : String
    , password : String
    , pwAgain : String
    , age : String
    , valid : Validation
    }


model : Model
model =
    { name = ""
    , password = ""
    , pwAgain = ""
    , age = ""
    , valid = None
    }


init : Model
init =
    Model "" "" "" "" None


type Msg
    = Name String
    | Password String
    | PwAgain String
    | Age String
    | Check


update : Msg -> Model -> Model
update msg myModel =
    case msg of
        Name name ->
            { myModel | name = name }

        Password password ->
            { myModel | password = password }

        PwAgain pwAgain ->
            { myModel | pwAgain = pwAgain }

        Age age ->
            { myModel | age = age }

        Check ->
            { myModel | valid = validate myModel }


validate : Model -> Validation
validate myModel =
    if myModel.password /= myModel.pwAgain then
        Error "Passwords don't match"

    else if String.length myModel.password < 8 then
        Error "Password must be 8 characters or more"

    else if not (String.any isDigit myModel.password) then
        Error "Password must contain digits"

    else if not (String.any isUpper myModel.password) then
        Error "Password must contain uppercase"

    else if not (String.any isLower myModel.password) then
        Error "Password must contain lowercase"

    else if String.length myModel.age == 0 then
        Error "Enter age"

    else if not (String.all isDigit myModel.age) then
        Error "Age must be a number"

    else
        Ok


view : Model -> Html Msg
view myModel =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Re-enter Password", onInput PwAgain ] []
        , input [ type_ "text", placeholder "Age", onInput Age ] []
        , button [ onClick Check ] [ text "Submit" ]
        , viewValidation myModel
        ]


viewValidation : Model -> Html Msg
viewValidation myModel =
    let
        ( color, message ) =
            case myModel.valid of
                Ok ->
                    ( "green", "OK" )

                Error err ->
                    ( "red", err )

                None ->
                    ( "black", "Enter your details" )
    in
    div [ style "color" color ] [ text message ]
