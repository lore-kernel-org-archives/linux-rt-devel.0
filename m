Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB111D88D7
	for <linux-rt-devel@lists.linux.dev>; Sun, 21 Jun 2026 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782014331; cv=none; b=IUlLngnmcPGHu/Uulfbwg47+PiNxsKl46RirFwz6SX8xuQv0GAASks/WdOVQ/r+AAb3GxeyGyqRIAPAo3FjMt2qNrazbGlf9xYbooBF7RnNgXF7TIBIlmSsdYChVvG6KjKdl2G531Uo041dNMaCfGSN6BCUNX4A9l6w4SQ36yE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782014331; c=relaxed/simple;
	bh=ctnRA6DHzbZHlAqFhwDUAPXv7N7D83/7Hrsc1NekOXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjop5w240h5CD99/GeaDfN+2thH5umPd6Ac7p244S4pea7ExwPZ1j3hCz/dkhw0mFdFOMdur/4zVgFx+NrGu09ej5edDpmkZz5YUku+2xUWMRrCB6ADFq0tJtD6AAa3HEK70iXk4dS70cmbdDwTm2tR+wd0XP1PIqQpT8wPI9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSjx4y/o; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSjx4y/o"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c892a0ef503so2092353a12.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 20 Jun 2026 20:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782014329; x=1782619129; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0Q4eg41+vg2TbR9wLvOGlzYj44EGnvOGM8tMyhvy2A=;
        b=SSjx4y/oqvGhLtI3sdCXlVzX3jo+5tAwL7823K2yDRcvb4m0YiE/h2+w6CqdC5tZPK
         hcPbvqTl9y2lls8eWgz0oOGuM3A1ynJoJWUk506tvsHcz1ANTZozRyVUFshFlD9Bx90G
         zgjYJZIKWGXHzYbHDkLXo21PZ/Zeief7dVXYneIOv8OR3ErNx7H4daYOEw/+AWoygg0X
         tmCqHTlWja8EmQkpCL0k7H1aKq+fWBGrid6m3UVouxjsSMEpIC/ZjK173WiNyKiglU9d
         Jxb4OltvIRsDxbe5oxiVQUZV77ASF3+H5NgDXVJt4ekMV3BGV5wau3KfUJ9BCgSryH8g
         B6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782014329; x=1782619129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Q4eg41+vg2TbR9wLvOGlzYj44EGnvOGM8tMyhvy2A=;
        b=JwdPCMiW0pqudmzRi1/xryPlFqIEVCdTBQ8LLB3bpqb1BHcDAosILdySUCe/bsKtE/
         6gpvmar8LKcUvsLCdgPl6qOBVPHyWjQNE3oPAJ6ZUaC7keGVCdfqJysxh/+GHFrnB26B
         u/JesivAY75kj4AzsunXkz1phfEUMAe6t9PZ7sJWCWSiOC3Z89dIneDycZ2Qtq3oLHpp
         NvXXAbiV3sY0E2k6OUaLfHLjyrkiJ1o7QtyhxE+lHfBIQ3/LFm7RiWsTcmFucUdrSJoq
         o8zKGChv4WRN5RsPES01Vz9+dypPTUJh8QydzhreEtwJK0BcAPYLPjbMYM/RBSSm5wSc
         D/dg==
X-Forwarded-Encrypted: i=1; AFNElJ/MN3m8p/IPKkJfd3EKumz4l1jkLAZ8zr1LtEm0gXcoNqciE/2BmysTdvunGydpYizL4kg4iv+keJcF+9w5Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz24UVZRav+Hffvf0qpgLRGACFICAawMzwItkrRRUoabUgKBKJC
	K7blNlgWhzsxls4pU/1fagB6a3/ZhCtCjbDAdaNwA+j9WzNoz2s1itdN
X-Gm-Gg: AfdE7cmJCjDbzIh0FojV6rj8jdYBDXUpr0mvb+udY+8M4laPCsR+8lPU74qdHO8dn2r
	Lcc46Sax/ECPAnZL71ynLdkrf9H2m3Rq+SYHrfJJOlwKmU7uSy0oaxxI9+vEQpwY9uZE4P5OxsA
	LdfA1i46d4JhBVvOnNw2wsKZCY+PkeIcfj8fG7SrG8QDKMLlSBTknY2xkWHhBwyihzL+wFRC/Ty
	byQoB/0a5vferrjYtWQliTPYxUz7/D1iybFZ8fmObl1ZjnG5CFR6xbAd+LFI+ekxPiBJUGpK5gQ
	Gg4B1Y4F+U2duzKoxojVte4bi+t78frnUU3jsXTtyMGwqkbTW7f7Aiutcl6XPpI9NP9yZl027Be
	1KK168whQhhldTqEHlryvpZ7laoTnBgh2AqAosMqChyF65nUdHR/GXlJTjsNChvuTf6dpYessxb
	QWX2UmJvSmnQY4Z0n0fVo30uT6I6WSbohAmk/I9niycn59KySrDRz15HyMAakQMStDgWYX
X-Received: by 2002:a05:6a21:778d:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3bc5284561fmr4583924637.21.1782014329424;
        Sat, 20 Jun 2026 20:58:49 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:6622:5068:7fd9:7931])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc31728edsm3391858a12.11.2026.06.20.20.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:58:48 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+6a680377e13041c19d50@syzkaller.appspotmail.com
Subject: [PATCH] udf: avoid recursive s_alloc_mutex deadlock when freeing AED blocks
Date: Sun, 21 Jun 2026 09:28:41 +0530
Message-ID: <20260621035841.56194-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udf_table_prealloc_blocks() and udf_table_new_block() call
udf_delete_aext() on the unallocated-space-table inode while holding
sbi->s_alloc_mutex. When the deleted allocation descriptor empties an
allocation-extent (AED) block, udf_delete_aext() returns that block to
free space via udf_free_blocks(). For a table-managed partition that
path is udf_free_blocks() -> udf_table_free_blocks() ->
mutex_lock(&sbi->s_alloc_mutex), i.e. the task tries to acquire a mutex
it already holds.

On a PREEMPT_RT kernel the rtmutex deadlock detector reports this as
-EDEADLK:

  rtmutex deadlock detected
  WARNING: kernel/locking/rtmutex.c:1698 at rt_mutex_handle_deadlock
  udf_table_free_blocks fs/udf/balloc.c:376 [inline]
  udf_free_blocks+0xa8c/0x1900 fs/udf/balloc.c:678
  udf_delete_aext+0x4f5/0xc00 fs/udf/inode.c:2381
  udf_table_prealloc_blocks fs/udf/balloc.c:544 [inline]
  udf_prealloc_blocks+0xbd4/0x10e0 fs/udf/balloc.c:702

On a non-RT kernel the same path is a hard self-deadlock (or a lockdep
recursive-locking splat). It is reachable from a crafted UDF image via
the write/sendfile path.

The allocator already refuses to recurse on the add side: see the
comment in udf_table_free_blocks() explaining why it must not call
udf_add_aext() while holding s_alloc_mutex. Apply the same rule to the
delete side. Let udf_delete_aext() report the AED block it would
otherwise free through a new out-parameter, and have the two callers
that hold s_alloc_mutex free it after dropping the lock. The block is
already unlinked from the inode's descriptor chain by then, so nothing
can reference it in the meantime. All other callers pass NULL and keep
freeing the block inline, exactly as before.

The out-parameter is pre-initialised with the reserved partition number
0xFFFF, which can never name a real block, so the caller can tell
whether a block was handed back.

Reported-by: syzbot+6a680377e13041c19d50@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a680377e13041c19d50
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/udf/balloc.c   | 12 ++++++++++--
 fs/udf/inode.c    | 19 ++++++++++++++++---
 fs/udf/truncate.c |  2 +-
 fs/udf/udfdecl.h  |  3 ++-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index cc6dc6e1d84d..30cec5600149 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -502,6 +502,8 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo;
 	int ret = 0;
+	/* AED block freed by udf_delete_aext(), released after unlock */
+	struct kernel_lb_addr freed = { .partitionReferenceNum = 0xFFFF };
 
 	if (first_block >= sbi->s_partmaps[partition].s_partition_len)
 		return 0;
@@ -541,7 +543,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 			udf_write_aext(table, &epos, &eloc,
 					(etype << 30) | elen, 1);
 		} else
-			udf_delete_aext(table, epos);
+			udf_delete_aext(table, epos, &freed);
 	} else {
 		alloc_count = 0;
 	}
@@ -552,6 +554,8 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 	if (alloc_count)
 		udf_add_free_space(sb, partition, -alloc_count);
 	mutex_unlock(&sbi->s_alloc_mutex);
+	if (freed.partitionReferenceNum != 0xFFFF)
+		udf_free_blocks(sb, table, &freed, 0, 1);
 	return alloc_count;
 }
 
@@ -560,6 +564,8 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 			       uint32_t goal, int *err)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
+	/* AED block freed by udf_delete_aext(), released after unlock */
+	struct kernel_lb_addr freed = { .partitionReferenceNum = 0xFFFF };
 	uint32_t spread = 0xFFFFFFFF, nspread = 0xFFFFFFFF;
 	udf_pblk_t newblock = 0;
 	uint32_t adsize;
@@ -643,12 +649,14 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	if (goal_elen)
 		udf_write_aext(table, &goal_epos, &goal_eloc, goal_elen, 1);
 	else
-		udf_delete_aext(table, goal_epos);
+		udf_delete_aext(table, goal_epos, &freed);
 	brelse(goal_epos.bh);
 
 	udf_add_free_space(sb, partition, -1);
 
 	mutex_unlock(&sbi->s_alloc_mutex);
+	if (freed.partitionReferenceNum != 0xFFFF)
+		udf_free_blocks(sb, table, &freed, 0, 1);
 	*err = 0;
 	return newblock;
 }
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 67bcf83758c8..ebb67ce0aed7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1204,7 +1204,7 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 
 	if (startnum > endnum) {
 		for (i = 0; i < (startnum - endnum); i++)
-			udf_delete_aext(inode, *epos);
+			udf_delete_aext(inode, *epos, NULL);
 	} else if (startnum < endnum) {
 		for (i = 0; i < (endnum - startnum); i++) {
 			err = udf_insert_aext(inode, *epos,
@@ -2328,7 +2328,8 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
 	return ret;
 }
 
-int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
+int8_t udf_delete_aext(struct inode *inode, struct extent_position epos,
+			struct kernel_lb_addr *freed)
 {
 	struct extent_position oepos;
 	int adsize;
@@ -2378,7 +2379,19 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
 	elen = 0;
 
 	if (epos.bh != oepos.bh) {
-		udf_free_blocks(inode->i_sb, inode, &epos.block, 0, 1);
+		/*
+		 * The block that held the now-empty allocation extent must be
+		 * returned to free space.  When the caller already holds
+		 * s_alloc_mutex (the space-table allocator in balloc.c),
+		 * freeing it inline would recurse through udf_free_blocks()
+		 * into udf_table_free_blocks() and deadlock re-acquiring
+		 * s_alloc_mutex.  In that case report the block to the caller,
+		 *  which frees it after dropping the lock.
+		 */
+		if (freed)
+			*freed = epos.block;
+		else
+			udf_free_blocks(inode->i_sb, inode, &epos.block, 0, 1);
 		udf_write_aext(inode, &oepos, &eloc, elen, 1);
 		udf_write_aext(inode, &oepos, &eloc, elen, 1);
 		if (!oepos.bh) {
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 41b2bfd30449..0990f94b8551 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -159,7 +159,7 @@ void udf_discard_prealloc(struct inode *inode)
 
 	if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
 		lbcount -= elen;
-		udf_delete_aext(inode, prev_epos);
+		udf_delete_aext(inode, prev_epos, NULL);
 		udf_free_blocks(inode->i_sb, inode, &eloc, 0,
 				DIV_ROUND_UP(elen, bsize));
 	}
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 6d951e05c004..01e4ce8644a9 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -170,7 +170,8 @@ extern int udf_add_aext(struct inode *, struct extent_position *,
 			struct kernel_lb_addr *, uint32_t, int);
 extern void udf_write_aext(struct inode *, struct extent_position *,
 			   struct kernel_lb_addr *, uint32_t, int);
-extern int8_t udf_delete_aext(struct inode *, struct extent_position);
+extern int8_t udf_delete_aext(struct inode *, struct extent_position,
+			       struct kernel_lb_addr *);
 extern int udf_next_aext(struct inode *inode, struct extent_position *epos,
 			 struct kernel_lb_addr *eloc, uint32_t *elen,
 			 int8_t *etype, int inc);
-- 
2.43.0

