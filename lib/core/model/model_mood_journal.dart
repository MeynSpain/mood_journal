import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;

part 'model_mood_journal.g.dart';
// part 'model_mood_journal.g.view.dart';

const tableFeelings = SqfEntityTable(
    modelName: 'feelings',
    tableName: 'feelings',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('filePath', DbType.text),
    ]);

const tableTags = SqfEntityTable(
    modelName: 'tags',
    tableName: 'tags',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    fields: [
      SqfEntityField('name', DbType.text),
    ]);

const tableJournal = SqfEntityTable(
    modelName: 'journal',
    tableName: 'journal',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    fields: [
      SqfEntityField('date', DbType.datetime),
      SqfEntityFieldRelationship(
          parentTable: tableFeelings,
          relationType: RelationType.ONE_TO_MANY,
          deleteRule: DeleteRule.CASCADE,
          fieldName: 'id_feeling'),
      SqfEntityField('idTags', DbType.text),
      // попробую хранить список тегов в виде строки '1,2,3,4,5'
      SqfEntityField('stressLevel', DbType.integer),
      SqfEntityField('selfAssessment', DbType.integer),
      SqfEntityField('note', DbType.text),
    ]);
const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'modelMoodJournal',
  databaseName: 'moodJournal.db',
  sequences: [seqIdentity],
  databaseTables: [tableFeelings, tableTags, tableJournal],
);
