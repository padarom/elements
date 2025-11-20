{
  lib,
  pkgs,
  ...
}:
lib._elements.writeNushellApplication pkgs {
  name = "git-delete-stale";
  runtimeInputs = with pkgs; [git];

  text = ''
    let localBranches = (
      git branch
        | lines
        | str trim
        | where not ($it | str starts-with '* ')
        | where $it != 'master'
    )

    let remoteBranches = (
      git branch -r
        | lines
        | str trim
        | str replace 'origin/' ""
    )

    let staleBranches = ($localBranches | where { |$local| $local not-in $remoteBranches })

    if ($staleBranches | is-empty) {
      print 'No stale branches found.'
      exit 0
    }

    let deleteBranches = (gum choose --header "Stale branches to delete" --no-limit ...($staleBranches) | lines | compact -e)
    if ($deleteBranches | length) > 0 {
      git branch -D ...($deleteBranches)
    } else {
      print 'No branches selected.'
    }
  '';
}
