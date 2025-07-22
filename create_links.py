import os

def utworz_linki_symboliczne(katalog_zrodlowy, foldery_docelowe, nadpisz_linki=False):
    katalog_zrodlowy = os.path.abspath(katalog_zrodlowy)
    
    if not os.path.isdir(katalog_zrodlowy):
        print(f"Błąd: katalog źródłowy '{katalog_zrodlowy}' nie istnieje lub nie jest katalogiem.")
        return

    for nazwa_pliku in os.listdir(katalog_zrodlowy):
        pelna_sciezka_pliku = os.path.join(katalog_zrodlowy, nazwa_pliku)

        # Pomijamy podkatalogi, tylko pliki
        if not os.path.isfile(pelna_sciezka_pliku):
            continue

        # Wyciągnięcie rozszerzenia pliku (bez kropki, w małych literach)
        _, rozszerzenie = os.path.splitext(nazwa_pliku)
        if rozszerzenie:
            rozszerzenie = rozszerzenie[1:].lower()  # usuń kropkę i ujednolić na małe litery
        else:
            # Plik bez rozszerzenia, pomijamy go
            print(f"Błąd: Plik '{nazwa_pliku}' bez rozszerzenia - pomijam.")
            continue

        # Sprawdź, czy rozszerzenie jest w słowniku
        if rozszerzenie in foldery_docelowe:
            katalog_docelowy = os.path.abspath(foldery_docelowe[rozszerzenie])
            
            # Sprawdź, czy katalog docelowy istnieje, jeśli nie - utwórz
            if not os.path.exists(katalog_docelowy):
                os.makedirs(katalog_docelowy)
            
            sciezka_linku = os.path.join(katalog_docelowy, nazwa_pliku)

            # Sprawdzenie czy link symboliczny lub plik już istnieje
            if os.path.lexists(sciezka_linku):
                if nadpisz_linki:
                    try:
                        os.remove(sciezka_linku)
                        print(f"Usunięto istniejący link/pliki: {sciezka_linku}")
                    except OSError as e:
                        print(f"Błąd usuwania istniejącego pliku/linku '{sciezka_linku}': {e}")
                        continue
                else:
                    print(f"Link lub plik '{sciezka_linku}' już istnieje. Pomijam.")
                    continue

            # Tworzymy link symboliczny
            try:
                os.symlink(pelna_sciezka_pliku, sciezka_linku)
                print(f"Utworzono link: {sciezka_linku} -> {pelna_sciezka_pliku}")
            except OSError as e:
                print(f"Błąd tworzenia linku do '{pelna_sciezka_pliku}': {e}")
        else:
            # Rozszerzenie nie jest w słowniku - ignoruj plik lub wypisz info
            print(f"Rozszerzenie '{rozszerzenie}' nie jest obsługiwane, plik '{nazwa_pliku}' pomijany.")

if __name__ == "__main__":
    # Przykładowe użycie:
    katalog_zrodlowy = "./AllFiles"
    foldery_docelowe = {
        "jpg": "./Photos",
        "jpeg": "./Photos",
        "png": "./Photos",
        "mp4": "./Videos",
        "mkv": "./Videos",
        "avi": "./Videos",
        "mov": "./Videos"
    }

    # Ustaw `nadpisz_linki` na True, jeśli chcesz nadpisywać istniejące linki/pliki
    utworz_linki_symboliczne(katalog_zrodlowy, foldery_docelowe, nadpisz_linki=False)
