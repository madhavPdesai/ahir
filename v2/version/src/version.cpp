#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include "ahir_version.h"

#include "commit_strings.h"

void printAhirVersion(char* tool_id)
{
	std::string tool_id_str = tool_id;
	std::string commit_str = commit_version_string;
	std::string commit_date_str = commit_date_string;

	std::cerr << "Info:  " << tool_id_str <<  " built on AHIR " << commit_str << "\n";
	std::cerr << "Info:  " << "   " <<  commit_date_str << "\n";
}

