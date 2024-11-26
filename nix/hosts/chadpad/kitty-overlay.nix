final: prev: {
  kitty = prev.kitty.overrideAttrs (o: {
    postInstall =
      (o.postInstall or "")
      + ''
        cp -f ${./kitty.png} $out/share/icons/hicolor/256x256/apps/kitty.png
        rm -f $out/share/icons/hicolor/scalable/apps/kitty.svg
      '';
  });
}
