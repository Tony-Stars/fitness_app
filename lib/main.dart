import "package:fitness/utils/app_router.dart";
import "package:fitness/utils/service_locator.dart";
import "package:flutter/material.dart";

void main() {
  ServiceLocator.register();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.initialRoute,
    ),
  );
}
