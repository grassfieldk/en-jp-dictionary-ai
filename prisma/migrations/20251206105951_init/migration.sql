-- CreateTable
CREATE TABLE "Word" (
    "id" SERIAL NOT NULL,
    "headword" TEXT NOT NULL,
    "pronunciation" TEXT,
    "pos" TEXT NOT NULL,
    "definition" TEXT NOT NULL,
    "past" TEXT,
    "past_participle" TEXT,
    "present_participle" TEXT,
    "third_person_singular" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Word_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Example" (
    "id" SERIAL NOT NULL,
    "word_id" INTEGER NOT NULL,
    "slot" INTEGER NOT NULL,
    "sentence_en" TEXT NOT NULL,
    "sentence_ja" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Example_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SynonymGroup" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "SynonymGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SynonymGroupEntry" (
    "id" SERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "word" TEXT NOT NULL,
    "pos" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "sentence_en" TEXT NOT NULL,
    "sentence_ja" TEXT NOT NULL,
    "order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "SynonymGroupEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AntonymGroup" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "AntonymGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AntonymGroupEntry" (
    "id" SERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "word" TEXT NOT NULL,
    "pos" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "sentence_en" TEXT NOT NULL,
    "sentence_ja" TEXT NOT NULL,
    "order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "AntonymGroupEntry_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Word_headword_idx" ON "Word"("headword");

-- CreateIndex
CREATE INDEX "Word_pos_idx" ON "Word"("pos");

-- CreateIndex
CREATE UNIQUE INDEX "Word_headword_pos_key" ON "Word"("headword", "pos");

-- CreateIndex
CREATE INDEX "Example_word_id_idx" ON "Example"("word_id");

-- CreateIndex
CREATE INDEX "Example_slot_idx" ON "Example"("slot");

-- CreateIndex
CREATE INDEX "SynonymGroup_title_idx" ON "SynonymGroup"("title");

-- CreateIndex
CREATE INDEX "SynonymGroupEntry_group_id_idx" ON "SynonymGroupEntry"("group_id");

-- CreateIndex
CREATE INDEX "SynonymGroupEntry_word_idx" ON "SynonymGroupEntry"("word");

-- CreateIndex
CREATE INDEX "SynonymGroupEntry_pos_idx" ON "SynonymGroupEntry"("pos");

-- CreateIndex
CREATE UNIQUE INDEX "SynonymGroupEntry_group_id_word_pos_key" ON "SynonymGroupEntry"("group_id", "word", "pos");

-- CreateIndex
CREATE INDEX "AntonymGroup_title_idx" ON "AntonymGroup"("title");

-- CreateIndex
CREATE INDEX "AntonymGroupEntry_group_id_idx" ON "AntonymGroupEntry"("group_id");

-- CreateIndex
CREATE INDEX "AntonymGroupEntry_word_idx" ON "AntonymGroupEntry"("word");

-- CreateIndex
CREATE INDEX "AntonymGroupEntry_pos_idx" ON "AntonymGroupEntry"("pos");

-- CreateIndex
CREATE UNIQUE INDEX "AntonymGroupEntry_group_id_word_pos_key" ON "AntonymGroupEntry"("group_id", "word", "pos");

-- AddForeignKey
ALTER TABLE "Example" ADD CONSTRAINT "Example_word_id_fkey" FOREIGN KEY ("word_id") REFERENCES "Word"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SynonymGroupEntry" ADD CONSTRAINT "SynonymGroupEntry_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "SynonymGroup"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AntonymGroupEntry" ADD CONSTRAINT "AntonymGroupEntry_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "AntonymGroup"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
