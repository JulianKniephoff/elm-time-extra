module Time.Extra
  ( fromFps
  , toFps
  , timestamps
  , everyWhen
  ) where

{-| Utility functions that aren't in the `Time` module
from  `elm-lang/core`.

# Conversions
@docs fromFps, toFps

# Signals
@docs timestamps, everyWhen
-}

import Time exposing (..)

{-| Converts a number of ticks per second
into the corresponding interval between to ticks.
-}
fromFps : Float -> Time
fromFps fps = 1 / fps

{-| Get the FPS corresponding to a given time between to frames.
-}
toFps : Time -> Float
toFps interval = 1 / (interval |> inSeconds)

{-| Extract the timestamps of the updates of the given signal.
-}
timestamps : Signal a -> Signal Time
timestamps = timestamp >> (Signal.map fst)

{-| Same as the `Time.every` function,
but you can turn it on and off.
-}
everyWhen : Time -> Signal Bool -> Signal Time
everyWhen interval predicate =
  timestamps (fpsWhen (toFps interval) predicate)
