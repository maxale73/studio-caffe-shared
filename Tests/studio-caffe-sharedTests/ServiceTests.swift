import Foundation
import Testing
import studio_caffe_shared

struct ServiceTests {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    @Test(arguments: ServiceOperationType.allCases)
    func serviceRoundTripPreservesOperationAndParts(_ operationType: ServiceOperationType) throws {
        let catalog = ServiceCatalogDTO(id: UUID(), serviceDescription: "Gruppo espresso")
        let part = ServicePartDTO(id: UUID(), product: ProductID(id: UUID(), productDescription: "Guarnizione"), quantity: 2)
        let service = ServiceDTO(id: UUID(), machineID: UUID(), catalog: catalog, operationType: operationType,
                                 serviceDate: Date(timeIntervalSince1970: 1_000), counter: 42_150, userID: UUID(),
                                 recordedAt: Date(timeIntervalSince1970: 2_000), note: "Controllo tenuta", parts: [part])
        let page = ServicePageDTO(items: [service], page: 1, per: 50, total: 1)
        let data = try JSONEncoder.scEncoder.encode(page)
        let decoded = try decoder.decode(ServicePageDTO.self, from: data)
        #expect(decoded == page)
    }

    @Test func optionalCounterAndNoteRemainAbsent() throws {
        let service = ServiceToSave(id: UUID(), machineID: UUID(), catalogID: UUID(), operationType: .riparazione,
                                    serviceDate: Date(timeIntervalSince1970: 0), counter: nil)
        let data = try #require(service.toJSONData())
        let decoded = try decoder.decode(ServiceToSave.self, from: data)
        #expect(decoded == service)
        #expect(decoded.counter == nil)
        #expect(decoded.note == nil)
        #expect(decoded.parts.isEmpty)
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(ServiceOperationType.self, from: Data("\"invalid\"".utf8))
        }
    }

    @Test func endpointsShareRoutesAndRequestBodies() throws {
        let machineID = UUID()
        let filter = ServiceHistoryFilter(page: 2, per: 10, catalogID: UUID(), operationType: .lavaggio)
        let endpoint = ServiceEndpointsGroup.fetchByMachine(machineID: machineID, filter: filter)
        #expect(endpoint.group == "service")
        #expect(endpoint.clientRoute == "service/fetch_by_machine/\(machineID.uuidString)/")
        #expect(endpoint.serverRoute == ["fetch_by_machine", ":machine_id"])
        #expect(endpoint.httpMethod == .post)
        #expect(endpoint.requiresToken)
        #expect(!endpoint.allowsCaching)
        let body = try #require(endpoint.body?.toJSONData())
        #expect(try decoder.decode(ServiceHistoryFilter.self, from: body) == filter)
        #expect(ServiceCatalogEndpointsGroup.index().serverRoute == ["index"])
        #expect(ServiceCatalogEndpointsGroup.save().group == "service_catalog")
    }
}
