--
-- Copyright (C) 2012-2017 52°North Initiative for Geospatial Open Source
-- Software GmbH
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License version 2 as published
-- by the Free Software Foundation.
--
-- If the program is linked with libraries which are licensed under one of
-- the following licenses, the combination of the program with the linked
-- library is not considered a "derivative work" of the program:
--
--     - Apache License, version 2.0
--     - Apache Software License, version 1.0
--     - GNU Lesser General Public License, version 3
--     - Mozilla Public License, versions 1.0, 1.1 and 2.0
--     - Common Development and Distribution License (CDDL), version 1.0
--
-- Therefore the distribution of the program linked with libraries licensed
-- under the aforementioned licenses, is permitted by the copyright holders
-- if the distribution is compliant with both the GNU General Public
-- License version 2 and the aforementioned licenses.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
-- Public License for more details.
--

--
-- Copyright (C) 2012-2014 52°North Initiative for Geospatial Open Source
-- Software GmbH
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License version 2 as published
-- by the Free Software Foundation.
--
-- If the program is linked with libraries which are licensed under one of
-- the following licenses, the combination of the program with the linked
-- library is not considered a "derivative work" of the program:
--
--     - Apache License, version 2.0
--     - Apache Software License, version 1.0
--     - GNU Lesser General Public License, version 3
--     - Mozilla Public License, versions 1.0, 1.1 and 2.0
--     - Common Development and Distribution License (CDDL), version 1.0
--
-- Therefore the distribution of the program linked with libraries licensed
-- under the aforementioned licenses, is permitted by the copyright holders
-- if the distribution is compliant with both the GNU General Public
-- License version 2 and the aforementioned licenses.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
-- Public License for more details.
--

create table public."procedure" (procedureId int8 not null, hibernateDiscriminator char(1) not null, procedureDescriptionFormatId int8 not null, identifier varchar(255) not null, codespace int8, name varchar(255), codespaceName int8, description varchar(255), deleted char(1) default 'F' not null check (deleted in ('T','F')), disabled char(1) default 'F' not null check (disabled in ('T','F')), descriptionFile text, referenceFlag char(1) default 'F' check (referenceFlag in ('T','F')), typeOf int8, isType char(1) default 'F' check (isType in ('T','F')), isAggregation char(1) default 'T' check (isAggregation in ('T','F')), primary key (procedureId));
comment on table public."procedure" is 'Table to store the procedure/sensor. Mapping file: mapping/core/Procedure.hbm.xml';
comment on column public."procedure".procedureId is 'Table primary key, used for relations';
comment on column public."procedure".procedureDescriptionFormatId is 'Relation/foreign key to the procedureDescriptionFormat table. Describes the format of the procedure description.';
comment on column public."procedure".identifier is 'The identifier of the procedure, gml:identifier. Used as parameter for queries. Unique';
comment on column public."procedure".codespace is 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
comment on column public."procedure".name is 'The name of the procedure, gml:name. Optional';
comment on column public."procedure".codespaceName is 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';
comment on column public."procedure".description is 'Description of the procedure, gml:description. Optional';
comment on column public."procedure".deleted is 'Flag to indicate that this procedure is deleted or not (OGC SWES 2.0 - DeleteSensor operation)';
comment on column public."procedure".disabled is 'For later use by the SOS. Indicator if this procedure should not be provided by the SOS.';
comment on column public."procedure".descriptionFile is 'Field for full (XML) encoded procedure description or link to a procedure description file. Optional';
comment on column public."procedure".referenceFlag is 'Flag to indicate that this procedure is a reference procedure of another procedure. Not used by the SOS but by the Sensor Web REST-API';
comment on column public."procedure".typeOf is 'Relation/foreign key to procedure table. Optional, contains procedureId if this procedure is typeOf another procedure';
comment on column public."procedure".isType is 'Flag to indicate that this procedure is a type description, has no observations.';
comment on column public."procedure".isAggregation is 'Flag to indicate that this procedure is an aggregation (e.g. System, PhysicalSystem).';
create table public.blobValue (observationId int8 not null, value oid, primary key (observationId));
comment on table public.blobValue is 'Value table for blob observation';
comment on column public.blobValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.blobValue.value is 'Blob observation value';
create table public.booleanParameterValue (parameterId int8 not null, value char(1), primary key (parameterId), check (value in ('T','F')));
comment on table public.booleanParameterValue is 'Value table for boolean parameter';
comment on column public.booleanParameterValue.parameterId is 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
comment on column public.booleanParameterValue.value is 'Boolean parameter value';
create table public.booleanValue (observationId int8 not null, value char(1), primary key (observationId), check (value in ('T','F')), check (value in ('T','F')));
comment on table public.booleanValue is 'Value table for boolean observation';
comment on column public.booleanValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.booleanValue.value is 'Boolean observation value';
create table public.categoryParameterValue (parameterId int8 not null, value varchar(255), unitId int8, primary key (parameterId));
comment on table public.categoryParameterValue is 'Value table for category parameter';
comment on column public.categoryParameterValue.parameterId is 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
comment on column public.categoryParameterValue.value is 'Category parameter value';
comment on column public.categoryParameterValue.unitId is 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
create table public.categoryValue (observationId int8 not null, value varchar(255), primary key (observationId));
comment on table public.categoryValue is 'Value table for category observation';
comment on column public.categoryValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.categoryValue.value is 'Category observation value';
create table public.codespace (codespaceId int8 not null, codespace varchar(255) not null, primary key (codespaceId));
comment on table public.codespace is 'Table to store the gml:identifier and gml:name codespace information. Mapping file: mapping/core/Codespace.hbm.xml';
comment on column public.codespace.codespaceId is 'Table primary key, used for relations';
comment on column public.codespace.codespace is 'The codespace value';
create table public.complexValue (observationId int8 not null, primary key (observationId));
comment on table public.complexValue is 'Value table for complex observation';
comment on column public.complexValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
create table public.compositeObservation (observationId int8 not null, childObservationId int8 not null, primary key (observationId, childObservationId));
comment on table public.compositeObservation is 'Relation table for complex parent/child observations';
comment on column public.compositeObservation.observationId is 'Foreign Key (FK) to the related parent complex observation. Contains "observation".observationid';
comment on column public.compositeObservation.childObservationId is 'Foreign Key (FK) to the related child complex observation. Contains "observation".observationid';
create table public.compositePhenomenon (parentObservablePropertyId int8 not null, childObservablePropertyId int8 not null, primary key (childObservablePropertyId, parentObservablePropertyId));
comment on table public.compositePhenomenon is 'Relation table to store observableProperty hierarchies, aka compositePhenomenon. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TObservableProperty.hbm.xml';
comment on column public.compositePhenomenon.parentObservablePropertyId is 'Foreign Key (FK) to the related parent observableProperty. Contains "observableProperty".observablePropertyid';
comment on column public.compositePhenomenon.childObservablePropertyId is 'Foreign Key (FK) to the related child observableProperty. Contains "observableProperty".observablePropertyid';
create table public.countParameterValue (parameterId int8 not null, value int4, primary key (parameterId));
comment on table public.countParameterValue is 'Value table for count parameter';
comment on column public.countParameterValue.parameterId is 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
comment on column public.countParameterValue.value is 'Count parameter value';
create table public.countValue (observationId int8 not null, value int4, primary key (observationId));
comment on table public.countValue is 'Value table for count observation';
comment on column public.countValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.countValue.value is 'Count observation value';
create table public.featureOfInterest (featureOfInterestId int8 not null, featureOfInterestTypeId int8 not null, identifier varchar(255), codespace int8, name varchar(255), codespaceName int8, description varchar(255), geom GEOMETRY, descriptionXml text, url varchar(255), primary key (featureOfInterestId));
comment on table public.featureOfInterest is 'Table to store the FeatureOfInterest information. Mapping file: mapping/core/FeatureOfInterest.hbm.xml';
comment on column public.featureOfInterest.featureOfInterestId is 'Table primary key, used for relations';
comment on column public.featureOfInterest.featureOfInterestTypeId is 'Relation/foreign key to the featureOfInterestType table. Describes the type of the featureOfInterest. Contains "featureOfInterestType".featureOfInterestTypeId';
comment on column public.featureOfInterest.identifier is 'The identifier of the featureOfInterest, gml:identifier. Used as parameter for queries. Optional but unique';
comment on column public.featureOfInterest.codespace is 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
comment on column public.featureOfInterest.name is 'The name of the featureOfInterest, gml:name. Optional';
comment on column public.featureOfInterest.codespaceName is 'The name of the featureOfInterest, gml:name. Optional';
comment on column public.featureOfInterest.description is 'Description of the featureOfInterest, gml:description. Optional';
comment on column public.featureOfInterest.geom is 'The geometry of the featureOfInterest (composed of the �latitude� and �longitude�) . Optional';
comment on column public.featureOfInterest.descriptionXml is 'XML description of the feature, used when transactional profile is supported . Optional';
comment on column public.featureOfInterest.url is 'Reference URL to the feature if it is stored in another service, e.g. WFS. Optional but unique';
create table public.featureOfInterestType (featureOfInterestTypeId int8 not null, featureOfInterestType varchar(255) not null, primary key (featureOfInterestTypeId));
comment on table public.featureOfInterestType is 'Table to store the FeatureOfInterestType information. Mapping file: mapping/core/FeatureOfInterestType.hbm.xml';
comment on column public.featureOfInterestType.featureOfInterestTypeId is 'Table primary key, used for relations';
comment on column public.featureOfInterestType.featureOfInterestType is 'The featureOfInterestType value, e.g. http://www.opengis.net/def/samplingFeatureType/OGC-OM/2.0/SF_SamplingPoint (OGC OM 2.0 specification) for point features';
create table public.featureRelation (parentFeatureId int8 not null, childFeatureId int8 not null, primary key (childFeatureId, parentFeatureId));
comment on table public.featureRelation is 'Relation table to store feature hierarchies. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TFeatureOfInterest.hbm.xml';
comment on column public.featureRelation.parentFeatureId is 'Foreign Key (FK) to the related parent featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
comment on column public.featureRelation.childFeatureId is 'Foreign Key (FK) to the related child featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
create table public.geometryValue (observationId int8 not null, value GEOMETRY, primary key (observationId));
comment on table public.geometryValue is 'Value table for geometry observation';
comment on column public.geometryValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.geometryValue.value is 'Geometry observation value';
create table public.i18nfeatureOfInterest (id int8 not null, objectId int8 not null, locale varchar(255) not null, name varchar(255), description varchar(255), primary key (id));
comment on table public.i18nfeatureOfInterest is 'Table to i18n metadata for the featureOfInterest. Mapping file: mapping/i18n/HibernateI18NFeatureOfInterestMetadata.hbm.xml';
comment on column public.i18nfeatureOfInterest.id is 'Table primary key';
comment on column public.i18nfeatureOfInterest.objectId is 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
comment on column public.i18nfeatureOfInterest.locale is 'Locale/language identification, e.g. eng, ger';
comment on column public.i18nfeatureOfInterest.name is 'Locale/language specific name of the featureOfInterest';
comment on column public.i18nfeatureOfInterest.description is 'Locale/language specific description of the featureOfInterest';
create table public.i18nobservableProperty (id int8 not null, objectId int8 not null, locale varchar(255) not null, name varchar(255), description varchar(255), primary key (id));
comment on table public.i18nobservableProperty is 'Table to i18n metadata for the observableProperty/phenomenon. Mapping file: mapping/i18n/HibernateI18NObservablePropertyMetadata.hbm.xml';
comment on column public.i18nobservableProperty.id is 'Table primary key';
comment on column public.i18nobservableProperty.objectId is 'Foreign Key (FK) to the related observableProperty. Contains "observableProperty".observablePropertyid';
comment on column public.i18nobservableProperty.locale is 'Locale/language identification, e.g. eng, ger';
comment on column public.i18nobservableProperty.name is 'Locale/language specific name of the observableProperty';
comment on column public.i18nobservableProperty.description is 'Locale/language specific description of the observableProperty';
create table public.i18noffering (id int8 not null, objectId int8 not null, locale varchar(255) not null, name varchar(255), description varchar(255), primary key (id));
comment on table public.i18noffering is 'Table to i18n metadata for the offering. Mapping file: mapping/i18n/HibernateI18NOfferingMetadata.hbm.xml';
comment on column public.i18noffering.id is 'Table primary key';
comment on column public.i18noffering.objectId is 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
comment on column public.i18noffering.locale is 'Locale/language identification, e.g. eng, ger';
comment on column public.i18noffering.name is 'Locale/language specific name of the offering';
comment on column public.i18noffering.description is 'Locale/language specific description of the offering';
create table public.i18nprocedure (id int8 not null, objectId int8 not null, locale varchar(255) not null, name varchar(255), description varchar(255), shortname varchar(255), longname varchar(255), primary key (id));
comment on table public.i18nprocedure is 'Table to i18n metadata for the procedure. Mapping file: mapping/i18n/HibernateI18NProcedureMetadata.hbm.xml';
comment on column public.i18nprocedure.id is 'Table primary key';
comment on column public.i18nprocedure.objectId is 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';
comment on column public.i18nprocedure.locale is 'Locale/language identification, e.g. eng, ger';
comment on column public.i18nprocedure.name is 'Locale/language specific name of the procedure';
comment on column public.i18nprocedure.description is 'Locale/language specific description of the procedure';
comment on column public.i18nprocedure.shortname is 'Locale/language specific shortname of the procedure';
comment on column public.i18nprocedure.longname is 'Locale/language specific longname of the procedure';
create table public.numericParameterValue (parameterId int8 not null, value float8, unitId int8, primary key (parameterId));
comment on table public.numericParameterValue is 'Value table for numeric/Measurment parameter';
comment on column public.numericParameterValue.parameterId is 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
comment on column public.numericParameterValue.value is 'Numeric/Quantity parameter value';
comment on column public.numericParameterValue.unitId is 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
create table public.numericValue (observationId int8 not null, value float8, primary key (observationId));
comment on table public.numericValue is 'Value table for numeric/Measurment observation';
comment on column public.numericValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.numericValue.value is 'Numeric/Measurment observation value';
create table public.observableProperty (observablePropertyId int8 not null, identifier varchar(255) not null, codespace int8, name varchar(255), codespaceName int8, description varchar(255), disabled char(1) default 'F' not null check (disabled in ('T','F')), hiddenChild char(1) default 'F' not null check (hiddenChild in ('T','F')), primary key (observablePropertyId));
comment on table public.observableProperty is 'Table to store the ObservedProperty/Phenomenon information. Mapping file: mapping/core/ObservableProperty.hbm.xml';
comment on column public.observableProperty.observablePropertyId is 'Table primary key, used for relations';
comment on column public.observableProperty.identifier is 'The identifier of the observableProperty, gml:identifier. Used as parameter for queries. Unique';
comment on column public.observableProperty.codespace is 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
comment on column public.observableProperty.name is 'The name of the observableProperty, gml:name. Optional';
comment on column public.observableProperty.codespaceName is 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';
comment on column public.observableProperty.description is 'Description of the observableProperty, gml:description. Optional';
comment on column public.observableProperty.disabled is 'For later use by the SOS. Indicator if this observableProperty should not be provided by the SOS.';
create table public.observation (observationId int8 not null, featureOfInterestId int8 not null, observablePropertyId int8 not null, procedureId int8 not null, phenomenonTimeStart timestamp not null, phenomenonTimeEnd timestamp not null, resultTime timestamp not null, identifier varchar(255), codespace int8, name varchar(255), codespaceName int8, description varchar(255), deleted char(1) default 'F' not null check (deleted in ('T','F')), child char(1) default 'F' not null check (child in ('T','F')), parent char(1) default 'F' not null check (parent in ('T','F')), validTimeStart timestamp default NULL, validTimeEnd timestamp default NULL, samplingGeometry GEOMETRY, unitId int8, primary key (observationId));
comment on table public.observation is 'Stores the observations. Mapping file: mapping/old/observation/ValuedObservation.hbm.xml';
comment on column public.observation.featureOfInterestId is 'Relation/foreign key to the associated featureOfInterest table. Contains "featureOfInterest".featureOfInterestId';
comment on column public.observation.observablePropertyId is 'Relation/foreign key to the associated observableProperty table. Contains "observableProperty".observablePropertyId';
comment on column public.observation.procedureId is 'Relation/foreign key to the associated procedure table. Contains "procedure".procedureId';
comment on column public.observation.phenomenonTimeStart is 'Time stamp when the observation was started or phenomenon was observed';
comment on column public.observation.phenomenonTimeEnd is 'Time stamp when the observation was stopped or phenomenon was observed';
comment on column public.observation.resultTime is 'Time stamp when the observation was published or result was published/available';
comment on column public.observation.identifier is 'The identifier of the observation, gml:identifier. Used as parameter for queries. Optional but unique';
comment on column public.observation.codespace is 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
comment on column public.observation.name is 'The name of the observation, gml:name. Optional';
comment on column public.observation.codespaceName is 'The name of the observation, gml:name. Optional';
comment on column public.observation.description is 'Description of the observation, gml:description. Optional';
comment on column public.observation.deleted is 'Flag to indicate that this observation is deleted or not (OGC SWES 2.0 - DeleteSensor operation or not specified DeleteObservation)';
comment on column public.observation.child is 'Flag to indicate that this observation is a child observation for complex observation';
comment on column public.observation.parent is 'Flag to indicate that this observation is a parent observation for complex observation';
comment on column public.observation.validTimeStart is 'Start time stamp for which the observation/result is valid, e.g. used for forecasting. Optional';
comment on column public.observation.validTimeEnd is 'End time stamp for which the observation/result is valid, e.g. used for forecasting. Optional';
comment on column public.observation.samplingGeometry is 'Sampling geometry describes exactly where the measurement has taken place. Used for OGC SOS 2.0 Spatial Filtering Profile. Optional';
comment on column public.observation.unitId is 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';
create table public.observationConstellation (observationConstellationId int8 not null, observablePropertyId int8 not null, procedureId int8 not null, observationTypeId int8, offeringId int8 not null, deleted char(1) default 'F' not null check (deleted in ('T','F')), hiddenChild char(1) default 'F' not null check (hiddenChild in ('T','F')), primary key (observationConstellationId));
comment on table public.observationConstellation is 'Table to store the ObservationConstellation information. Contains information about the constellation of observableProperty, procedure, offering and the observationType. Mapping file: mapping/core/ObservationConstellation.hbm.xml';
comment on column public.observationConstellation.observationConstellationId is 'Table primary key, used for relations';
comment on column public.observationConstellation.observablePropertyId is 'Foreign Key (FK) to the related observableProperty. Contains "observableproperty".observablepropertyid';
comment on column public.observationConstellation.procedureId is 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';
comment on column public.observationConstellation.observationTypeId is 'Foreign Key (FK) to the related observableProperty. Contains "observationtype".observationtypeid';
comment on column public.observationConstellation.offeringId is 'Foreign Key (FK) to the related observableProperty. Contains "offering".offeringid';
comment on column public.observationConstellation.deleted is 'Flag to indicate that this observationConstellation is deleted or not. Set if the related procedure is deleted via DeleteSensor operation (OGC SWES 2.0 - DeleteSensor operation)';
comment on column public.observationConstellation.hiddenChild is 'Flag to indicate that this observationConstellations procedure is a child procedure of another procedure. If true, the related procedure is not contained in OGC SOS 2.0 Capabilities but in OGC SOS 1.0.0 Capabilities.';
create table public.observationHasOffering (observationId int8 not null, offeringId int8 not null, primary key (observationId, offeringId));
comment on column public.observationHasOffering.observationId is 'Foreign Key (FK) to the related observation. Contains "observation".observationid';
comment on column public.observationHasOffering.offeringId is 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
create table public.observationType (observationTypeId int8 not null, observationType varchar(255) not null, primary key (observationTypeId));
comment on table public.observationType is 'Table to store the observationTypes. Mapping file: mapping/core/ObservationType.hbm.xml';
comment on column public.observationType.observationTypeId is 'Table primary key, used for relations';
comment on column public.observationType.observationType is 'The observationType value, e.g. http://www.opengis.net/def/observationType/OGC-OM/2.0/OM_Measurement (OGC OM 2.0 specification) for OM_Measurement';
create table public.offering (offeringId int8 not null, hibernateDiscriminator char(1) not null, identifier varchar(255) not null, codespace int8, name varchar(255), codespaceName int8, description varchar(255), disabled char(1) default 'F' not null check (disabled in ('T','F')), primary key (offeringId));
comment on table public.offering is 'Table to store the offering information. Mapping file: mapping/core/Offering.hbm.xml';
comment on column public.offering.offeringId is 'Table primary key, used for relations';
comment on column public.offering.identifier is 'The identifier of the offering, gml:identifier. Used as parameter for queries. Unique';
comment on column public.offering.codespace is 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';
comment on column public.offering.name is 'The name of the offering, gml:name. If available, displyed in the contents of the Capabilites. Optional';
comment on column public.offering.codespaceName is 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';
comment on column public.offering.description is 'Description of the offering, gml:description. Optional';
comment on column public.offering.disabled is 'For later use by the SOS. Indicator if this offering should not be provided by the SOS.';
create table public.offeringAllowedFeatureType (offeringId int8 not null, featureOfInterestTypeId int8 not null, primary key (offeringId, featureOfInterestTypeId));
comment on table public.offeringAllowedFeatureType is 'Table to store relations between offering and allowed featureOfInterestTypes, defined in InsertSensor request. Mapping file: mapping/transactional/TOffering.hbm.xml';
comment on column public.offeringAllowedFeatureType.offeringId is 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
comment on column public.offeringAllowedFeatureType.featureOfInterestTypeId is 'Foreign Key (FK) to the related featureOfInterestTypeId. Contains "featureOfInterestType".featureOfInterestTypeId';
create table public.offeringAllowedObservationType (offeringId int8 not null, observationTypeId int8 not null, primary key (offeringId, observationTypeId));
comment on table public.offeringAllowedObservationType is 'Table to store relations between offering and allowed observationTypes, defined in InsertSensor request. Mapping file: mapping/transactional/TOffering.hbm.xml';
comment on column public.offeringAllowedObservationType.offeringId is 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
comment on column public.offeringAllowedObservationType.observationTypeId is 'Foreign Key (FK) to the related observationType. Contains "observationType".observationTypeId';
create table public.offeringHasRelatedFeature (relatedFeatureId int8 not null, offeringId int8 not null, primary key (offeringId, relatedFeatureId));
comment on table public.offeringHasRelatedFeature is 'Table to store relations between offering and associated relatedFeatures. Mapping file: mapping/transactional/TOffering.hbm.xml';
comment on column public.offeringHasRelatedFeature.relatedFeatureId is 'Foreign Key (FK) to the related relatedFeature. Contains "relatedFeature".relatedFeatureid';
comment on column public.offeringHasRelatedFeature.offeringId is 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
create table public.parameter (parameterId int8 not null, observationId int8 not null, name varchar(255) not null, primary key (parameterId));
comment on table public.parameter is 'Table to store additional obervation information (om:parameter). Mapping file: mapping/core/Parameter.hbm.xml';
comment on column public.parameter.parameterId is 'Table primary key';
comment on column public.parameter.observationId is 'Foreign Key (FK) to the related observation. Contains "observation".observationId';
comment on column public.parameter.name is 'Parameter name';
create table public.procedureDescriptionFormat (procedureDescriptionFormatId int8 not null, procedureDescriptionFormat varchar(255) not null, primary key (procedureDescriptionFormatId));
comment on table public.procedureDescriptionFormat is 'Table to store the ProcedureDescriptionFormat information of procedures. Mapping file: mapping/core/ProcedureDescriptionFormat.hbm.xml';
comment on column public.procedureDescriptionFormat.procedureDescriptionFormatId is 'Table primary key, used for relations';
comment on column public.procedureDescriptionFormat.procedureDescriptionFormat is 'The procedureDescriptionFormat value, e.g. http://www.opengis.net/sensorML/1.0.1 for procedures descriptions as specified in OGC SensorML 1.0.1';
create table public.relatedFeature (relatedFeatureId int8 not null, featureOfInterestId int8 not null, primary key (relatedFeatureId));
comment on table public.relatedFeature is 'Table to store related feature information used in the OGC SOS 2.0 Capabilities (See also OGC SWES 2.0). Mapping file: mapping/transactionl/RelatedFeature.hbm.xml';
comment on column public.relatedFeature.relatedFeatureId is 'Table primary key, used for relations';
comment on column public.relatedFeature.featureOfInterestId is 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
create table public.relatedFeatureHasRole (relatedFeatureId int8 not null, relatedFeatureRoleId int8 not null, primary key (relatedFeatureId, relatedFeatureRoleId));
comment on table public.relatedFeatureHasRole is 'Relation table to store relatedFeatures and their associated relatedFeatureRoles. Mapping file: mapping/transactionl/RelatedFeature.hbm.xml';
comment on column public.relatedFeatureHasRole.relatedFeatureId is 'Foreign Key (FK) to the related relatedFeature. Contains "relatedFeature".relatedFeatureid';
comment on column public.relatedFeatureHasRole.relatedFeatureRoleId is 'Foreign Key (FK) to the related relatedFeatureRole. Contains "relatedFeatureRole".relatedFeatureRoleid';
create table public.relatedFeatureRole (relatedFeatureRoleId int8 not null, relatedFeatureRole varchar(255) not null, primary key (relatedFeatureRoleId));
comment on table public.relatedFeatureRole is 'Table to store related feature role information used in the OGC SOS 2.0 Capabilities (See also OGC SWES 2.0). Mapping file: mapping/transactionl/RelatedFeatureRole.hbm.xml';
comment on column public.relatedFeatureRole.relatedFeatureRoleId is 'Table primary key, used for relations';
comment on column public.relatedFeatureRole.relatedFeatureRole is 'The related feature role definition. See OGC SWES 2.0 specification';
create table public.resultTemplate (resultTemplateId int8 not null, offeringId int8 not null, observablePropertyId int8 not null, procedureId int8 not null, featureOfInterestId int8 not null, identifier varchar(255) not null, resultStructure text not null, resultEncoding text not null, primary key (resultTemplateId));
comment on table public.resultTemplate is 'Table to store resultTemplates (OGC SOS 2.0 result handling profile). Mapping file: mapping/transactionl/ResultTemplate.hbm.xml';
comment on column public.resultTemplate.resultTemplateId is 'Table primary key';
comment on column public.resultTemplate.offeringId is 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
comment on column public.resultTemplate.observablePropertyId is 'Foreign Key (FK) to the related observableProperty. Contains "observableProperty".observablePropertyId';
comment on column public.resultTemplate.procedureId is 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureId';
comment on column public.resultTemplate.featureOfInterestId is 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestid';
comment on column public.resultTemplate.identifier is 'The resultTemplate identifier, required for InsertResult requests.';
comment on column public.resultTemplate.resultStructure is 'The resultStructure as XML string. Describes the types and order of the values in a GetResultResponse/InsertResultRequest';
comment on column public.resultTemplate.resultEncoding is 'The resultEncoding as XML string. Describes the encoding of the values in a GetResultResponse/InsertResultRequest';
create table public.sensorSystem (parentSensorId int8 not null, childSensorId int8 not null, primary key (childSensorId, parentSensorId));
comment on table public.sensorSystem is 'Relation table to store procedure hierarchies. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TProcedure.hbm.xml';
comment on column public.sensorSystem.parentSensorId is 'Foreign Key (FK) to the related parent procedure. Contains "procedure".procedureid';
comment on column public.sensorSystem.childSensorId is 'Foreign Key (FK) to the related child procedure. Contains "procedure".procedureid';
create table public.sweDataArrayValue (observationId int8 not null, value text, primary key (observationId));
comment on table public.sweDataArrayValue is 'Value table for SweDataArray observation';
comment on column public.sweDataArrayValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.sweDataArrayValue.value is 'SweDataArray observation value';
create table public.textParameterValue (parameterId int8 not null, value varchar(255), primary key (parameterId));
comment on table public.textParameterValue is 'Value table for text parameter';
comment on column public.textParameterValue.parameterId is 'Foreign Key (FK) to the related parameter from the parameter table. Contains "parameter".parameterid';
comment on column public.textParameterValue.value is 'Text parameter value';
create table public.textValue (observationId int8 not null, value text, primary key (observationId));
comment on table public.textValue is 'Value table for text observation';
comment on column public.textValue.observationId is 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';
comment on column public.textValue.value is 'Text observation value';
create table public.unit (unitId int8 not null, unit varchar(255) not null, primary key (unitId));
comment on table public.unit is 'Table to store the unit of measure information, used in observations. Mapping file: mapping/core/Unit.hbm.xml';
comment on column public.unit.unitId is 'Table primary key, used for relations';
comment on column public.unit.unit is 'The unit of measure of observations. See http://unitsofmeasure.org/ucum.html';
create table public.validProcedureTime (validProcedureTimeId int8 not null, procedureId int8 not null, procedureDescriptionFormatId int8 not null, startTime timestamp not null, endTime timestamp, descriptionXml text not null, primary key (validProcedureTimeId));
comment on table public.validProcedureTime is 'Table to store procedure descriptions which were inserted or updated via the transactional Profile. Mapping file: mapping/transactionl/ValidProcedureTime.hbm.xml';
comment on column public.validProcedureTime.validProcedureTimeId is 'Table primary key';
comment on column public.validProcedureTime.procedureId is 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';
comment on column public.validProcedureTime.procedureDescriptionFormatId is 'Foreign Key (FK) to the related procedureDescriptionFormat. Contains "procedureDescriptionFormat".procedureDescriptionFormatid';
comment on column public.validProcedureTime.startTime is 'Timestamp since this procedure description is valid';
comment on column public.validProcedureTime.endTime is 'Timestamp since this procedure description is invalid';
comment on column public.validProcedureTime.descriptionXml is 'Procedure description as XML string';
alter table public."procedure" add constraint procIdentifierUK unique (identifier);
create index booleanParamIdx on public.booleanParameterValue (value);
create index categoryParamIdx on public.categoryParameterValue (value);
alter table public.codespace add constraint codespaceUK unique (codespace);
create index countParamIdx on public.countParameterValue (value);
alter table public.featureOfInterest add constraint foiIdentifierUK unique (identifier);
alter table public.featureOfInterest add constraint featureUrl unique (url);
alter table public.featureOfInterestType add constraint featureTypeUK unique (featureOfInterestType);
alter table public.i18nfeatureOfInterest add constraint i18nFeatureIdentity unique (objectId, locale);
create index i18nFeatureIdx on public.i18nfeatureOfInterest (objectId);
alter table public.i18nobservableProperty add constraint i18nobsPropIdentity unique (objectId, locale);
create index i18nObsPropIdx on public.i18nobservableProperty (objectId);
alter table public.i18noffering add constraint i18nOfferingIdentity unique (objectId, locale);
create index i18nOfferingIdx on public.i18noffering (objectId);
alter table public.i18nprocedure add constraint i18nProcedureIdentity unique (objectId, locale);
create index i18nProcedureIdx on public.i18nprocedure (objectId);
create index quantityParamIdx on public.numericParameterValue (value);
alter table public.observableProperty add constraint obsPropIdentifierUK unique (identifier);
alter table public.observation add constraint obsIdentifierUK unique (identifier);
create index obsFeatureIdx on public.observation (featureOfInterestId);
create index obsObsPropIdx on public.observation (observablePropertyId);
create index obsProcedureIdx on public.observation (procedureId);
create index obsPhenTimeStartIdx on public.observation (phenomenonTimeStart);
create index obsPhenTimeEndIdx on public.observation (phenomenonTimeEnd);
create index obsResultTimeIdx on public.observation (resultTime);
alter table public.observationConstellation add constraint obsnConstellationIdentity unique (observablePropertyId, procedureId, offeringId);
create index obsConstObsPropIdx on public.observationConstellation (observablePropertyId);
create index obsConstProcedureIdx on public.observationConstellation (procedureId);
create index obsConstOfferingIdx on public.observationConstellation (offeringId);
create index obshasoffobservationidx on public.observationHasOffering (observationId);
create index obshasoffofferingidx on public.observationHasOffering (offeringId);
alter table public.observationType add constraint observationTypeUK unique (observationType);
alter table public.offering add constraint offIdentifierUK unique (identifier);
create index paramNameIdx on public.parameter (name);
alter table public.procedureDescriptionFormat add constraint procDescFormatUK unique (procedureDescriptionFormat);
alter table public.relatedFeatureRole add constraint relFeatRoleUK unique (relatedFeatureRole);
create index resultTempOfferingIdx on public.resultTemplate (offeringId);
create index resultTempeObsPropIdx on public.resultTemplate (observablePropertyId);
create index resultTempProcedureIdx on public.resultTemplate (procedureId);
create index resultTempIdentifierIdx on public.resultTemplate (identifier);
create index textParamIdx on public.textParameterValue (value);
alter table public.unit add constraint unitUK unique (unit);
create index validProcedureTimeStartTimeIdx on public.validProcedureTime (startTime);
create index validProcedureTimeEndTimeIdx on public.validProcedureTime (endTime);
alter table public."procedure" add constraint procProcDescFormatFk foreign key (procedureDescriptionFormatId) references public.procedureDescriptionFormat;
alter table public."procedure" add constraint procCodespaceIdentifierFk foreign key (codespace) references public.codespace;
alter table public."procedure" add constraint procCodespaceNameFk foreign key (codespaceName) references public.codespace;
alter table public."procedure" add constraint typeOfFk foreign key (typeOf) references public."procedure";
alter table public.blobValue add constraint observationBlobValueFk foreign key (observationId) references public.observation;
alter table public.booleanParameterValue add constraint parameterBooleanValueFk foreign key (parameterId) references public.parameter;
alter table public.booleanValue add constraint observationBooleanValueFk foreign key (observationId) references public.observation;
alter table public.categoryParameterValue add constraint parameterCategoryValueFk foreign key (parameterId) references public.parameter;
alter table public.categoryParameterValue add constraint catParamValueUnitFk foreign key (unitId) references public.unit;
alter table public.categoryValue add constraint observationCategoryValueFk foreign key (observationId) references public.observation;
alter table public.complexValue add constraint observationComplexValueFk foreign key (observationId) references public.observation;
alter table public.compositeObservation add constraint observationChildFk foreign key (childObservationId) references public.observation;
alter table public.compositeObservation add constraint observationParentFK foreign key (observationId) references public.complexValue;
alter table public.compositePhenomenon add constraint observablePropertyChildFk foreign key (childObservablePropertyId) references public.observableProperty;
alter table public.compositePhenomenon add constraint observablePropertyParentFk foreign key (parentObservablePropertyId) references public.observableProperty;
alter table public.countParameterValue add constraint parameterCountValueFk foreign key (parameterId) references public.parameter;
alter table public.countValue add constraint observationCountValueFk foreign key (observationId) references public.observation;
alter table public.featureOfInterest add constraint featureFeatureTypeFk foreign key (featureOfInterestTypeId) references public.featureOfInterestType;
alter table public.featureOfInterest add constraint featureCodespaceIdentifierFk foreign key (codespace) references public.codespace;
alter table public.featureOfInterest add constraint featureCodespaceNameFk foreign key (codespaceName) references public.codespace;
alter table public.featureRelation add constraint featureOfInterestChildFk foreign key (childFeatureId) references public.featureOfInterest;
alter table public.featureRelation add constraint featureOfInterestParentFk foreign key (parentFeatureId) references public.featureOfInterest;
alter table public.geometryValue add constraint observationGeometryValueFk foreign key (observationId) references public.observation;
alter table public.i18nfeatureOfInterest add constraint i18nFeatureFeatureFk foreign key (objectId) references public.featureOfInterest;
alter table public.i18nobservableProperty add constraint i18nObsPropObsPropFk foreign key (objectId) references public.observableProperty;
alter table public.i18noffering add constraint i18nOfferingOfferingFk foreign key (objectId) references public.offering;
alter table public.i18nprocedure add constraint i18nProcedureProcedureFk foreign key (objectId) references public."procedure";
alter table public.numericParameterValue add constraint parameterNumericValueFk foreign key (parameterId) references public.parameter;
alter table public.numericParameterValue add constraint quanParamValueUnitFk foreign key (unitId) references public.unit;
alter table public.numericValue add constraint observationNumericValueFk foreign key (observationId) references public.observation;
alter table public.observableProperty add constraint obsPropCodespaceIdentifierFk foreign key (codespace) references public.codespace;
alter table public.observableProperty add constraint obsPropCodespaceNameFk foreign key (codespaceName) references public.codespace;
alter table public.observation add constraint observationFeatureFk foreign key (featureOfInterestId) references public.featureOfInterest;
alter table public.observation add constraint observationObPropFk foreign key (observablePropertyId) references public.observableProperty;
alter table public.observation add constraint observationProcedureFk foreign key (procedureId) references public."procedure";
alter table public.observation add constraint obsCodespaceIdentifierFk foreign key (codespace) references public.codespace;
alter table public.observation add constraint obsCodespaceNameFk foreign key (codespaceName) references public.codespace;
alter table public.observation add constraint observationUnitFk foreign key (unitId) references public.unit;
alter table public.observationConstellation add constraint obsConstObsPropFk foreign key (observablePropertyId) references public.observableProperty;
alter table public.observationConstellation add constraint obsnConstProcedureFk foreign key (procedureId) references public."procedure";
alter table public.observationConstellation add constraint obsConstObservationIypeFk foreign key (observationTypeId) references public.observationType;
alter table public.observationConstellation add constraint obsConstOfferingFk foreign key (offeringId) references public.offering;
alter table public.observationHasOffering add constraint observationOfferingFk foreign key (offeringId) references public.offering;
alter table public.observationHasOffering add constraint FK_9ex7hawh3dbplkllmw5w3kvej foreign key (observationId) references public.observation;
alter table public.offering add constraint offCodespaceIdentifierFk foreign key (codespace) references public.codespace;
alter table public.offering add constraint offCodespaceNameFk foreign key (codespaceName) references public.codespace;
alter table public.offeringAllowedFeatureType add constraint offeringFeatureTypeFk foreign key (featureOfInterestTypeId) references public.featureOfInterestType;
alter table public.offeringAllowedFeatureType add constraint FK_6vvrdxvd406n48gkm706ow1pt foreign key (offeringId) references public.offering;
alter table public.offeringAllowedObservationType add constraint offeringObservationTypeFk foreign key (observationTypeId) references public.observationType;
alter table public.offeringAllowedObservationType add constraint FK_lkljeohulvu7cr26pduyp5bd0 foreign key (offeringId) references public.offering;
alter table public.offeringHasRelatedFeature add constraint relatedFeatureOfferingFk foreign key (offeringId) references public.offering;
alter table public.offeringHasRelatedFeature add constraint offeringRelatedFeatureFk foreign key (relatedFeatureId) references public.relatedFeature;
alter table public.parameter add constraint FK_3v5iovcndi9w0hgh827hcvivw foreign key (observationId) references public.observation;
alter table public.relatedFeature add constraint relatedFeatureFeatureFk foreign key (featureOfInterestId) references public.featureOfInterest;
alter table public.relatedFeatureHasRole add constraint relatedFeatRelatedFeatRoleFk foreign key (relatedFeatureRoleId) references public.relatedFeatureRole;
alter table public.relatedFeatureHasRole add constraint FK_6ynwkk91xe8p1uibmjt98sog3 foreign key (relatedFeatureId) references public.relatedFeature;
alter table public.resultTemplate add constraint resultTemplateOfferingIdx foreign key (offeringId) references public.offering;
alter table public.resultTemplate add constraint resultTemplateObsPropFk foreign key (observablePropertyId) references public.observableProperty;
alter table public.resultTemplate add constraint resultTemplateProcedureFk foreign key (procedureId) references public."procedure";
alter table public.resultTemplate add constraint resultTemplateFeatureIdx foreign key (featureOfInterestId) references public.featureOfInterest;
alter table public.sensorSystem add constraint procedureChildFk foreign key (childSensorId) references public."procedure";
alter table public.sensorSystem add constraint procedureParenfFk foreign key (parentSensorId) references public."procedure";
alter table public.sweDataArrayValue add constraint observationSweDataArrayValueFk foreign key (observationId) references public.observation;
alter table public.textParameterValue add constraint parameterTextValueFk foreign key (parameterId) references public.parameter;
alter table public.textValue add constraint observationTextValueFk foreign key (observationId) references public.observation;
alter table public.validProcedureTime add constraint validProcedureTimeProcedureFk foreign key (procedureId) references public."procedure";
alter table public.validProcedureTime add constraint validProcProcDescFormatFk foreign key (procedureDescriptionFormatId) references public.procedureDescriptionFormat;
create sequence public.codespaceId_seq;
create sequence public.featureOfInterestId_seq;
create sequence public.featureOfInterestTypeId_seq;
create sequence public.i18nObsPropId_seq;
create sequence public.i18nOfferingId_seq;
create sequence public.i18nProcedureId_seq;
create sequence public.i18nfeatureOfInterestId_seq;
create sequence public.observablePropertyId_seq;
create sequence public.observationConstellationId_seq;
create sequence public.observationId_seq;
create sequence public.observationTypeId_seq;
create sequence public.offeringId_seq;
create sequence public.parameterId_seq;
create sequence public.procDescFormatId_seq;
create sequence public.procedureId_seq;
create sequence public.relatedFeatureId_seq;
create sequence public.relatedFeatureRoleId_seq;
create sequence public.resultTemplateId_seq;
create sequence public.unitId_seq;
create sequence public.validProcedureTimeId_seq;