open Riot
open Dream

type Message.t += Hello_world



let () =
  Riot.run @@ fun () ->
    Dream.run (fun _ ->
      Dream.run
      @@ Dream.logger
      @@ Dream.router [
        Dream.get "/" (fun _ ->
        let pid =
          spawn (fun () ->
            match receive () with
            | Hello_world ->
                let msg = Printf.sprintf "hello world from %s!" "Emil"  in 
                print_endline msg
            | _ -> print_endline "failed matching"
          )
        in
        send pid Hello_world;
        Dream.html "Hello World");
      ]
    )
