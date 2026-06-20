Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18980282F13
	for <linux-rt-devel@lists.linux.dev>; Sat, 20 Jun 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781942893; cv=none; b=esARNMhsE02E3QIvCN0vwFm8n+nhYsXxEUJQuZS3Mj4lZNjGq+PRhPAjGWNtWBNPqYkMrft82B5IZAXb6kYJ6FHvdjKUXnRp6kNwNXnI7EySI130rFKAnk1rnrUs0VWJfIWaAHAdTeNuzKtMwQDWJTTrAHlf52BnGOb0CSjEALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781942893; c=relaxed/simple;
	bh=FOpcInINzw4XPbBoGi4J58sS2g+vZXvj8hCcYgKtbMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kek/sulZKrhHnAFUg+VBvP8W2cA+Vluwk1JrP3cXtjcbMq0JnNM7kvytc1uQbL98VprtnWLhVx/34IlRD33cLevXcheXvRv/dtodlu/Pcgvm3/5ii0jTnjjEUDDDQQEkjSHzu0a5Y9SG8oQwv0B+o/c/CNtuXSAEX84DX34dOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlZ3fAtx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlZ3fAtx"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c40397e3caso26768915ad.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 20 Jun 2026 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781942891; x=1782547691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdUgGvYnRcqvguggKkm/S0BjkMkoo0yQksIvEARF5z8=;
        b=LlZ3fAtxYmwY4glYFDVPdrdp64kxUoCqGrX7QO3yuboQRj65l/2jKqcX2vZSXVUkMl
         0Xop7V9Lxs9tRqt4INFEE9VmuYpxBEc2soTrmv+fFmoFhkcLogyj6Yoz196ke5Un/aSK
         w8Nr8xiJWAHyl36nJktr8dMx/zHLpuCQn9ycWqvGUHqWHxuN2iKnZMk1huAMsW06dnl0
         qw1Pp+RWLvFHIUCUfGTxYlDK9za2PBKMcqZzXp0zALzGJsg28Z511pq8DC4TFWNRurhC
         fXxw7RL2uczoZiVrsXuk0t+5k3OFmWdgU/K6ojmEToOrbcQg33OHGSfm8Broh4PkqtM5
         ChYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781942891; x=1782547691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdUgGvYnRcqvguggKkm/S0BjkMkoo0yQksIvEARF5z8=;
        b=nsP4jj8Q7pBO/0jBFwL2PaL0EDmo4FmrPCmUojJm9A08xLB7hYOsLrN9B3KbH5c/bJ
         4kqbSVMHL2It45zxN3Zlbtlr3ZlIak/8aE6b5rH9k2R+LrZuLO7eV3SCl5WSll2jzn1f
         2WFZky6AOW+1mCFpEpSxB6wtlp1LNjVvPK/KQUaEeDiy5Ji6cDrosJIxheeOS72FpdcJ
         1cmHpdTJtpUoe12y/ram4PULjI5+f9K7pAfJS8Wg/XoFdWDa+352kM4Y0+NnytweHcyo
         6I7+OwK3UBn/cvZ7tPZ1k5Wgt8fAhA+uQ6JoQgJd1dOcK3dRWtXO1uJYd92aPRvgHRDr
         /8nA==
X-Forwarded-Encrypted: i=1; AFNElJ8AxmU5nJO4GKageuoufW6zaSiToMJ/Wh1K7j+ITdwioEXArvspNgSzwIyi3sAzIDyUvcWOqGFhDDitVUI2qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ3cqSfn9psFzjD8pjeAgkUGeR8kG/tP2r53WP738d+gELMpaw
	3u+TsckL7Gn3olXTHqFjSpXEMGyKvqD92jl9OGyyeEp4dqNke2OAILHq
X-Gm-Gg: AfdE7ck9ZVzNXejdIlU7P5yLWi9yPS4D/GT/ImWIpUX8DFbvDyLeYqaebwKiml9Y7FR
	Ebo0G5ZIjcrceZPPSaw/AAJOWkiIhbPb5FbVPsjyuQfxR3rx+aqo0vBmORMR7OLn1LIidnlCfHp
	mOvqykeTaZzKKoNV/+tirk1XiBslmUpEwKHrJ+7Yyus1LFOvFo/aWTWlk0hcZAqiAfvulQ7gp3Z
	dHCt0l7DFc0H/Pdt7a1AGfrilXTJnTWQnAVD2NyqIjbp8dSZIxZP8pgFO9U4pCRg82hOHX5JKoa
	2VohHschgbv2J7+9ANw7QRoAgeonqiFMOjJmCKbx/uDgFFV4cIRtB/U4tl7sewuZ/M8fC4fivGW
	JUgdoyJ4iV7R59RByUvsxeVjXZ3M24EawCiD8Mp8i1inTJDSy9ap/I6bB7HybW5midrsCDxkN5I
	aLwpnZxisqPDDTnTlCYjA/u2ldwxI8NIFORbzHGZGGrC5WtvkexxgYqfRlVXIjRNaQq5Y0
X-Received: by 2002:a17:903:41d2:b0:2c0:e5ee:f554 with SMTP id d9443c01a7336-2c725ba5ed2mr62446845ad.8.1781942891199;
        Sat, 20 Jun 2026 01:08:11 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:6622:5068:7fd9:7931])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444a9c4fsm15219195ad.75.2026.06.20.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 01:08:10 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+ce129763ce7d7e914739@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: fix deadlock in dio write orphan cleanup path
Date: Sat, 20 Jun 2026 13:38:02 +0530
Message-ID: <20260620080802.35165-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PREEMPT_RT's rtmutex PI chain walker detected a lock dependency
cycle in a single thread:

  ocfs2_file_write_iter()
    inode_lock(file_inode)             [Lock A]
      ocfs2_dio_end_io_write()
        ocfs2_inode_lock()             [Lock B]
          ocfs2_del_inode_from_orphan()
            inode_lock(orphan_dir)     [Lock D] <- cycle detected!

The problem is lock ordering. Lock B is held when Lock D is
acquired. Recovery paths acquire these locks in a different
order creating a potential cycle in the lock dependency graph.

Fix this by releasing Lock B (ocfs2_inode_unlock + brelse(di_bh))
BEFORE calling ocfs2_del_inode_from_orphan(). Pass NULL for di_bh
to signal that ocfs2_del_inode_from_orphan() should acquire its
own fresh cluster lock and di_bh internally.

This ensures consistent lock ordering:
  Before: B held -> D acquired         (inconsistent)
  After:  B released -> B' fresh -> D  (consistent)

Reported-by: syzbot+ce129763ce7d7e914739@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ce129763ce7d7e914739
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/aops.c  | 21 +++++++++++++++------
 fs/ocfs2/namei.c | 17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 6ec198bdab12..15b059a23ebc 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2280,6 +2280,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 	handle_t *handle = NULL;
 	loff_t end = offset + bytes;
 	int ret = 0, credits = 0, batch = 0;
+	bool orphaned = false;
 
 	ocfs2_init_dealloc_ctxt(&dealloc);
 
@@ -2371,17 +2372,25 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 		ocfs2_commit_trans(osb, handle);
 unlock:
 	up_write(&oi->ip_alloc_sem);
+	/*
+	 * Release the cluster lock and di_bh BEFORE calling
+	 * ocfs2_del_inode_from_orphan(). That function will acquire
+	 * inode_lock(orphan_dir_inode) which would cause an AB-BA
+	 *  deadlock with recovery paths that hold orphan_dir lock
+	 * before acquiring the file inode lock.
+	 */
+	orphaned = (!ret && dwc->dw_orphaned);
+	ocfs2_inode_unlock(inode, 1);
+	brelse(di_bh);
+	di_bh = NULL;
 
-	/* everything looks good, let's start the cleanup */
-	if (!ret && dwc->dw_orphaned) {
+	/* everything looks good, let's start the orphan cleanup */
+	if (orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
-
-		ret = ocfs2_del_inode_from_orphan(osb, inode, di_bh, 0, 0);
+		ret = ocfs2_del_inode_from_orphan(osb, inode, NULL, 0, 0);
 		if (ret < 0)
 			mlog_errno(ret);
 	}
-	ocfs2_inode_unlock(inode, 1);
-	brelse(di_bh);
 out:
 	if (data_ac)
 		ocfs2_free_alloc_context(data_ac);
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 1277666c77cd..25bbe2a9776e 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2712,10 +2712,21 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *osb,
 {
 	struct inode *orphan_dir_inode = NULL;
 	struct buffer_head *orphan_dir_bh = NULL;
-	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
+	struct ocfs2_dinode *di;
 	handle_t *handle = NULL;
 	int status = 0;
+	struct buffer_head *local_di_bh = NULL;
 
+	if (!di_bh) {
+		status = ocfs2_inode_lock(inode, &local_di_bh, 1);
+		if (status < 0) {
+			mlog_errno(status);
+			return status;
+		}
+		di_bh = local_di_bh;
+	}
+
+	di = (struct ocfs2_dinode *)di_bh->b_data;
 	orphan_dir_inode = ocfs2_get_system_file_inode(osb,
 			ORPHAN_DIR_SYSTEM_INODE,
 			le16_to_cpu(di->i_dio_orphaned_slot));
@@ -2779,6 +2790,10 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *osb,
 	iput(orphan_dir_inode);
 
 bail:
+	if (local_di_bh) {
+		ocfs2_inode_unlock(inode, 1);
+		brelse(local_di_bh);
+	}
 	return status;
 }
 
-- 
2.43.0

