BIN_LIB=NewRepo
DBGVIEW=*ALL

hdr:
  system -q "CRTSRCPF FILE($(BIN_LIB)/QRPGLESRC3) RCDLEN(112)"
  system "CPYFRMSTMF FROMSTMF('headers/PROGRAM5.rpgle') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGLESRC3.file/PROGRAM5.mbr') MBROPT(*replace)"
  system "CPYFRMSTMF FROMSTMF('headers/PROGRAM8.rpgle') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGLESRC3.file/PROGRAM8.mbr') MBROPT(*replace)"
  @echo Build success!
clean:
  -system -q "DLTOBJ OBJ($(BIN_LIB)/PROGRAM5) OBJTYPE(*PGM)"
  -system -q "DLTOBJ OBJ($(BIN_LIB)/PROGRAM8) OBJTYPE(*PGM)"
release: clean
  @echo " -- Creating DEV.PRJ release. --"
  @echo " -- Creating save file. --"
  system "CRTSAVF FILE($(BIN_LIB)/RELEASE1X)"
  system "SAVLIB LIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE1X) OMITOBJ((RELEASE1X *FILE))"
  -rm -r release1X
  -mkdir release1X
  system "CPYTOSTMF FROMMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE1X.FILE') TOSTMF('./release1X/release1X.savf') STMFOPT(*REPLACE) STMFCCSID(1252) CVTDTA(*NONE)"
	@echo " -- Cleaning up... --"
	system "DLTOBJ OBJ($(BIN_LIB)/RELEASE1X) OBJTYPE(*FILE)"
	@echo " -- Release created! --"
	@echo ""
	@echo "To install the release, run:"
	@echo "  > CRTLIB $(BIN_LIB)"
	@echo "  > CPYFRMSTMF FROMSTMF('./release1X/release1X.savf') TOMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE1X.FILE') MBROPT(*REPLACE) CVTDTA(*NONE)"
	@echo "  > RSTLIB SAVLIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE1X)"
