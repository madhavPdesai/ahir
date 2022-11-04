#define SCL180 0
#define UMC65  1
#define SAC    2

typedef struct __IntPairList IntPairList;

struct __IntPairList {
	int a;
	int d;
	IntPairList* next;
};

void appendToList(int a, int d, IntPairList** ip_list);

void generate_scl180_port_string (const char* mem_type, int addr_width, int data_width, char* result_string);
void generate_scl180_port_map_string (char* mem_type, char* result_string);
void generate_scl180_reverse_port_map_string (char* mem_type, char* result_string);

void generate_umc65_port_string (const char* mem_type,  int addr_width, int data_width, char* result_string);
void generate_umc65_port_map_string (const char* mem_type,char* result_string);
void generate_umc65_reverse_port_map_string (const char* mem_type,char* result_string);

void generate_sac_port_string (const char* mem_type,  int addr_width, int data_width, char* result_string);
void generate_sac_port_map_string (const char* mem_type,char* result_string);
void generate_sac_reverse_port_map_string (const char* mem_type,char* result_string);

int getWordSpec(int tech_flag, int addr_width);
void printCutConstants(FILE* f, const char* prefix, IntPairList* lst);
void printDummyCutConstants(FILE* f, const char* prefix);
void printInstanceAndComponents(int tech_flag,
					char* mem_type,
					FILE* arch_file, 
					FILE* comp_decls_file, 
					char* entity_prefix,
					int addr_width, int data_width,
					char* entity_postfix);
void printWrapperEntity(int tech, char* mem_type,
				FILE* f,
				char* entity_prefix,
				int addr_width, int data_width,
				char* entity_postfix);
