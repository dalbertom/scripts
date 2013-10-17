function mvn-online {
  sed -i~ "s:<offline>.*</offline>:<offline>false</offline>:" ~/.m2/settings.xml
}

function mvn-offline {
  sed -i~ "s:<offline>.*</offline>:<offline>true</offline>:" ~/.m2/settings.xml
}