#ifndef  SDAIHEADER_SECTION_SCHEMA_ALL_CC
#define  SDAIHEADER_SECTION_SCHEMA_ALL_CC
// This file was generated by exp2cxx.  You probably don't want to edit
// it since your modifications will be lost if exp2cxx is used to
// regenerate it.

#include "cleditor/SdaiHeaderSchema.h"

void HeaderInitSchemasAndEnts( Registry & reg ) {
    Uniqueness_rule_ptr ur;
    // Schema:  SdaiHEADER_SECTION_SCHEMA
    s_header_section_schema = new Schema( "Header_Section_Schema" );
    s_header_section_schema->AssignModelContentsCreator(
        ( ModelContentsCreator ) create_SdaiModel_contents_header_section_schema );
    reg.AddSchema( *s_header_section_schema );

    //        *****  Initialize the Types
    header_section_schemat_time_stamp_text = new TypeDescriptor(
        "Time_Stamp_Text",        // Name
        sdaiSTRING,        // FundamentalType
        s_header_section_schema,        // Originating Schema
        "STRING (256)" );       // Description
    s_header_section_schema->AddType( header_section_schemat_time_stamp_text );
    header_section_schemat_section_name = new TypeDescriptor(
        "Section_Name",        // Name
        REFERENCE_TYPE,        // FundamentalType
        s_header_section_schema,        // Originating Schema
        "exchange_structure_identifier" );       // Description
    s_header_section_schema->AddType( header_section_schemat_section_name );
    header_section_schemat_context_name = new TypeDescriptor(
        "Context_Name",        // Name
        sdaiSTRING,        // FundamentalType
        s_header_section_schema,        // Originating Schema
        "STRING" );       // Description
    s_header_section_schema->AddType( header_section_schemat_context_name );
    header_section_schemat_schema_name = new TypeDescriptor(
        "Schema_Name",        // Name
        sdaiSTRING,        // FundamentalType
        s_header_section_schema,        // Originating Schema
        "STRING (1024)" );       // Description
    s_header_section_schema->AddType( header_section_schemat_schema_name );
    header_section_schemat_language_name = new TypeDescriptor(
        "Language_Name",        // Name
        REFERENCE_TYPE,        // FundamentalType
        s_header_section_schema,        // Originating Schema
        "exchange_structure_identifier" );       // Description
    s_header_section_schema->AddType( header_section_schemat_language_name );
    header_section_schemat_exchange_structure_identifier = new TypeDescriptor(
        "Exchange_Structure_Identifier",        // Name
        sdaiSTRING,        // FundamentalType
        s_header_section_schema,        // Originating Schema
        "STRING" );       // Description
    s_header_section_schema->AddType( header_section_schemat_exchange_structure_identifier );

    //        *****  Initialize the Entities
    header_section_schemae_section_language = new EntityDescriptor(
        "Section_Language", s_header_section_schema, LFalse, LFalse,
        ( Creator ) create_SdaiSection_language );
    s_header_section_schema->AddEntity( header_section_schemae_section_language );
    header_section_schemae_section_language->_uniqueness_rules = new Uniqueness_rule__set;
    ur = new Uniqueness_rule( "UR1 : section;\n" );
    header_section_schemae_section_language->_uniqueness_rules->Append( ur );
    header_section_schemae_file_population = new EntityDescriptor(
        "File_Population", s_header_section_schema, LFalse, LFalse,
        ( Creator ) create_SdaiFile_population );
    s_header_section_schema->AddEntity( header_section_schemae_file_population );
    header_section_schemae_file_name = new EntityDescriptor(
        "File_Name", s_header_section_schema, LFalse, LFalse,
        ( Creator ) create_SdaiFile_name );
    s_header_section_schema->AddEntity( header_section_schemae_file_name );
    header_section_schemae_section_context = new EntityDescriptor(
        "Section_Context", s_header_section_schema, LFalse, LFalse,
        ( Creator ) create_SdaiSection_context );
    s_header_section_schema->AddEntity( header_section_schemae_section_context );
    header_section_schemae_section_context->_uniqueness_rules = new Uniqueness_rule__set;
    ur = new Uniqueness_rule( "UR1 : section;\n" );
    header_section_schemae_section_context->_uniqueness_rules->Append( ur );
    header_section_schemae_file_description = new EntityDescriptor(
        "File_Description", s_header_section_schema, LFalse, LFalse,
        ( Creator ) create_SdaiFile_description );
    s_header_section_schema->AddEntity( header_section_schemae_file_description );
    header_section_schemae_file_schema = new EntityDescriptor(
        "File_Schema", s_header_section_schema, LFalse, LFalse,
        ( Creator ) create_SdaiFile_schema );
    s_header_section_schema->AddEntity( header_section_schemae_file_schema );

    //////////////// USE statements
    //////////////// REFERENCE statements
}

#endif
