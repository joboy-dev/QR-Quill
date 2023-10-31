// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/models/scan_code.dart';
import 'package:qr_quill/services/provider/create_code_provider.dart';
import 'package:qr_quill/services/provider/scan_code_provider.dart';

class IsarDB {
  late Future<Isar> db;

  IsarDB() {
    db = openDB();
  }

  // -------------------GENERIC FUNCTIONS----------------------

  /// Set up DB at app start
  Future<Isar> openDB() async {
    // Check if there is an active DB instance
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      // open isar db
      await Isar.open(
        [CreateCodeSchema, ScanCodeSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  /// Function to clear all data from thisar db and provider
  Future clearDB(BuildContext context) async {
    final isar = await db;

    // clear isar db
    isar.writeTxn(() => isar.clear());

    // clear all data in provider
    context.read<CreateCodeProvider>().clearCreatedCodes();
    context.read<ScanCodeProvider>().clearScannedCodes();
  }


  // ------------------------- CREATE CODE ------------------------------

  /// Function to add a created code to isar
  Future addCreatedCode(BuildContext context, CreateCode code) async {
    final isar = await db;

    // save created code to isar
    isar.writeTxnSync<int>(() => isar.createCodes.putSync(code));
    // update provider
    context.read<CreateCodeProvider>().setCreatedCode(code);
  }

  /// Function to get all created codes from isar db
  Future getCreatedCodes(BuildContext context) async {
    final isar = await db;

    // get created codes from isar by creating a read transaction
    final createdCodeDoc = await isar.txn(() => isar.createCodes.where().findAll());
    // save in provider
    context.read<CreateCodeProvider>().setCreatedCodes(createdCodeDoc);

    return createdCodeDoc;
  }

  /// Function to get a single created code from isar db
  Future<CreateCode?> getSingleCreatedCode(int id) async {
    final isar = await db;

    // get created codes from isar by creating a read transaction
    final codeDoc = await isar.txn(() => isar.createCodes.where().idEqualTo(id).findFirst());

    return codeDoc;
  }

  /// Function to delete a created code from isar
  Future deleteCreatedCode(BuildContext context, int id) async {
    final isar = await db;

    // delete code from isar
    await isar.writeTxn(() => isar.createCodes.where().filter().idEqualTo(id).deleteAll());
    // get created codes so that data will be updated in provider as well
    await getCreatedCodes(context);
  }

  /// Function to filter all created codes by QR code
  Future getCreatedQRCodes(BuildContext context) async {
    final isar = await db;

    // get all created qr codes
    final qrCodesDoc = await isar.txn(() => isar.createCodes.where().filter().typeEqualTo('QR Code').findAll());
    context.read<CreateCodeProvider>().setCreatedCodes(qrCodesDoc);

    return qrCodesDoc;
  }

  /// Function to filter all created codes by QR code
  Future getCreatedBarcodes(BuildContext context) async {
    final isar = await db;

    // get all created barcodes
    final barcodeDoc = await isar.txn(() => isar.createCodes.where().filter().typeEndsWith('Barcode').findAll());
    context.read<CreateCodeProvider>().setCreatedCodes(barcodeDoc);

    return barcodeDoc;
  }

  // ------------------------ SCAN CODE --------------------------

  /// Function to add a scanned code to isar
  Future addScannedCode(BuildContext context, ScanCode code) async {
    final isar = await db;

    // save created code to isar
    isar.writeTxnSync<int>(() => isar.scanCodes.putSync(code));
    // update provider
    context.read<ScanCodeProvider>().setScannedCode(code);
  }

  /// Function to get all scanned codes from isar db
  Future getScannedCodes(BuildContext context) async {
    final isar = await db;

    // get created codes from isar by creating a read transaction
    final scannedCodeDoc = await isar.txn(() => isar.scanCodes.where().findAll());
    // save in provider
    context.read<ScanCodeProvider>().setScannedCodes(scannedCodeDoc);

    return scannedCodeDoc;
  }

  /// Function to get a single created code from isar db
  Future<ScanCode?> getSingleScannedCode(int id) async {
    final isar = await db;

    // get created codes from isar by creating a read transaction
    final codeDoc = await isar.txn(() => isar.scanCodes.where().idEqualTo(id).findFirst());

    return codeDoc;
  }

  /// Function to delete a scanned code from isar
  Future deleteScannedCode(BuildContext context, int id) async {
    final isar = await db;

    // delete code from isar
    await isar.writeTxn(() => isar.scanCodes.where().filter().idEqualTo(id).deleteAll());
    // get created codes so that data will be updated in provider as well
    await getScannedCodes(context);
  }

}