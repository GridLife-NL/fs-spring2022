; First is default
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Polish.nlf"

; Language selection dialog
LangString InstallerLanguageTitle  ${LANG_POLISH} "Język instalatora"
LangString SelectInstallerLanguage  ${LANG_POLISH} "Proszę wybrać język instalatora"

; subtitle on license text caption
LangString LicenseSubTitleUpdate ${LANG_POLISH} " - Aktualizacja"
LangString LicenseSubTitleSetup ${LANG_POLISH} " - Instalacja"

; installation directory text
LangString DirectoryChooseTitle ${LANG_POLISH} "Katalog instalacji" 
LangString DirectoryChooseUpdate ${LANG_POLISH} "Wybierz katalog Firestorma, aby uaktualnić do wersji ${VERSION_LONG}.(XXX):"
LangString DirectoryChooseSetup ${LANG_POLISH} "Wybierz gdzie zainstalować Firestorma:"

; CheckStartupParams message box
LangString CheckStartupParamsMB ${LANG_POLISH} "Nie można odnaleźć programu '$INSTNAME'. Cicha aktualizacja zakończyła się niepowodzeniem."

; installation success dialog
LangString InstSuccesssQuestion ${LANG_POLISH} "Czy uruchomić teraz Firestorma?"

; remove old NSIS version
LangString RemoveOldNSISVersion ${LANG_POLISH} "Poszukiwanie starszej wersji..."

; check windows version
LangString CheckWindowsVersionDP ${LANG_POLISH} "Sprawdzanie wersji Windows..."
LangString CheckWindowsVersionMB ${LANG_POLISH} "Firestorm obsługuje tylko Windows Vista z Service Pack 2 lub nowszym.$\nInstalacja na obecnym systemie operacyjnym nie jest wspierana."
LangString CheckWindowsServPackMB ${LANG_POLISH} "Zalecane jest uruchamianie Firestorma z najnowszym dostępnym Service Packiem zainstalowanym w systemie.$\nPomaga on w podniesieniu wydajności i stabilności programu."
LangString UseLatestServPackDP ${LANG_POLISH} "Użyj usługi Windows Update, aby zainstalować najnowszy Service Pack."

; checkifadministrator function (install)
LangString CheckAdministratorInstDP ${LANG_POLISH} "Sprawdzanie zezwolenia na instalację..."
LangString CheckAdministratorInstMB ${LANG_POLISH} 'Używasz konta z ograniczeniami.$\nMusisz być zalogowany jako "administrator" aby zainstalować Firestorma.'

; checkifadministrator function (uninstall)
LangString CheckAdministratorUnInstDP ${LANG_POLISH} "Sprawdzanie zezwolenia na odinstalowanie..."
LangString CheckAdministratorUnInstMB ${LANG_POLISH} 'Używasz konta z ograniczeniami.$\nMusisz być być zalogowany jako "administrator" aby odinstalować Firestorma.'

; checkcpuflags
LangString MissingSSE2 ${LANG_POLISH} "Ten komputer może nie mieć procesora z obsługą SSE2, który jest wymagany aby uruchomić Firestorma w wersji ${VERSION_LONG}. Chcesz kontynuować?"

; closesecondlife function (install)
LangString CloseSecondLifeInstDP ${LANG_POLISH} "Oczekiwanie na zamknięcie Firestorma..."
LangString CloseSecondLifeInstMB ${LANG_POLISH} "Firestorm nie może zostać zainstalowany, gdy jest już włączony.$\n$\nZakończ to, co obecnie robisz i wybierz OK aby zamknąć Firestorma i kontynuować.$\nWybierz ANULUJ aby anulować instalację."

; closesecondlife function (uninstall)
LangString CloseSecondLifeUnInstDP ${LANG_POLISH} "Oczekiwanie na zamknięcie Firestorma..."
LangString CloseSecondLifeUnInstMB ${LANG_POLISH} "Firestorm nie może zostać odinstalowany, gdy jest włączony.$\n$\nZakończ to, co obecnie robisz i wybierz OK aby zamknąć Firestorma i kontynuować.$\nWybierz ANULUJ aby anulować."

; CheckNetworkConnection
LangString CheckNetworkConnectionDP ${LANG_POLISH} "Sprawdzanie połączenia sieciowego..."

; ask to remove user's data files
LangString RemoveDataFilesMB ${LANG_POLISH} "Usunąć ustawienia i pliki pamięci podręcznej (cache) z folderu Documents and Settings?"

; delete program files
LangString DeleteProgramFilesMB ${LANG_POLISH} "Nadal istnieją pliki w katalogu instalacyjnym Firestorma.$\n$\nMożliwe, że są to pliki, które stworzyłeś/aś lub przeniosłeś/aś do:$\n$INSTDIR$\n$\nCzy chcesz je usunąć?"

; uninstall text
LangString UninstallTextMsg ${LANG_POLISH} "To spowoduje odinstalowanie Firestorma ${VERSION_LONG} z Twojego systemu."

; ask to remove registry keys that still might be needed by other viewers that are installed
LangString DeleteRegistryKeysMB ${LANG_POLISH} "Czy chcesz usunąć klucze rejestru utworzone przez aplikację?$\n$\nZalecane jest, aby zachować te klucze, jeśli wciąż są zainstalowane inne wersje Firestorma."

; <FS:Ansariel> Optional start menu entry
LangString CreateStartMenuEntry ${LANG_POLISH} "Utworzyć skrót w Menu Start?"

LangString DeleteDocumentAndSettingsDP ${LANG_POLISH} "Usuwanie plików z katalogu Documents and Settings."
LangString UnChatlogsNoticeMB ${LANG_POLISH} "Ta deinstalacja NIE usunie logów czatów Firestorma ani innych prywatnych plików. Jeśli chcesz zrobić to samodzielnie, to usuń katalog Firestorm wewnątrz folderu Dane Aplikacji użytkownika."
LangString UnRemovePasswordsDP ${LANG_POLISH} "Usuwanie zapisanych przez Firestorma haseł."
