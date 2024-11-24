using { riskmanagement as rm } from '../db/schema';

@path: 'service/risk'
service RiskService @(requires: 'authenticated-user') {

    // Risks entity with restricted access
    entity Risks @(restrict: [
        { grant: 'READ', to: 'RiskViewer' },
        { grant: ['READ', 'WRITE', 'UPDATE', 'UPSERT', 'DELETE'], // Allowing CDS events by explicitly mentioning them
          to: 'RiskManager' }
    ]) as projection on rm.Risks;

    // Enable draft support for the Risks entity
    annotate Risks with @odata.draft.enabled;

    // Mitigations entity with restricted access
    entity Mitigations @(restrict: [
        { grant: 'READ', to: 'RiskViewer' },
        { grant: '*', // Allow everything using wildcard
          to: 'RiskManager' }
    ]) as projection on rm.Mitigations;

    // Enable draft support for the Mitigations entity
    annotate Mitigations with @odata.draft.enabled;

    // BusinessPartners entity (readonly access)
    @readonly
    entity BusinessPartners as projection on rm.BusinessPartners;
}