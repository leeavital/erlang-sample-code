-module( merge_sort ).

-export( [merge_sort/1] ).


merge_sort( []) -> [];
merge_sort( [L] ) -> [L];
merge_sort( L ) ->
  Len = length( L ),
  {Left, Right} = lists:split( Len div 2, L ),
  LeftSorted = merge_sort( Left ),
  RightSorted = merge_sort( Right ),
  lists:merge( LeftSorted, RightSorted ).
