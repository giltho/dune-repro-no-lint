(** ADDS THE FOLLOWING COPYRIGHT IF THE FILE DOES NOT ALREADY START WITH IT *)
let copyright = "(* COPYRIGHT: ME *)\n"

let file =
  let filename = Sys.argv.(1) in
  let lines = ref [] in
  let chan = open_in filename in
  try
    while true do
      lines := input_line chan :: !lines
    done;
    ""
  with End_of_file ->
    close_in chan;
    String.concat "\n" (List.rev !lines)

let () =
  let copy_length = String.length copyright in
  let should_add =
       ((String.length file) < copy_length)
    || (not (String.equal (String.sub file 0 copy_length) copyright)) in
  if should_add then (
    let oc = open_out Sys.argv.(2) in
    Printf.fprintf oc "%s%s" copyright file;
    close_out oc )
