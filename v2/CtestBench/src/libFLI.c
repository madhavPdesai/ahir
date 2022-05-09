
#include <mti.h>

int Afunc1( char * str )
{
	mti_PrintFormatted( "Afunc1 was called with parameter \"%s\".\n", str );
	return 17;
}

int Afunc2( char * str )
{
	mti_PrintFormatted( "Afunc2 was called with parameter \"%s\".\n", str );
	return 211;
}

void initForeign(
	mtiRegionIdT region,
	char *param,
	mtiInterfaceListT *generics,
	mtiInterfaceListT *ports
)
{
	mti_PrintFormatted( "+++ Shared lib libFLI initialized.\n" );
}
