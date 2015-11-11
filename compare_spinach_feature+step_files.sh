#!/bin/bash
# Pull all the step names out of the feature file.

tmp_features=/tmp/$$_a
tmp_steps=/tmp/$$_b
tmp_unique_steps=/tmp/$$_c
feature_dir="./features"
step_dir="./features/steps"

case $1 in
  "" ) file_base="gig_management" ;;
  "*") file_base="$1" ;;
esac

# ensure cleanup
trap 'rm -f $_tmp_features $tmp_steps $tmp_unique_steps' 0

# Sort and keep only unique feature step names
egrep "^ *Given|^ *When|^ *And|^ But|^ *Then" "$feature_dir/$file_base.feature"  |
  sed "s/^ *//" |
  cut -f 2- -d " " |
  sort -u > $tmp_features

# Pull all the step names out of the step file.  Sort the step names,
# but keep duplicates (we want to flag those)
grep " *step" "$step_dir/$file_base.rb" |
  sed "s/ *step '//" |
  sed "s/'.*//g" |
  sort > $tmp_steps

 sort -u $tmp_steps > $tmp_unique_steps

raw_step_count=$(    wc -l $tmp_steps)
unique_step_count=$( wc -l $tmp_unique_steps)

case $raw_step_count in
  $unique_step_count) ;;
  *) echo "$file_base/steps.rb has duplicate steps:"
     uniq -d $tmp_steps ;;
 esac


 echo "--------------"
 pr -m -t $tmp_features $tmp_steps
