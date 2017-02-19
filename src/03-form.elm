import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
  Html.beginnerProgram {
    model = model,
    view = view,
    update = update
  }

-- Model

type alias Model =
  {
    name: String,
    password: String,
    passwordAgain: String
  }

model: Model
model =
  Model "" "" ""

-- Update

type Msg = Name String | Password String | PasswordAgain String

update: Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      {model | name = name}
    Password name ->
      {model | password = name}
    PasswordAgain name ->
      {model | passwordAgain = name}


-- View

view: Model -> Html Msg
view model =
  div []
    [
      input [type_ "text", placeholder "Name", onInput Name][],
      input [type_ "password", placeholder "Password", onInput Password][],
      input [type_ "password", placeholder "Re-enter Password", onInput PasswordAgain][],
      passwordValidation model
    ]

passwordValidation: Model -> Html msg
passwordValidation model =
  let
    (color, message) =
      if String.length model.passwordAgain == 0 then
        ("", "")
      else if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match")
  in
    div [style [("color", color)]] [text message]
