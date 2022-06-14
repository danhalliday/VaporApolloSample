# Download the GraphQL schema and generate a Swift interface.

.build/checkouts/apollo-ios/scripts/run-bundled-codegen.sh schema:download \
  "Sources/App/SpaceX/SpaceXSchema.json" \
  --endpoint="https://api.spacex.land/graphql/"

.build/checkouts/apollo-ios/scripts/run-bundled-codegen.sh codegen:generate \
  --target=swift \
  --includes=./**/*.graphql \
  --localSchemaFile="Sources/App/SpaceX/SpaceXSchema.json" "Sources/App/SpaceX/SpaceXQueries.swift"
