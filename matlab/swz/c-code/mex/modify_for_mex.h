#ifndef _MEXMOD
#define _MEXMOD
void swz_exit(int status);
void swz_fprintf_err(const char * str, ...);
int swz_fprintf_stdout(char *msg, ...);
#endif


#if defined(MATLAB_MEX_FILE) || defined(OCTAVE_MEX_FILE)
#include "matrix.h"
#include <dynmex.h>

/*  //#undef printf   ansi-c*/
/*  //#define printf swz_printf   ansi-c*/
/*#define fflush(stdout) mexEvalString("drawnow;");*/

#undef printf
#undef exit

#define printf mexPrintf
#define exit swz_exit

#undef malloc
#undef calloc
#undef realloc
#undef free

#define malloc mxMalloc
#define calloc mxCalloc
#define realloc mxRealloc
#define free mxFree
#endif
