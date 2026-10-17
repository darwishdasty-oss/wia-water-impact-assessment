---
title: 'WIA: a bilingual, offline-first Android application for criteria-based impact assessment of water infrastructure projects'
tags:
  - water resources
  - environmental impact assessment
  - multi-criteria decision analysis
  - Arabic
  - Flutter
authors:
  - name: Abbas Ahmed Mohammed Hebah
    orcid: 0009-0000-5689-2157
    affiliation: 1
affiliations:
  - name: Sana'a University
    index: 1
date: 17 October 2026
bibliography: paper.bib
repository-code: https://github.com/darwishdasty-oss/wia-water-impact-assessment
archive-doi: 10.5281/zenodo.23428817
---

# Summary

WIA (Water Impact Assessment) is a free, open-source, bilingual (Arabic/English) Flutter application that structures the screening stage of environmental and social impact assessment for water infrastructure projects such as dams, irrigation canals, and water-supply schemes. The assessment engine organises 38 criteria into three weighted dimensions -- environmental (14 criteria), social (12), and economic (12) -- and scores each criterion with a Leopold-matrix parameterisation [@leopold1971]: importance, magnitude, extent, duration, and reversibility combine into a raw score normalised to a 0--100 scale. Within-dimension criterion weights are user-adjustable, and the three dimension results are aggregated through configurable global weights (40/30/30 by default) into a composite project index. Every score is classified on a four-level severity scale (low, moderate, high, critical) and colour-coded for rapid reading. The application then generates prioritised mitigation recommendations for every criterion, with actions and timelines tiered by severity and mapped to the corresponding clauses of the international frameworks the criterion operationalises, including the IFC Performance Standards [@ifc2012], the World Bank Environmental and Social Framework [@worldbank2017], the Ramsar Convention [@ramsar1994], the Sendai Framework [@unisdr2015], and the IUCN Red List [@iucn2012]. The user interface is fully bilingual with one-tap language switching, and the application is offline-first: assessment data are entered, weighted, aggregated, and displayed entirely on the device, with no accounts and no servers. The criteria catalogue, the Leopold scoring arithmetic, weight normalisation, the composite-index calculation, and the recommendation tiers are covered by a unit-test suite that runs in continuous integration. WIA is intended for environmental and social specialists preparing or reviewing ESIA screenings, water-resources planners, and educators teaching impact-assessment methodology.

# Statement of need

Environmental and social impact assessment (ESIA) of water infrastructure is mandated by regulators and development lenders worldwide, and the appraisal frameworks of the international finance community -- the IFC Performance Standards [@ifc2012] and the World Bank Environmental and Social Framework [@worldbank2017] -- require systematic identification, prediction, and evaluation of impacts across environmental, social, and economic dimensions [@glasson2019; @canter1996]. In practice, the screening stage of this work is still carried out overwhelmingly in ad-hoc spreadsheets and narrative reports. Spreadsheets are difficult to version, review, and reproduce; their cell formulas are invisible to non-authors; and formula errors silently propagate into design and lending decisions. For Arabic-speaking practitioners the problem is compounded: the methodological vocabulary of impact assessment exists almost exclusively in English, and assessment teams working on dams, canals, and water-supply projects in the region must either work in a second language or maintain private, unreviewable translations.

WIA addresses this gap. It packages a defensible, transparent screening method -- a Leopold-matrix parameterisation [@leopold1971] extended with within-dimension weighting following multi-criteria decision-analysis practice [@saaty1980] -- into a mobile application that a field assessor can use without connectivity, accounts, or licences. The 38-criterion catalogue operationalises the topics that the international frameworks treat as binding: land acquisition and livelihood restoration (IFC PS 5), indigenous peoples (PS 7), cultural heritage (PS 8), biodiversity and critical habitat (PS 6, with the IUCN Red List [@iucn2012]), wetlands (Ramsar [@ramsar1994]), community health and safety, gender and social equity, and the human right to water [@unga2010], among others. The recommendation engine ties every finding to the corresponding framework clause, so a screening output can be traced to the standards that lenders audit against. FAO guidance on the assessment of irrigation and drainage projects [@fao1995] and disaster-risk considerations under the Sendai Framework [@unisdr2015] are likewise reflected in the catalogue and its recommended actions. To our knowledge, no maintained open-source tool combines a bilingual (Arabic/English) interface, a criteria-based Leopold-type scoring engine, and framework-mapped mitigation recommendations for water infrastructure. WIA is intended for ESIA practitioners and reviewers, water-resources planners in water-scarce regions, and instructors who need a teachable, inspectable implementation of impact-assessment methodology.

# References
