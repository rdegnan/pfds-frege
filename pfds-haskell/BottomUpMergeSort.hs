-- Source code from
--   Purely Functional Data Structures
--   Chris Okasaki
--   Cambridge University Press, 1998
--
-- Copyright (c) 1998 Cambridge University Press

module BottomUpMergeSort(module Sortable, MergeSort) where
  import Sortable

  data MergeSort a = MS Int [[a]]

  mrg [] ys = ys
  mrg xs [] = xs
  mrg xs@(x:xs') ys@(y:ys') =
    if x <= y then x : mrg xs' ys else y : mrg xs ys'

  instance Sortable MergeSort where
    empty = MS 0 []

    add x (MS size segs) = MS (size+1) (addSeg [x] segs size)
      where addSeg seg segs size =
              if size `mod` 2 == 0 then seg : segs
              else addSeg (mrg seg (head segs)) (tail segs) (size `div` 2)

    sort (MS size segs) = foldl mrg [] segs

      