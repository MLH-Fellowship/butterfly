import graphene
from .queries import Query
from .mutations import Mutation

schema = graphene.Schema(query=Query, mutation=Mutation)
GRAPHENE = {
    'SCHEMA':'auth.schema.schema'
}