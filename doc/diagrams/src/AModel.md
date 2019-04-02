```plantuml
@startuml Model

package model {
    abstract class AModel {
        --fields--
        - Firestore _firestore
        - Map<String, Tuple2<FBStreaWrapper, StreamSubscription<QuerySnapshot> > _streamWrappers
        - Strings[] _collections
        -- methods --
        - bool _assertCollection(String collection)
        + FBStreamWrapper createStreamWrapper(String collection, ...)
        + void deleteDocument(String collection, DocumentReference documentRef, String documentId)
        + Payload createPayload(String collection)
        + void pushPayload(String collection, Payload payload, String documentId)
        -- getters --
        + StreamWrappers()
        + Collections()
    }
}

@enduml
```