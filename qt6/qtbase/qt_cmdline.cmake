# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

qt_commandline_subconfig(src/corelib)
qt_commandline_subconfig(src/network)
qt_commandline_subconfig(src/gui)
qt_commandline_subconfig(src/sql)
qt_commandline_subconfig(src/xml)
qt_commandline_subconfig(src/widgets)
qt_commandline_subconfig(src/printsupport)
qt_commandline_subconfig(src/plugins/sqldrivers)
qt_commandline_subconfig(src/testlib)
qt_commandline_subconfig(src/tools)
# no-prefix needs to be placed before prefix
qt_commandline_option(no-prefix TYPE void)
qt_commandline_option(prefix TYPE string)
qt_commandline_option(extprefix TYPE string)
qt_commandline_option(archdatadir TYPE string)
qt_commandline_option(bindir TYPE string)
qt_commandline_option(datadir TYPE string)
qt_commandline_option(docdir TYPE string)
qt_commandline_option(examplesdir TYPE string)
qt_commandline_option(headerdir TYPE string)
qt_commandline_option(hostdatadir TYPE string)
qt_commandline_option(libdir TYPE string)
qt_commandline_option(libexecdir TYPE string)
qt_commandline_option(plugindir TYPE string)
qt_commandline_option(qmldir TYPE string)
qt_commandline_option(settingsdir TYPE string NAME sysconfdir)
qt_commandline_option(sysconfdir TYPE string)
qt_commandline_option(testsdir TYPE string)
qt_commandline_option(translationdir TYPE string)
qt_commandline_option(android-arch TYPE string)
qt_commandline_option(android-abis TYPE string)
qt_commandline_option(android-ndk TYPE string)
qt_commandline_option(android-ndk-platform TYPE string)
qt_commandline_option(android-sdk TYPE string)
qt_commandline_option(android-javac-target TYPE string)
qt_commandline_option(android-javac-source TYPE string)
qt_commandline_option(android-style-assets TYPE boolean)
qt_commandline_option(appstore-compliant TYPE boolean)
qt_commandline_option(avx TYPE boolean)
qt_commandline_option(avx2 TYPE boolean)
qt_commandline_option(avx512 TYPE boolean NAME avx512f)
qt_commandline_option(c++std TYPE cxxstd)
qt_commandline_option(ccache TYPE boolean NAME ccache)
qt_commandline_option(commercial TYPE void)
qt_commandline_option(confirm-license TYPE void)
qt_commandline_option(dbus TYPE optionalString VALUES no yes linked runtime)
qt_commandline_option(dbus-linked TYPE void NAME dbus VALUE linked)
qt_commandline_option(dbus-runtime TYPE void NAME dbus VALUE runtime)
qt_commandline_option(debug TYPE void)
qt_commandline_option(debug-and-release TYPE boolean NAME debug_and_release)
qt_commandline_option(developer-build TYPE void)
qt_commandline_option(device TYPE string)
qt_commandline_option(device-option TYPE addString)
qt_commandline_option(f16c TYPE boolean)
qt_commandline_option(force-asserts TYPE boolean NAME force_asserts)
qt_commandline_option(force-debug-info TYPE boolean NAME force_debug_info)
qt_commandline_option(force-pkg-config TYPE void NAME pkg-config)
qt_commandline_option(framework TYPE boolean)
qt_commandline_option(gc-binaries TYPE boolean NAME gc_binaries)
qt_commandline_option(gdb-index TYPE boolean NAME enable_gdb_index)
qt_commandline_option(gcc-sysroot TYPE boolean)
qt_commandline_option(gcov TYPE boolean)
qt_commandline_option(gnumake TYPE boolean NAME GNUmake)
qt_commandline_option(gui TYPE boolean)
qt_commandline_option(headersclean TYPE boolean)
qt_commandline_option(incredibuild-xge TYPE boolean NAME incredibuild_xge)
qt_commandline_option(libudev TYPE boolean)
qt_commandline_option(openssl TYPE optionalString VALUES no yes linked runtime)
qt_commandline_option(openssl-linked TYPE void NAME openssl VALUE linked)
qt_commandline_option(openssl-runtime TYPE void NAME openssl VALUE runtime)
qt_commandline_option(linker TYPE optionalString VALUES bfd gold lld mold)
qt_commandline_option(ltcg TYPE boolean)
qt_commandline_option(intelcet TYPE boolean)
# special case begin
qt_commandline_option(make TYPE addString VALUES examples libs tests tools
                      benchmarks manual-tests minimal-static-tests)
# special case end
qt_commandline_option(make-tool TYPE string)
qt_commandline_option(mips_dsp TYPE boolean)
qt_commandline_option(mips_dspr2 TYPE boolean)
qt_commandline_option(mp TYPE boolean NAME msvc_mp)
qt_commandline_option(nomake TYPE addString VALUES examples tests tools benchmarks
                      manual-tests minimal-static-tests) # special case
qt_commandline_option(opensource TYPE void NAME commercial VALUE no)
qt_commandline_option(optimize-debug TYPE boolean NAME optimize_debug)
qt_commandline_option(optimize-size TYPE boolean NAME optimize_size)
qt_commandline_option(optimized-qmake TYPE boolean NAME release_tools)
qt_commandline_option(optimized-tools TYPE boolean NAME release_tools)
qt_commandline_option(pch TYPE boolean NAME precompile_header)
qt_commandline_option(pkg-config TYPE boolean)
qt_commandline_option(platform TYPE string)
qt_commandline_option(plugin-manifests TYPE boolean)
qt_commandline_option(profile TYPE boolean)
qt_commandline_option(qreal TYPE string)
qt_commandline_option(qtlibinfix TYPE string NAME qt_libinfix)
qt_commandline_option(qtnamespace TYPE string NAME qt_namespace)
qt_commandline_option(reduce-exports TYPE boolean NAME reduce_exports)
qt_commandline_option(reduce-relocations TYPE boolean NAME reduce_relocations)
qt_commandline_option(release TYPE enum NAME debug MAPPING yes no no yes)
qt_commandline_option(rpath TYPE boolean)
qt_commandline_option(sanitize TYPE sanitize)
qt_commandline_option(sdk TYPE string)
qt_commandline_option(separate-debug-info TYPE boolean NAME separate_debug_info)
qt_commandline_option(shared TYPE boolean)
qt_commandline_option(silent TYPE void)
qt_commandline_option(qdbus TYPE boolean NAME dbus)
qt_commandline_option(sse2 TYPE boolean)
qt_commandline_option(sse3 TYPE boolean)
qt_commandline_option(sse4.1 TYPE boolean NAME sse4_1)
qt_commandline_option(sse4.2 TYPE boolean NAME sse4_2)
qt_commandline_option(ssse3 TYPE boolean)
qt_commandline_option(static TYPE enum NAME shared MAPPING yes no no yes)
qt_commandline_option(static-runtime TYPE boolean NAME static_runtime)
qt_commandline_option(strip TYPE boolean)
qt_commandline_option(syncqt TYPE boolean)
qt_commandline_option(sysroot TYPE string)
qt_commandline_option(testcocoon TYPE boolean)
qt_commandline_option(use-gold-linker TYPE boolean NAME use_gold_linker_alias)
qt_commandline_option(warnings-are-errors TYPE boolean NAME warnings_are_errors)
qt_commandline_option(Werror TYPE boolean NAME warnings_are_errors)
qt_commandline_option(widgets TYPE boolean)
qt_commandline_option(xplatform TYPE string)
qt_commandline_option(zlib TYPE enum NAME system-zlib MAPPING system yes qt no)
qt_commandline_option(zstd TYPE boolean)
qt_commandline_prefix(D defines)
qt_commandline_prefix(F fpaths)
qt_commandline_prefix(I includes)
qt_commandline_prefix(L lpaths)
qt_commandline_prefix(R rpaths)
qt_commandline_prefix(W wflags)

function(qt_commandline_cxxstd arg val nextok)
    if("${val}" STREQUAL "")
        qtConfGetNextCommandlineArg(val)
    endif()
    if("${val}" STREQUAL "" OR val MATCHES "^-.*")
        qtConfAddError("Missing argument to command line parameter '${arg}'.")
        return()
    endif()
    if(val MATCHES "(c\\+\\+)?11")
        qtConfCommandlineSetInput(c++14 no)
        qtConfCommandlineSetInput(c++17 no)
        qtConfCommandlineSetInput(c++20 no)
        qtConfCommandlineSetInput(c++2b no)
    elseif(val MATCHES "(c\\+\\+)?(14|1y)")
        qtConfCommandlineSetInput(c++14 yes)
        qtConfCommandlineSetInput(c++17 no)
        qtConfCommandlineSetInput(c++20 no)
        qtConfCommandlineSetInput(c++2b no)
    elseif(val MATCHES "(c\\+\\+)?(17|1z)")
        qtConfCommandlineSetInput(c++14 yes)
        qtConfCommandlineSetInput(c++17 yes)
        qtConfCommandlineSetInput(c++20 no)
        qtConfCommandlineSetInput(c++2b no)
    elseif(val MATCHES "(c\\+\\+)?(20|2a)")
        qtConfCommandlineSetInput(c++14 yes)
        qtConfCommandlineSetInput(c++17 yes)
        qtConfCommandlineSetInput(c++20 yes)
        qtConfCommandlineSetInput(c++2b no)
    elseif(val MATCHES "(c\\+\\+)?(2b)")
        qtConfCommandlineSetInput(c++14 yes)
        qtConfCommandlineSetInput(c++17 yes)
        qtConfCommandlineSetInput(c++20 yes)
        qtConfCommandlineSetInput(c++2b yes)
    else()
        qtConfAddError("Invalid argument '${val}' to command line parameter '${arg}'")
    endif()
endfunction()

function(qt_commandline_sanitize arg val nextok)
    if("${val}" STREQUAL "")
        qtConfGetNextCommandlineArg(val)
    endif()
    if("${val}" STREQUAL "" OR val MATCHES "^-.*")
        qtConfAddError("Missing argument to command line parameter '${arg}'.")
        return()
    endif()
    if(val STREQUAL "address")
        qtConfCommandlineSetInput(sanitize_address yes)
    elseif(val STREQUAL "thread")
        qtConfCommandlineSetInput(sanitize_thread yes)
    elseif(val STREQUAL "memory")
        qtConfCommandlineSetInput(sanitize_memory yes)
    elseif(val STREQUAL "fuzzer-no-link")
        qtConfCommandlineSetInput(sanitize_fuzzer_no_link yes)
    elseif(val STREQUAL "undefined")
        qtConfCommandlineSetInput(sanitize_undefined yes)
    else()
        qtConfAddError("Invalid argument '${val}' to command line parameter '${arg}'")
    endif()
endfunction()
