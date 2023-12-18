module View exposing (content, footer, header, menu, related, view)

import Colors exposing (deepskyblue)
import Element
    exposing
        ( Attribute
        , DeviceClass(..)
        , Element
        , Orientation(..)
        , alignLeft
        , centerX
        , centerY
        , clip
        , column
        , el
        , fill
        , fillPortion
        , height
        , image
        , layout
        , link
        , maximum
        , minimum
        , newTabLink
        , padding
        , paddingXY
        , paragraph
        , row
        , shrink
        , spacing
        , spacingXY
        , text
        , textColumn
        , width
        )
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    let
        responsiveLayout =
            case ( model.class, model.orientation ) of
                ( Phone, Portrait ) ->
                    phonePortraitLayout

                ( Phone, Landscape ) ->
                    phoneLandscapeLayout

                ( Tablet, Portrait ) ->
                    tabletLayout

                ( Tablet, Landscape ) ->
                    tabletLayout

                ( Desktop, Portrait ) ->
                    tabletLayout

                ( Desktop, Landscape ) ->
                    desktopLayout

                ( BigDesktop, _ ) ->
                    bigDesktopLayout
    in
    layout [ height fill, width fill ] responsiveLayout



-- LAYOUTS


phonePortraitLayout : Element Msg
phonePortraitLayout =
    column [ height fill, width fill ]
        [ phonePortraitContent []
        , footer []
        ]


phoneLandscapeLayout : Element Msg
phoneLandscapeLayout =
    column [ height fill, width fill ]
        [ content []
        , footer []
        ]


tabletLayout : Element Msg
tabletLayout =
    phoneLandscapeLayout


desktopLayout : Element Msg
desktopLayout =
    column [ height fill, width fill, paddingXY 100 0 ]
        [ content []
        , footer []
        ]


bigDesktopLayout : Element Msg
bigDesktopLayout =
    desktopLayout



-- ELEMENTS


header : List (Attribute Msg) -> Element Msg
header attr =
    el
        ([ padding 15
         , width fill
         ]
            ++ attr
        )
    <|
        el [ centerY ] <|
            text ""


menu : List (Attribute Msg) -> Element Msg
menu attr =
    el
        ([ padding 15
         , width fill
         , Region.navigation
         ]
            ++ attr
        )
        (text "Menu")


content : List (Attribute Msg) -> Element Msg
content attr =
    row
        ([ padding 15
         , height fill
         , width fill
         , spacing 15
         , Region.mainContent
         ]
            ++ attr
        )
    <|
        [ avatarPicture [ width <| maximum 250 <| fillPortion 1 ]
        , bioSection [ width <| fillPortion 2 ]
        ]


phoneLandscapeContent : List (Attribute Msg) -> Element Msg
phoneLandscapeContent attr =
    column
        ([ padding 15
         , width fill
         , height fill
         , Region.mainContent
         ]
            ++ attr
        )
    <|
        [ el [ height <| fillPortion 1 ] (text "")
        , avatarPicture [ centerX, height <| maximum 250 <| fillPortion 4 ]
        , el [ height <| fillPortion 1 ] (text "")
        , bioSection [ centerX, height <| fillPortion 6 ]
        , el [ height <| fillPortion 1 ] (text "")
        ]


phonePortraitContent : List (Attribute Msg) -> Element Msg
phonePortraitContent attr =
    column
        ([ padding 15
         , width fill
         , height fill
         , Region.mainContent
         ]
            ++ attr
        )
    <|
        [ avatarPicture [ centerX, width <| maximum 200 <| fill ]
        , el [ height <| maximum 20 <| fillPortion 1 ] (text "")
        , bioSection [ centerX, height <| fillPortion 3 ]
        , el [ height <| maximum 20 <| fillPortion 1 ] (text "")
        ]


avatarPicture : List (Attribute Msg) -> Element Msg
avatarPicture attr =
    image ([ Border.width 2, Border.rounded 6 ] ++ attr) { src = "/birkir.webp", description = "A profile picture of Birkir Ólafsson" }


bioSection : List (Attribute Msg) -> Element Msg
bioSection attr =
    textColumn
        ([ spacing 15, width fill ] ++ attr)
        [ paragraph
            []
            [ text "Hi, I'm Birkir Ólafsson." ]
        , paragraph
            []
            [ text "I'm a software developer and consultant based in Reykjavik, Iceland, where I live with my wife and four children." ]
        , paragraph
            []
            [ text "Problem-solving is what motivates me and keeps me focused" ]
        ]


related : List (Attribute Msg) -> Element Msg
related attr =
    el
        ([ padding 15
         , width fill
         , Region.aside
         ]
            ++ attr
        )
        (text "Related content")


footer : List (Attribute Msg) -> Element Msg
footer attr =
    el
        [ padding 15
        , width fill
        , Region.footer
        ]
    <|
        paragraph
            []
            [ text "Feel free to contact me through email at "
            , emailLink
            , text " or check out my "
            , cvLink
            ]


emailLink : Element Msg
emailLink =
    link [ Font.underline ] { url = "mailto:birkir@birkirolafs.is", label = text "birkir@birkirolafs.is" }


cvLink : Element Msg
cvLink =
    newTabLink [ Font.underline ] { url = "/birkir_olafs_cv_2023.pdf", label = text "CV" }
