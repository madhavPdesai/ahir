/*!
  \mainpage AHIR Programmers' Reference Manual

\section core-libraries Core Libraries in AHIR

The AHIR framework consists of a number of libraries and a set of
utilities that call them. Some libraries may depend on other basic
libraries through linkage. Any application that uses one library must
take care to link to the dependencies as well.
    
-# AHIR Structures: The data-structures used to represent entities in
   the AHIR-XML definition. When an input AHIR-XML document is parsed,
   these structures are instantiated by the %parser. The program that
   invoked the %parser is responsible for managing the structures once
   created.
	
-# AHIR-XML Parser: An XML %parser based on the libxml++ library. The
   xmlParser is responsible for creating the data-structures that
   correspond to the document being parsed.

-# AHIR Linker: The primary job of the AHIR %linker is to assign memory
   locations to postboxes, and statically allocated variables. It then
   generates a an XML memory-map file that describes these locations.

-# Control-Path Labels: The labels library provides data-structures
   for labeling. The primary structures include a representation for
   the LabelDAG, and a wrapper class that provides functions for
   constructhing the DAG.

-# Compatibility Library: This library provides data-structures that
   represent compatibility of labels in two ways, along with related
   naive/greedy algorithms

   -# a compatibility matrix
   -# a compatibility CliqueCover

 */
