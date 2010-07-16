class AhirRoot;  // root class: all ahir classes generated from here.
class AhirProgram; 
class AhirModule;
class AhirTransition;
class AhirPlace;
class AhirObject;
class AhirOperator;
class AhirWire;
class AhirType;
class AhirTransitionType;
class AhirOperatorType;
class AhirMemorySpace;


// true if new attribute, false if overwrite of existing attr_value
bool AhirRoot::addAttribute(string& attr_name, string& attr_value); // virtual, all have it

// program is a set of modules
AhirProgram::AhirProgram(string prog_name);
AhirModule* AhirProgram::addModule(string& module_name);
AhirObject* AhirProgram::addStorageVariable(string& name, AhirType& t, AhirValue& v);
AhirObject* AhirProgram::addConstant(string& name, AhirType& t, AhirValue& v);
AhirObject* AhirProgram::addPipe(string& name, AhirType& t);

AhirMemorySpace* AhirProgram::addMemorySpace(string& space_id,
					     unsigned int word_size;
					     unsigned int bytes_requested);

// operations
void AhirProgram::writeRawXML(string& filename);
void AhirProgram::writeLinkedXML(string& filename);
void AhirProgram::linkProgram(string& top_module_name);
void AhirProgram::writeVHDL(string top_module_name);


// module declarations
AhirObject* AhirModule::addInputArgument(string& name, AhirType& t);
AhirObject* AhirModule::addOutputArgument(string& name, AhirType& t);
AhirObject* AhirModule::addStorageVariable(string& name, AhirType& t, AhirValue* v);
AhirObject* AhirModule::addConstant(string& name, AhirType& t, AhirValue& v);
AhirObject* AhirModule::addPipe(string& name, AhirType& t);

AhirPlace* AhirModule::addPlace(string& place_name);
AhirTransition* AhirModule::addTransition(string& transition_name, AhirTransitionType& t);

void AhirModule::setDependency(AhirPlace& p, AhirTransition& t);
void AhirModule::setDependency(AhirTransition& t, AhirPlace& v);
void AhirModule::setDependency(AhirTransition& u, AhirTransition& v);


void AhirModule::addLink(AhirTransition& r, 
			 AhirTransition& ra,
			 AhirTransition& c, 
			 AhirTransition& ca,
			 AhirOperator& op);
void AhirModule::addLink(AhirTransition& r, 
			 AhirTransition& a, 
			 AhirOperator& op);


AhirWire* AhirModule::addWire(string wire_name, AhirType t);
AhirOperator* AhirModule::addOperator(string operator_name, 
				  AhirOperatorType& op);
// ordered association.
void AhirModule::connectWire(AhirWire& w, 
			     unsigned int& position,
			     AhirOperator& op,
			     AhirMode& in_or_out);

// memory space associated with modules
AhirMemorySpace* AhirModule::addMemorySpace(string& space_id,
					    unsigned int word_size;
					    unsigned int bytes_requested);
void AhirModule::associateLoadStoreOperatorWithMemorySpace(AhirOperator& ls,
							   AhirMemorySpace& mem_space);

// some observation functions
void AhirProgram::getModuleList(vector<AhirModule& >& mod_vector);
AhirModule* AhirProgram::getModule(string& mod_name);

void AhirProgram::getTransitionList(vector<AhirTransition& >& trans_vector);
AhirTransition* AhirProgram::getTransition(string& trans_name);

void AhirProgram::getPlaceList(vector<AhirPlace& >& place_vector);
AhirTransition* AhirProgram::getPlace(string& place_name);

void AhirTransition::getPredecessors(vector<AhirTransition&> pred_transitions,
				     vector<AhirPlaces&> pred_places);
void AhirTransition::getSuccessors(vector<AhirTransition&> succ_transitions,
				     vector<AhirPlaces&> succ_places);

void AhirPlace::getPredecessors(vector<AhirTransition&> pred_transitions,
				     vector<AhirPlaces&> pred_places);
void AhirPlace::getSuccessors(vector<AhirTransition&> succ_transitions,
				     vector<AhirPlaces&> succ_places);

AhirTransitionType* AhirTransition::getTransitionType();


void AhirModule::getOperatorList(vector<AhirOperator&>& op_vector);
AhirOperator* AhirModule::getOperator(string op_name);

void AhirOperator::getInputs(vector<AhirWire&>& wire_vector);
void AhirOperator::getOutputs(vector<AhirWire&>& wire_vector);
AhirOperatorType AhirOperator::getOperatorType();


void AhirModule::getMemorySpaceList(vector<AhirMemorySpace&>& op_vector);
AhirMemorySpace* AhirModule::getMemorySpace(string op_name);








					    



