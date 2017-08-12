{-# LANGUAGE OverloadedStrings #-}

module Card.Page where

import Reflex.Dom
import qualified Data.Text as T
import Data.Text.Lazy (toStrict)
import Data.Monoid
import qualified Data.Map as Map

card :: MonadWidget t m => T.Text -> [(T.Text, a)] -> m (Event t a)
card header buttons = do
  el "header" . text $ header
  divClass "button-row" $ leftmost <$>
    traverse (\(l, r) -> (r <$) <$> button l) buttons

transitionCard :: MonadWidget t m => Int -> m (Event t ())
transitionCard n = card ("Are you Player " <> (T.pack . show $ n)) [("Yes", ())]

cancerCard :: MonadWidget t m => m (Event t ())
cancerCard = card "Cancer" [("Metastasis", ()), ("Stay", ())]

lymphocyteCard :: MonadWidget t m => m (Event t ())
lymphocyteCard = card "Lymphocyte" [("Cure", ())]

