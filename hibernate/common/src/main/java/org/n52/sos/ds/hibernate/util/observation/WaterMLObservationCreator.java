/**
 * Copyright (C) 2012-2017 52°North Initiative for Geospatial Open Source
 * Software GmbH
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published
 * by the Free Software Foundation.
 *
 * If the program is linked with libraries which are licensed under one of
 * the following licenses, the combination of the program with the linked
 * library is not considered a "derivative work" of the program:
 *
 *     - Apache License, version 2.0
 *     - Apache Software License, version 1.0
 *     - GNU Lesser General Public License, version 3
 *     - Mozilla Public License, versions 1.0, 1.1 and 2.0
 *     - Common Development and Distribution License (CDDL), version 1.0
 *
 * Therefore the distribution of the program linked with libraries licensed
 * under the aforementioned licenses, is permitted by the copyright holders
 * if the distribution is compliant with both the GNU General Public
 * License version 2 and the aforementioned licenses.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 */
package org.n52.sos.ds.hibernate.util.observation;

import java.util.Collections;
import java.util.Set;

import org.hibernate.Session;
import org.n52.sos.ds.hibernate.entities.observation.Observation;
import org.n52.sos.ds.hibernate.entities.observation.ereporting.AbstractEReportingObservation;
import org.n52.sos.ds.hibernate.entities.observation.ereporting.EReportingSeries;
import org.n52.sos.ds.hibernate.entities.observation.series.AbstractSeriesObservation;
import org.n52.sos.ds.hibernate.entities.observation.series.Series;
import org.n52.sos.exception.CodedException;
import org.n52.sos.ogc.om.OmObservation;
import org.n52.sos.ogc.series.wml.WaterMLConstants;

import com.google.common.collect.Sets;

/**
 * @author <a href="mailto:e.h.juerrens@52north.org">Eike Hinderk J&uuml;rrens</a>
 *
 */
public class WaterMLObservationCreator extends AbstractAdditionalObservationCreator<Series> {

    private static final Set<AdditionalObservationCreatorKey> KEYS =  Sets.union(
            AdditionalObservationCreatorRepository.encoderKeysForElements(WaterMLConstants.NS_WML_20,
                    AbstractSeriesObservation.class,
                    AbstractEReportingObservation.class,
                    Series.class,
                    EReportingSeries.class), 
            AdditionalObservationCreatorRepository.encoderKeysForElements("application/uvf",
                    AbstractSeriesObservation.class,
                    AbstractEReportingObservation.class,
                    Series.class,
                    EReportingSeries.class));

    @Override
    public Set<AdditionalObservationCreatorKey> getKeys() {
        return Collections.unmodifiableSet(KEYS);
    }

    @Override
    public OmObservation create(OmObservation omObservation, Observation<?> observation, Session session)
            throws CodedException {
        create(omObservation, observation);
        if (observation instanceof AbstractSeriesObservation) {
            return addWaterMLMetadata(omObservation, ((AbstractSeriesObservation<?>)observation).getSeries(), session);
        }
        return omObservation;
    }

    @Override
    public OmObservation create(OmObservation omObservation, Series series, Session session) throws CodedException {
        create(omObservation, series);
        return addWaterMLMetadata(omObservation, series, session);
    }

    @Override
    public OmObservation add(OmObservation omObservation, Observation<?> observation, Session session)
            throws CodedException {
        add(omObservation, observation);
        if (observation instanceof AbstractSeriesObservation) {
            return addWaterMLMetadata(omObservation, ((AbstractSeriesObservation<?>)observation).getSeries(), session);
        }
        return omObservation;
    }

    private OmObservation addWaterMLMetadata(OmObservation omObservation, Series series, Session session)
            throws CodedException {
        return new WaterMLMetadataAdder(omObservation, series, session).add().result();
    }

}
