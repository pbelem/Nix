{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{
  inherit lua;

  exec        = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
  close       = ''hl.dsp.window.close()'';
  toggleFloat = ''hl.dsp.window.float({})'';
  fullscreen  = mode: ''hl.dsp.window.fullscreen({ mode = "${mode}" })'';
  focusDir    = dir: ''hl.dsp.focus({ direction = "${dir}" })'';
  focusWs     = ws: ''hl.dsp.focus({ workspace = "${ws}" })'';
  moveToWs    = ws: ''hl.dsp.window.move({ workspace = "${ws}" })'';
  dragWindow  = ''hl.dsp.window.drag()'';
  resizeWindow = ''hl.dsp.window.resize()'';

  hyprctlDispatch = argsStr: ''hl.dsp.exec_cmd("hyprctl dispatch ${argsStr}")'';

  mkBind = { key, action, flags ? { } }:
    {
      _args = [ key (lua action) ] ++ (if flags == { } then [ ] else [ flags ]);
    };

  mkOn = { event, body }:
    {
      _args = [
        event
        (lua ''
          function()
${body}
          end
        '')
      ];
    };
}
