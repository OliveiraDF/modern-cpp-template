# Variables
BUILD_DIR        := build
DEBUG_DIR        := $(BUILD_DIR)/debug
RELEASE_DIR 	 := $(BUILD_DIR)/release
INCLUDE_DIR 	 := ./include
SRC_DIR          := ./src
UNCRUSTIFY_CONFIG := .uncrustify

CMAKE_DEBUG_OPTS       := -DCMAKE_BUILD_TYPE=Debug \
                    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
                    -DCMAKE_CXX_COMPILER=g++
CMAKE_RELEASE_OPTS       := -DCMAKE_BUILD_TYPE=Release \
                    -DCMAKE_CXX_COMPILER=g++				

# Détection du nombre de coeurs pour la compilation parallélisée
JOBS             := $(shell nproc 2>/dev/null || echo 4)

# ... (variables identiques) ...

.PHONY: all format configure build analyse analyse-headers clean release-all release-configure release-build release-pack test release-test

all: clean format configure build analyse test

# --- DEBUG / DEV ---

format:
	@echo "--- Formatage avec Uncrustify ---"
	find $(SRC_DIR) -type f \( -name "*.cpp" -o -name "*.h" \) -exec uncrustify -c $(UNCRUSTIFY_CONFIG) --no-backup --replace {} +
	find $(INCLUDE_DIR) -type f -name "*.h" -exec uncrustify -c $(UNCRUSTIFY_CONFIG) --no-backup --replace {} +
	find $(INCLUDE_DIR) -type f -name "*.inl" -exec uncrustify -c $(UNCRUSTIFY_CONFIG) --no-backup --replace {} +

configure:
	@echo "--- Configuration CMake Debug ---"
	mkdir -p $(DEBUG_DIR)
	cd $(DEBUG_DIR) && cmake $(CMAKE_DEBUG_OPTS) ../..

build:
	@echo "--- Compilation Debug (Jobs: $(JOBS)) ---"
	@if [ ! -d "$(DEBUG_DIR)" ]; then $(MAKE) configure; fi
	cmake --build $(DEBUG_DIR) --config Debug -j $(JOBS)

analyse:
	@echo "--- Analyse statique (Jobs: $(JOBS)) ---"
	mkdir -p $(BUILD_DIR)/cppcheck
	cppcheck \
		--cppcheck-build-dir=$(BUILD_DIR)/cppcheck \
		--platform=unix64 \
		--language=c++ \
		--std=c++20 \
		--enable=warning,style,performance,portability \
		--inconclusive \
		--suppress=missingIncludeSystem \
		--suppress=unmatchedSuppression \
		--suppress=unusedFunction \
		--error-exitcode=1 \
		-j $(JOBS) \
		-I./include \
		$(SRC_DIR)

test:
	@echo "--- Exécution des Tests (Debug) ---"
	@if [ ! -d "$(DEBUG_DIR)" ]; then $(MAKE) configure; fi
	@$(MAKE) build
	ctest --test-dir $(DEBUG_DIR) --output-on-failure

#metric:
#	@echo "--- Analyse des métriques de code ---"
#	cccc \
#		--outdir=$(BUILD_DIR)/cccc \
#		--lang=c++ \
#		$(INCLUDE_DIR)/doodle/math/*

# --- RELEASE / PROD CI ---

release-configure:
	@echo "--- Configuration CMake Release ---"
	mkdir -p $(RELEASE_DIR)
	cd $(RELEASE_DIR) && cmake $(CMAKE_RELEASE_OPTS) ../..

release-build:
	@echo "--- Compilation Release (Jobs: $(JOBS)) ---"
	@if [ ! -d "$(RELEASE_DIR)" ]; then $(MAKE) release-configure; fi
	cmake --build $(RELEASE_DIR) --config Release -j $(JOBS)

release-test:
	@echo "--- Exécution des Tests (Release) ---"
	@if [ ! -d "$(RELEASE_DIR)" ]; then $(MAKE) release-configure; fi
	@$(MAKE) release-build
	ctest --test-dir $(RELEASE_DIR) --output-on-failure

release-pack:
	@echo "--- Génération du paquet DEB ---"
	@if [ ! -d "$(RELEASE_DIR)" ]; then $(MAKE) release-configure; fi
	cd $(RELEASE_DIR) && cpack -G DEB
	@echo "Paquet généré dans $(RELEASE_DIR)"

# --- CLEANUP ---

clean:
	@echo "--- Nettoyage ---"
	rm -rf $(BUILD_DIR)