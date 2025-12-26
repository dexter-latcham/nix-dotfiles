{ pkgs, config, lib, ... }:
{
  (final: prev: {
    dwm = prev.dwm.overrideAttrs (oldAttrs: let
    in{
      src = prev.fetchFromGitHub {
	owner = "LukeSmithxyz";
	repo = "dwm";
	rev = "f570a251a00b286ac0aa11b8d4a1008edd172bd9";
	sha256 = "I+SPMquQGt5CTpV4hdjwo9hAQSBpH4IDCp0LL9ErEjQ=";
      };
      buildInputs = oldAttrs.buildInputs ++ [ pkgs.libxcb ];
      });
    })
};
