```
@Language.factory("ijoinentity")
class EntityRetokenizeComponent:
    def __init__(self, nlp:Language, name:str):
        pass
    def __call__(self, doc):
        new_ents = []
        if len(doc)>1:
            for index, ent in enumerate(doc.ents):
                span = doc.ents[index]
                pre_span =doc.ents[index-1]
                if span.start-pre_span.end==0 and span.label_==pre_span.label_:
                    new_ent = Span(doc, pre_span.start, span.end, label=span.label_)
                    new_ents.append(new_ent)
                else:
                    new_ents.append(ent)
            doc.ents =filter_spans(new_ents+ list(doc.ents))
        return doc
        ```
