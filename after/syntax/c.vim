" Vim syntax file
" Language: C Additions
" Maintainer: Jon Haggblad <jon@haeggblad.com>
" Contributor: Mikhail Wolfson <mywolfson@gmail.com>
" URL: http://www.haeggblad.com
" Last Change: 6 Sep 2014
" Version: 0.3
" Changelog:
"   0.3 - integration of aftersyntaxc.vim
"   0.2 - Cleanup
"   0.1 - initial version.
"
" Syntax highlighting for functions in C.
"
" Based on:
"   http://stackoverflow.com/questions/736701/class-function-names-highlighting-in-vim

" -----------------------------------------------------------------------------
"  Highlight function names.
" -----------------------------------------------------------------------------
if !exists('g:cpp_no_function_highlight')
    syn match cUserFunction "\<\h\w*\ze\_s\{-}(\%(\*\h\w*)\_s\{-}(\)\@!"
    syn match cUserFunctionPointer "\%((\s*\*\s*\)\@6<=\h\w*\ze\s*)\_s\{-}(.*)"
    hi def link cUserFunction Function
    hi def link cUserFunctionPointer Function
endif

" -----------------------------------------------------------------------------
"  Highlight member variable names.
" -----------------------------------------------------------------------------
if exists('g:cpp_member_variable_highlight') && g:cpp_member_variable_highlight
    syn match cMemberAccess "\.\|->" nextgroup=cStructMember,cppTemplateKeyword
    syn match cStructMember "\<\h\w*\>\%((\|<\)\@!" contained
    syn cluster cParenGroup add=cStructMember
    syn cluster cPreProcGroup add=cStructMember
    syn cluster cMultiGroup add=cStructMember
    hi def link cStructMember Identifier

    if &filetype ==# 'cpp'
        syn keyword cppTemplateKeyword template
        hi def link cppTemplateKeyword cppStructure
    endif
endif

" Highlight names in struct, union and enum declarations
if get(g:, 'cpp_type_name_highlight', 1)
    syn match cTypeName "\%(\%(\<struct\|union\|enum\)\s\+\)\@8<=\h\w*"
    hi def link cTypeName Type

    if &filetype ==# 'cpp'
        syn match cTypeName "\%(\%(\<class\|using\|concept\|requires\)\s\+\)\@10<=\h\w*"
    endif
endif

" Highlight operators
if get(g:, 'cpp_operator_highlight', 0)
    syn match cOperator "[?!~*&%<>^|=,+]"
    syn match cOperator "[][]"
    syn match cOperator "[^:]\@1<=:[^:]\@="
    syn match cOperator "-[^>]"me=e-1
    syn match cOperator "/[^/*]"me=e-1
endif

" -----------------------------------------------------------------------------
"  Highlight POSIX functions.
" -----------------------------------------------------------------------------
if exists('g:cpp_posix_standard') && g:cpp_posix_standard
	syn keyword cPOSIXFunction socket accept bind connect getsockname
                \ listen recv recvfrom recvmsg
                \ send sendto sendmsg setsockopt socketpair
	            \ htonl htons ntohl ntohs
	            \ inet_ntop inet_pton getaddrinfo
	            \ poll select pselect
	hi def link cPOSIXFunction Function
endif

" -----------------------------------------------------------------------------
"  Source: aftersyntaxc.vim
" -----------------------------------------------------------------------------

"bsearch system getenv
" Common ANSI-standard functions
syn keyword cAnsiFunction
    \ MULU_ DIVU_ MODU_ MUL_ DIV_ MOD_
    \ main typeof open close read write lseek dup dup2 fcntl ioctl wctrans towctrans towupper towlower wctype iswctype iswxdigit iswupper iswspace iswpunct iswprint iswlower iswgraph iswdigit iswcntrl iswalpha iswalnum wcsrtombs mbsrtowcs wcrtomb mbrtowc mbrlen mbsinit wctob btowc wcsfxtime wcsftime wmemset wmemmove wmemcpy wmemcmp wmemchr wcstok wcsstr wcsspn wcsrchr wcspbrk wcslen wcscspn wcschr wcsxfrm wcsncmp wcscoll wcscmp wcsncat wcscat wcsncpy wcscpy wcstoull wcstoul wcstoll wcstol wcstold wcstof wcstod ungetwc putwchar putwc getwchar getwc fwide fputws fputwc fgetws fgetwc wscanf wprintf vwscanf vwprintf vswscanf vswprintf vfwscanf vfwprintf swscanf swprintf fwscanf fwprintf zonetime strfxtime strftime localtime
    \ gmtime ctime asctime time mkxtime mktime difftime clock strlen strerror memset strtok strstr strspn strrchr strpbrk strcspn strchr memchr strxfrm strncmp strcoll strcmp memcmp strncat strcat strncpy strcpy memmove memcpy wcstombs mbstowcs wctomb mbtowc mblen lldiv ldiv div llabs labs abs qsort bsearch getenv exit atexit abort realloc malloc free calloc srand rand strtoull strtoul strtoll strtol strtold strtof strtod atoll atol atoi atof perror ferror feof clearerr rewind ftell fsetpos fseek fgetpos fwrite fread ungetc puts putchar putc gets getchar getc fputs fputc fgets fgetc vsscanf vsprintf vsnprintf vscanf vprintf vfscanf vfprintf sscanf sprintf snprintf scanf printf fscanf fprintf setvbuf setbuf freopen fopen
    \ fflush fclose tmpnam tmpfile rename remove offsetof va_start va_end va_copy va_arg raise signal longjmp setjmp isunordered islessgreater islessequal isless isgreaterequal isgreater fmal fmaf fma fminl fminf fmin fmaxl fmaxf fmax fdiml fdimf fdim nextafterxl nextafterxf nextafterx nextafterl nextafterf nextafter nanl nanf nan copysignl copysignf copysign remquol remquof remquo remainderl remainderf remainder fmodl fmodf fmod truncl truncf trunc llroundl llroundf llround lroundl lroundf lround roundl roundf round llrintl llrintf llrint lrintl lrintf lrint rintl rintf rint nearbyintl nearbyintf nearbyint floorl floorf floor ceill ceilf ceil tgammal tgammaf tgamma lgammal lgammaf lgamma erfcl erfcf erfc erfl erff erf sqrtl sqrtf sqrt powl powf pow hypotl
    \ hypotf hypot fabsl fabsf fabs cbrtl cbrtf cbrt scalblnl scalblnf scalbln scalbnl scalbnf scalbn modfl modff modf logbl logbf logb log2l log2f log2 log1pl log1pf log1p log10l log10f log10 logl logf log ldexpl ldexpf ldexp ilogbl ilogbf ilogb frexpl frexpf frexp expm1l expm1f expm1 exp2l exp2f exp2 expl expf exp tanhl tanhf tanh sinhl sinhf sinh coshl coshf cosh atanhl atanhf atanh asinhl asinhf asinh acoshl acoshf acosh tanl tanf tan sinl sinf sin cosl cosf cos atan2l atan2f atan2 atanl atanf atan asinl asinf asin acosl acosf acos signbit isnormal isnan isinf isfinite fpclassify localeconv setlocale wcstoumax wcstoimax strtoumax strtoimax feupdateenv fesetenv feholdexcept fegetenv fesetround fegetround fetestexcept fesetexceptflag feraiseexcept fegetexceptflag feclearexcept toupper tolower isxdigit isupper isspace ispunct isprint islower
    \ isgraph isdigit iscntrl isalpha isalnum creall crealf creal cprojl cprojf cproj conjl conjf conj cimagl cimagf cimag cargl cargf carg csqrtl csqrtf csqrt cpowl cpowf cpow cabsl cabsf cabs clogl clogf clog cexpl cexpf cexp ctanhl ctanhf ctanh csinhl csinhf csinh ccoshl ccoshf ccosh catanhl catanhf catanh casinhl casinhf casinh cacoshl cacoshf cacosh ctanl ctanf ctan csinl csinf csin ccosl ccosf ccos catanl catanf catan casinl casinf casin cacosl cacosf cacos assert UINTMAX_C INTMAX_C UINT64_C UINT32_C UINT16_C UINT8_C INT64_C INT32_C INT16_C INT8_C

" Common ANSI-standard Names
syn keyword	cAnsiName
    \ PRId8 PRIi16 PRIo32 PRIu64
    \ PRId16 PRIi32 PRIo64 PRIuLEAST8 PRId32 PRIi64 PRIoLEAST8 PRIuLEAST16 PRId64 PRIiLEAST8 PRIoLEAST16 PRIuLEAST32 PRIdLEAST8 PRIiLEAST16 PRIoLEAST32 PRIuLEAST64 PRIdLEAST16 PRIiLEAST32 PRIoLEAST64 PRIuFAST8 PRIdLEAST32 PRIiLEAST64 PRIoFAST8 PRIuFAST16 PRIdLEAST64 PRIiFAST8 PRIoFAST16 PRIuFAST32 PRIdFAST8 PRIiFAST16 PRIoFAST32 PRIuFAST64 PRIdFAST16 PRIiFAST32 PRIoFAST64 PRIuMAX
    \ PRIdFAST32 PRIiFAST64 PRIoMAX PRIuPTR PRIdFAST64 PRIiMAX PRIoPTR PRIx8 PRIdMAX PRIiPTR PRIu8 PRIx16 PRIdPTR PRIo8 PRIu16 PRIx32 PRIi8 PRIo16 PRIu32 PRIx64

syn keyword	cAnsiName
    \ PRIxLEAST8 SCNd8 SCNiFAST32 SCNuLEAST32 PRIxLEAST16 SCNd16 SCNiFAST64 SCNuLEAST64 PRIxLEAST32 SCNd32 SCNiMAX SCNuFAST8 PRIxLEAST64 SCNd64 SCNiPTR SCNuFAST16 PRIxFAST8 SCNdLEAST8 SCNo8 SCNuFAST32 PRIxFAST16 SCNdLEAST16 SCNo16 SCNuFAST64 PRIxFAST32 SCNdLEAST32 SCNo32 SCNuMAX PRIxFAST64 SCNdLEAST64 SCNo64 SCNuPTR PRIxMAX SCNdFAST8 SCNoLEAST8 SCNx8 PRIxPTR SCNdFAST16 SCNoLEAST16 SCNx16 PRIX8 SCNdFAST32 SCNoLEAST32 SCNx32 PRIX16 SCNdFAST64 SCNoLEAST64 SCNx64 PRIX32 SCNdMAX SCNoFAST8 SCNxLEAST8
    \ PRIX64 SCNdPTR SCNoFAST16 SCNxLEAST16 PRIXLEAST8 SCNi8 SCNoFAST32 SCNxLEAST32 PRIXLEAST16 SCNi16 SCNoFAST64 SCNxLEAST64 PRIXLEAST32 SCNi32 SCNoMAX SCNxFAST8 PRIXLEAST64 SCNi64 SCNoPTR SCNxFAST16 PRIXFAST8 SCNiLEAST8 SCNu8 SCNxFAST32 PRIXFAST16 SCNiLEAST16 SCNu16 SCNxFAST64 PRIXFAST32 SCNiLEAST32 SCNu32 SCNxMAX PRIXFAST64 SCNiLEAST64 SCNu64 SCNxPTR PRIXMAX SCNiFAST8 SCNuLEAST8 PRIXPTR SCNiFAST16 SCNuLEAST16

syn keyword	cAnsiName
    \ errno environ STDC CX_LIMITED_RANGE STDC FENV_ACCESS STDC FP_CONTRACT and bitor not_eq xor and_eq compl or xor_eq bitand not or_eq

hi def link cAnsiFunction cFunction
hi def link cAnsiName cIdentifier
hi def link cFunction Function
hi def link cIdentifier Identifier

" Booleans
syn keyword cBoolean true false TRUE FALSE
hi def link cBoolean Boolean

" -----------------------------------------------------------------------------
"  Additional optional highlighting
" -----------------------------------------------------------------------------

" Operators
"syn match cOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
"syn match cOperator	"<<\|>>\|&&\|||\|++\|--\|->"
"syn match cOperator	"[.!~*&%<>^|=,+-]"
"syn match cOperator	"/[^/*=]"me=e-1
"syn match cOperator	"/$"
"syn match cOperator "&&\|||"
"syn match cOperator	"[][]"
"
"" Preprocs
"syn keyword cDefined defined contained containedin=cDefine
"hi def link cDefined cDefine

"" Functions
"syn match cUserFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
"syn match cUserFunctionPointer "(\s*\*\s*\h\w*\s*)\(\s\|\n\)*(" contains=cDelimiter,cOperator
"
"hi def link cUserFunction cFunction
"hi def link cUserFunctionPointer cFunction
"
"" Delimiters
"syn match cDelimiter    "[();\\]"
"" foldmethod=syntax fix, courtesy of Ivan Freitas
"syn match cBraces display "[{}]"

" Links
"hi def link cDelimiter Delimiter
" foldmethod=syntax fix, courtesy of Ivan Freitas
"hi def link cBraces Delimiter


" Highlight all standard C keywords as Statement
" This is very similar to what other IDEs and editors do
if get(g:, 'cpp_simple_highlight', 0)
    hi! def link cStorageClass Statement
    hi! def link cStructure    Statement
    hi! def link cTypedef      Statement
    hi! def link cLabel        Statement
endif

