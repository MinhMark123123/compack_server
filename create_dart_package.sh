# shellcheck disable=SC2162
printf "%s" "Enter package name: "
read APP_PACKAGE_NAME
printf "%s" "Enter package description: "
read APP_DESCRIPTION
mason make very_good_dart_package --project_name "$APP_PACKAGE_NAME" --description "$APP_DESCRIPTION" -o packages


