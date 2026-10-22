Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637249;
	b=YjhR4kAwO7rgvkPMsjI+LNjEHlqa/3gxWdVlkfWg2mIz6i4QmlVCsAaobjP9gSe++nJT
	 2BOCeH+53WXuElo+MJTNZKxjgcGV7HIIXZ8svR/+4cFtfXAuDIDPVyS3NNDH2VHk90Ca+
	 9KkFnTjYGQPOzZPp9mStM4Qu0X8makGcl+xVN0jo7DNjMsxFbOGLCZNGUwxCYzY/bqeTA
	 gXd5nk+5USfXvNTLrkrc7OsiZ1vm1ynLpzmp80HOKL7GwkSt7HDzmQQiNi5GfJonk4p6K
	 mILy9B5eDYA6SWdz5Wi3sSbHN27snwQwPBHFRMpSyujQ8NuOhe7LlKXXOxlhrtFduDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sK0dOBM6rA/LZfP3dHlReQ82CB4hBzjV2Z+ZyVoTIlg=;
	b=AfBc8LlZrSjRyWbojh7e5AZTnwhYNjj35nikpmZIrfBHYlwucF82sn9qP+xGS0v0e28P
	 O+G9EH+XwDQLka64p4FZun9mMd2ZEZyD+8P2WZhwOwwWZjqt823BLOblWxn3xnEG/qSiB
	 ZNE5rSbC+Y+45cdStenGgBealaUsOMFVRU2cEiogOJHvNtwz0boCrE1Ry9t0CoshIMTrm
	 CYVoKPD77yAOp9HUOY9A56ZAzhDibcmQkpXd89alRseIKn8DUEm2QxZDQjW4INzC26s4y
	 K7YgUezWpvF75QxaAOmCDbUQtTxRL7AUFY5PyZR1wgly18cBIK9+qZN0IkNJZlgkbcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JfG0tadj;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FC606A335
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 02:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2FC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JfG0tadj
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36681e85e87so2891232eec.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 19:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637247; x=1793242047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sK0dOBM6rA/LZfP3dHlReQ82CB4hBzjV2Z+ZyVoTIlg=;
        b=JfG0tadjr6TP6JuWhmuTuOllAZ9hiauK3eLtT1h0KA4ttMs4DaYktySVd4wxKLU5ld
         cYpIgz10ULAB5+Dys+//JlDNwtN4vP2kpfqSTDzwkVoZJO7Hwu9IOuIpL18pAG7d0vVj
         caqASv9TEpvoKVgbxTSakgtHuHJJwlEtDxG+AH2cw802nAI6q2dI2DG+hxjYPFOzXfmo
         3b4SdL7n5VObXyOxdm2Q3wdFYHj0mZeY8qGi7ZozUFAXMeL9vud28PHV0AE/pGVfBXoX
         kiFSwTF88TlGWHokCxnYdAijivKksN37vjaUIVnfP3R2vQzK0AmcPOi0t1nycr4PW4aP
         vxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637247; x=1793242047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sK0dOBM6rA/LZfP3dHlReQ82CB4hBzjV2Z+ZyVoTIlg=;
        b=S/2Hla0r/bLNF1/OLniQKof8bim9T1smIFabtWwv0tS1J7tIgHwHmYvF+X4VVsM8jS
         oiYRe6ii6QD42SlS3/Z1mmYo3ozAtH5oP9xMbDH0aNMF1Uhk5tMqdUgzeDBs1qUgB/y2
         3PP6pjhL8YXVUf0+5+YdfENhtB/F1tHcRvHu8f53E0tncmcch1tdVPAOW0Wad0Zsv2XO
         ofjdeep4ZHqmNw5JbzV45isjJ8DYitjSC9UBrslbfmJZTn9uhVyVPTrsyDGte301fkPc
         Tsr8uZG0GWg8hA+/axTPSj61a1q2XnexHv9rVDobndB0u+BjKdO9T1wu5Y93tl3M0ZDO
         ZgRw==
X-Forwarded-Encrypted: i=1; AKwUvBwSwAc8w4r1aV/89BEbmFG4++7WBwcMkaC58UgxH8R0uG8548l1mCVRa1trW4tkVN+K6+i2OdIFm+62FU+6sw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKVJZnHVWVg+0EiJmrEoVQpts/v3jsZVncr49/RRCD3z03ewwVA
	8Tz68oNbsO0FYNIJD6yQvRARm+5lqKiXUcWc9UA9MuLA2muwjTADNK9E
X-Gm-Gg: AYBFou2YE/9xVyKcmubFvxsex9dlReO/GQPGByDZGYuAFawUtR5O9bZY6cVmhILsQZz
	+pqgQoZpJAjTHAympJkYJZ+dASUL+gn6xs9cuhASI9pyZ3s69UvHICNlZEX9xV3IMo0aDej8biB
	4K4Nx1AZe3vOQmAQJfh7VUfOIPdtz8J1PI3+HRFm2rjXjX536XqF2EiCL6Z629yDcYDQ5amcYG0
	7x0tC0lEZu/DBtwk/YCtIKBb1zKSse7ttApl5tA+xtnss38a1l8QXZsskhLsMoOK3gAo0R0C3VB
	7oc7dJsC9MbttcqAsaKe8On6ckYIigIthalE/Q1a9yrd3Y7KqREkbfxbz6MUyEU3dF7e45xGUl3
	OWVc3I/k41NOd/SA2pR93TVX6x15PhtR+yt6tY6mQhSYcwAcLOajwtF4WRnta3W4dLsYm3STGPo
	Zu5ybLjDgdKVtpcEOlabkSeoaeH1wFjEt+gQr4Rp/Q7d6QwrN3o/BgoXW44rFiH/9YUbLEFfm75
	MbQSXeVcjuIyRAYnvQSe//UlBHmT70ksmkxkxWK1kgz2zJdQulQhfKVTCZ0Z1ZkxHk9GRbNvvPX
	StdBgP67DF6JGz+7zlYbWV519PFW3ajry5/eFVohQOjckrCnj8oiq5cpmz+bymMe+BlLzK2nSz3
	PxuOqmYQ=
X-Received: by 2002:a05:693c:839a:10b0:367:5e21:ed66 with SMTP id 5a478bee46e88-3675e313010mr6253669eec.34.1792637246634;
        Wed, 21 Oct 2026 19:47:26 -0700 (PDT)
Received: from server1868-4.tail96fc24.ts.net ([199.188.91.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ca914bb8sm2318629eec.5.2026.10.21.19.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:47:26 -0700 (PDT)
From: Austin Schuh <austin.linux@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Austin Schuh <austin.linux@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [RFC PATCH 2/2] io_uring/futex: add persistent waits and registered wakes
Date: Wed, 21 Oct 2026 19:46:56 -0700
Message-ID: <20261022024701.1574811-3-austin.linux@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022024701.1574811-1-austin.linux@gmail.com>
References: <20261022024701.1574811-1-austin.linux@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every futex wait and wake takes the futex hash bucket's lock, and an
io_uring event loop arms a new one-shot wait after every wakeup.  On
PREEMPT_RT the lock sleeps, so a lower-priority task waiting or waking
on the same word, or on any word in the same bucket, can be preempted
holding it.  Priority inheritance lifts it only to the real-time
waker's priority, which loses to the interrupt threads above that on
the holder's CPU, and the real-time waker waits.

Look the futex up once and keep what the lookup found, the way io_uring
already keeps files and buffers:

 - IORING_REGISTER_FUTEX registers a table of futex words with the
   waker's ring, as IORING_REGISTER_FILES2 does files, sparse if asked;
   IORING_REGISTER_FUTEX_UPDATE replaces slots of it, as
   IORING_REGISTER_FILES_UPDATE2 does, and IORING_UNREGISTER_FUTEX drops
   it.

 - IORING_OP_FUTEX_WAIT with IORING_FUTEX_PERSISTENT arms a wait that
   stays armed until cancelled, in a slot of the ring's that
   sqe->file_index names as it does a direct descriptor's: index + 1,
   or IORING_FILE_INDEX_ALLOC for a free one, returned in res.

 - IORING_OP_FUTEX_WAKE with IORING_FUTEX_REGISTERED wakes the
   persistent waits on registered slot sqe->buf_index's word whose
   bitset matches sqe->addr3.  Each posts one CQE with
   IORING_CQE_F_MORE, and posts no more until IORING_OP_FUTEX_WAIT with
   IORING_FUTEX_REARM names its slot, as a close does; wakes in between
   are kept as one.

Wakers and waiters can be in different processes, so registering
and arming look the word up by its futex key, as futex(2) does, and
meet in one node per key.  A node outlives any one wait, unlike a
futex_q, so the nodes get a hash of their own, sized and hashed like
the futex hash, which also leaves the futex core untouched.  Only
registering, arming and teardown take its locks; registering and arming
need write access to the word, as a waker would.  A registered wake
reads the node from the ring's table, walks its waiters under RCU and
moves each with a cmpxchg, then sets the wait's bit in its ring's
pending bitmap and wakes the ring's task.  It does no key lookup, takes
no futex hash bucket and no lock that sleeps on PREEMPT_RT, and
allocates nothing.  The waker's store to the word and the waiter's link
onto the node are each followed by a full barrier, so either the wake
finds the waiter or the waiter sees the new value.

futex(2) is untouched: a persistent wait is not a futex_q, and a word
is used one way or the other.

The ring must be IORING_SETUP_DEFER_TASKRUN, and a persistent wait
can't be linked or skip its successes.  A ring has as many wait slots
as its CQ has entries, since each wait needs room for a CQE.  Nodes,
waits and tables are freed after an RCU grace period.

This depends on "io_uring: don't let a preempted task_work add hold back
the wake up": the wake skips waking the ring's task when a task_work add
has already claimed that wake up.

Measured on a Jetson Orin Nano running for-7.4/io_uring with PREEMPT_RT
and the patch above, so both rows have its fixed wake up into the ring,
and the one-shot delays are the bucket lock's.  A real-time sender on
CPU 4 wakes a real-time receiver's event loop on CPU 5 every 500us.  On
CPUs 0 and 1, lower-priority processes wake and wait on the same word,
beside SCHED_FIFO 50 threads running 20us to 1ms bursts and interrupt
load.  Ten minutes and 1.2 million messages a run:

                        sends over  late by    late by
                           100us   over 100us  over 1ms   longest
  one-shot,   FIFO 40      10285      10348        76      3.5ms
  persistent, FIFO 40          0          0         0     30.5us

A 30s stress test, a SCHED_FIFO 40 waker waking a SCHED_FIFO 40 waiter
while two more threads arm and cancel persistent waits on the same word
as fast as they can, lost none of about 259,000 wakes, worst 25.5us.

Assisted-by: LLM
Signed-off-by: Austin Schuh <austin.linux@gmail.com>
---
This is to discuss the design, not to merge as is.  It works and
passes its tests on PREEMPT_RT, but it isn't polished.  The cover
letter has the background and the other options I looked at.

Open design questions:

 - Should futex(2) and persistent waits work on the same word?  As
   posted, a word is used one way or the other: FUTEX_WAKE doesn't see
   persistent waits and a registered wake doesn't see futex(2) waiters,
   so mixing them silently loses wakeups.  Interoperating is more code,
   but fewer gotchas.

 - Should wakes be ordered by the waiters' priority?  As posted, a wake
   walks the waiters in the order they armed, newest first.  The futex
   core sorts its waiters by priority when they queue
   (__futex_queue()).

 - Persistent waits need IORING_SETUP_DEFER_TASKRUN, since their
   wakes are drained with the ring's local work.  That could be
   expanded to other rings if there's a use for it.

 include/linux/io_uring_types.h |   6 +
 include/uapi/linux/io_uring.h  |  52 ++-
 io_uring/futex.c               | 788 ++++++++++++++++++++++++++++++++-
 io_uring/futex.h               |  28 ++
 io_uring/io_uring.c            |   1 +
 io_uring/register.c            |  13 +
 io_uring/tw.c                  |  44 ++
 io_uring/tw.h                  |   4 +-
 8 files changed, 931 insertions(+), 5 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 7c5d99a8f75d..37a94c053b74 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -453,6 +453,8 @@ struct io_ring_ctx {
 		unsigned long		check_cq;
 		atomic_t		cq_wait_nr;
 		atomic_t		cq_timeouts;
+		/* persistent futex waits notified; see io_ring_futex_kick() */
+		atomic_t		futex_pending;
 		struct wait_queue_head	cq_wait;
 	} ____cacheline_aligned_in_smp;
 
@@ -473,6 +475,10 @@ struct io_ring_ctx {
 #ifdef CONFIG_FUTEX
 	struct hlist_head	futex_list;
 	struct io_alloc_cache	futex_cache;
+	/* IORING_REGISTER_FUTEX words; changes under uring_lock */
+	struct io_futex_table __rcu	*futex_table;
+	/* persistent futex waits' slots, from the first one on */
+	struct io_futex_ring	*futex_ring;
 #endif
 
 	const struct cred	*sq_creds;	/* cred used for __io_sq_thread() */
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b42b66b424a7..5de22a5cd2fd 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -137,7 +137,7 @@ struct io_uring_attr_pi {
  * direct descriptor (like openat/openat2/accept), then io_uring will allocate
  * an available direct descriptor instead of having the application pass one
  * in. The picked direct descriptor will be returned in cqe->res, or -ENFILE
- * if the space is full.
+ * if the space is full.  A persistent futex wait picks its slot the same way.
  */
 #define IORING_FILE_INDEX_ALLOC		(~0U)
 
@@ -724,6 +724,14 @@ enum io_uring_register_op {
 	/* register bpf filtering programs */
 	IORING_REGISTER_BPF_FILTER		= 37,
 
+	/*
+	 * register futex words for IORING_FUTEX_REGISTERED wakes, as
+	 * IORING_REGISTER_FILES2 and IORING_REGISTER_FILES_UPDATE2 do files
+	 */
+	IORING_REGISTER_FUTEX			= 38,
+	IORING_UNREGISTER_FUTEX			= 39,
+	IORING_REGISTER_FUTEX_UPDATE		= 40,
+
 	/* this goes last */
 	IORING_REGISTER_LAST,
 
@@ -763,6 +771,48 @@ enum {
 	IORING_MEM_REGION_REG_WAIT_ARG		= 1,
 };
 
+/*
+ * sqe->futex_flags
+ *
+ * IORING_FUTEX_PERSISTENT	IORING_OP_FUTEX_WAIT: stay armed on the word
+ *				until cancelled, in the ring's persistent wait
+ *				slot sqe->file_index names as a direct
+ *				descriptor's: index + 1, or
+ *				IORING_FILE_INDEX_ALLOC for a free one.  A
+ *				ring has as many slots as CQ entries; one in
+ *				use is -EBUSY, none free -ENFILE.  Each
+ *				wake posts one CQE with IORING_CQE_F_MORE, res
+ *				the allocated slot or 0, then the wait posts no
+ *				more until re-armed; wakes in between are kept
+ *				as one.  Only IORING_FUTEX_REGISTERED wakes
+ *				reach it, not futex(2) wakes.  Needs
+ *				IORING_SETUP_DEFER_TASKRUN; no links, no
+ *				IOSQE_CQE_SKIP_SUCCESS.
+ * IORING_FUTEX_REGISTERED	IORING_OP_FUTEX_WAKE: wake every persistent
+ *				wait on the word registered in slot
+ *				sqe->buf_index whose bitset matches sqe->addr3,
+ *				without looking up the word.  res is how many,
+ *				or -EBADF for an empty slot.
+ * IORING_FUTEX_REARM		IORING_OP_FUTEX_WAIT: re-arm the persistent
+ *				wait in the slot sqe->file_index names, index
+ *				+ 1 as for a close.
+ */
+#define IORING_FUTEX_PERSISTENT		(1U << 0)
+#define IORING_FUTEX_REGISTERED		(1U << 1)
+#define IORING_FUTEX_REARM		(1U << 2)
+
+/*
+ * A slot of IORING_REGISTER_FUTEX and IORING_REGISTER_FUTEX_UPDATE, whose
+ * struct io_uring_rsrc_register and io_uring_rsrc_update2 data point at an
+ * array of these, and whose tags must be 0.  A uaddr of 0 is an empty slot.
+ */
+struct io_uring_futex_reg {
+	__u64	uaddr;
+	__u32	futex2_flags;	/* FUTEX2_SIZE_U32, FUTEX2_PRIVATE */
+	__u32	resv;
+	__u64	resv2[2];
+};
+
 struct io_uring_mem_region_reg {
 	__u64 region_uptr; /* struct io_uring_region_desc * */
 	__u64 flags;
diff --git a/io_uring/futex.c b/io_uring/futex.c
index 9203998654ff..9f5050bfd3d4 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -4,6 +4,11 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/io_uring.h>
+#include <linux/jhash.h>
+#include <linux/nospec.h>
+#include <linux/rculist.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -12,6 +17,8 @@
 #include "alloc_cache.h"
 #include "futex.h"
 
+struct io_futex_member;
+
 struct io_futex {
 	struct file	*file;
 	void __user	*uaddr;
@@ -20,6 +27,9 @@ struct io_futex {
 	u32		futex_flags;
 	unsigned int	futex_nr;
 	bool		futexv_unqueued;
+	u8		iou_flags;	/* sqe->futex_flags */
+	/* a persistent wait's membership, NULL for every other request */
+	struct io_futex_member	*member;
 };
 
 struct io_futex_data {
@@ -82,6 +92,711 @@ static void io_futexv_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 	__io_futex_complete(tw_req, tw);
 }
 
+/*
+ * Persistent waits and registered wakes.
+ *
+ * A persistent wait and a registered waker on the same futex word meet in one
+ * io_futex_node, found by the word's futex key in a hash of io_uring's own,
+ * sized and hashed as the futex hash is, with a lock per bucket.  A bucket's
+ * nodes and their member lists change under its lock, which only arming,
+ * registering and teardown take.  Both need write access to the word, as a
+ * waker would.  A registered wake already holds the node:
+ * it walks the node's members under RCU and takes no lock and does no key
+ * lookup, so nothing a preempted low-priority waiter holds can delay it.
+ *
+ * None of this is in the futex hash.  A persistent wait is not a futex_q,
+ * futex(2) wakes don't see it, and a registered wake sees nothing else.
+ *
+ * Each member posts one CQE per arm.  Its state, changed by cmpxchg but for
+ * arming it and ending it:
+ *
+ *   ARMED	waiting; a wake moves it on			-> QUEUED
+ *   QUEUED	to be posted by the ring's task			-> FIRED
+ *   FIRED	CQE posted; a wake is remembered		-> MISSED
+ *   MISSED	re-arming moves it to QUEUED at once
+ *   DEAD	cancelled or ended; the final task work frees it
+ *
+ * Re-arming moves FIRED to ARMED and MISSED to QUEUED.
+ *
+ * Every wake that finds a member QUEUED sets the member's bit in its ring's
+ * pending bitmap and kicks the ring (io_ring_futex_kick()), not only the wake
+ * that moved it there.  Setting the bit is the whole of publishing it, one
+ * atomic, so a wake that moved it and was then preempted, a low-priority one
+ * on a busy CPU say, leaves nothing half done for later wakes, a real-time
+ * one included, to depend on.  The ring's task takes the bits when it runs
+ * its local work and posts their members, so persistent waits need
+ * IORING_SETUP_DEFER_TASKRUN.  That also keeps the ring alive for a waker
+ * still under RCU: such a ring is freed only after a grace period.
+ */
+struct io_futex_bucket {
+	spinlock_t		lock;
+	struct hlist_head	nodes;
+} ____cacheline_aligned_in_smp;
+
+struct io_futex_node {
+	struct hlist_node	hnode;		/* on bucket->nodes */
+	struct io_futex_bucket	*bucket;	/* never changes: no rehash */
+	union futex_key		key;
+	struct hlist_head	members;	/* RCU */
+	refcount_t		ref;		/* members and registrations */
+	struct rcu_head		rcu;
+};
+
+enum {
+	IO_FUTEX_ARMED,
+	IO_FUTEX_QUEUED,
+	IO_FUTEX_FIRED,
+	IO_FUTEX_MISSED,
+	IO_FUTEX_DEAD,
+};
+
+struct io_futex_member {
+	struct hlist_node	mnode;		/* on node->members */
+	struct io_futex_node	*node;
+	struct io_ring_ctx	*ctx;
+	struct io_kiocb		*req;
+	/* Its slot in ctx->futex_ring, and the ring's pending bitmap. */
+	unsigned int		slot;
+	unsigned long		*pending;
+	u32			cqe_res;	/* the slot if allocated, else 0 */
+	u32			bitset;
+	atomic_t		state;
+	int			res;		/* the final CQE's */
+	struct rcu_head		rcu;
+};
+
+/*
+ * A ring's persistent waits, for its own task.  Each has a slot, which the
+ * SQE names or has allocated as a direct descriptor's is, and which re-arm
+ * names: a wake in any task sets the slot's bit in pending[], and the ring's
+ * task posts the waits whose bits it takes.  All but pending[] change only
+ * under the ring's uring_lock.  Sized when the ring's first persistent wait
+ * arms, to its CQ, since each wait needs room for a CQE; freed with the
+ * ring, after the grace period its exit waits for, so a waker still under
+ * RCU can set a bit in it.
+ */
+struct io_futex_ring {
+	unsigned int		cap;
+	struct io_futex_member	**slots;
+	unsigned long		*used;
+	unsigned long		pending[];
+};
+
+/*
+ * A ring's registered words, as its registered files are: a table of nr
+ * slots, any of them empty, set at registration and changed slot by slot
+ * by updates.
+ */
+struct io_futex_table {
+	unsigned int		nr;
+	struct rcu_head		rcu;
+	struct io_futex_node __rcu	*nodes[] __counted_by(nr);
+};
+
+#define IO_FUTEX_REG_MAX	(1U << 16)
+
+static struct io_futex_bucket *io_futex_buckets;
+static unsigned int io_futex_hash_mask;
+
+/* As futex_init() sizes the futex hash: 256 buckets per CPU. */
+static int __init io_futex_init(void)
+{
+	unsigned long size, i;
+
+	size = 256 * num_possible_cpus();
+	size /= num_possible_nodes();
+	size = roundup_pow_of_two(max(4UL, size));
+	io_futex_buckets = kvcalloc(size, sizeof(*io_futex_buckets),
+				    GFP_KERNEL);
+	if (!io_futex_buckets)
+		panic("io_uring: no memory for the futex node hash");
+	for (i = 0; i < size; i++) {
+		spin_lock_init(&io_futex_buckets[i].lock);
+		INIT_HLIST_HEAD(&io_futex_buckets[i].nodes);
+	}
+	io_futex_hash_mask = size - 1;
+	return 0;
+}
+core_initcall(io_futex_init);
+
+static struct io_futex_bucket *io_futex_bucket(union futex_key *key)
+{
+	u32 hash = jhash2((u32 *)&key->both.ptr,
+			  (sizeof(key->both.ptr) + sizeof(key->both.word)) / 4,
+			  key->both.offset);
+
+	return &io_futex_buckets[hash & io_futex_hash_mask];
+}
+
+/*
+ * A key without FUT_OFF_INODE names its mm by pointer.  The node keeps the
+ * mm_struct allocated so the pointer can't be reused for another mm while
+ * the node can still be found by it.
+ */
+static bool io_futex_key_has_mm(union futex_key *key)
+{
+	return !(key->both.offset & FUT_OFF_INODE);
+}
+
+static struct io_futex_node *io_futex_node_get(u32 __user *uaddr,
+					       unsigned int flags)
+{
+	union futex_key key = FUTEX_KEY_INIT;
+	struct io_futex_node *node, *new = NULL;
+	struct io_futex_bucket *b;
+	int ret;
+
+	/* Write access, as a waker needs: reading the word is not enough. */
+	ret = get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
+	if (ret)
+		return ERR_PTR(ret);
+	b = io_futex_bucket(&key);
+again:
+	spin_lock(&b->lock);
+	hlist_for_each_entry(node, &b->nodes, hnode) {
+		if (futex_match(&node->key, &key)) {
+			/* A node at zero has already left the bucket. */
+			refcount_inc(&node->ref);
+			spin_unlock(&b->lock);
+			kfree(new);
+			return node;
+		}
+	}
+	if (!new) {
+		/* Allocate only on a miss, and not under the lock. */
+		spin_unlock(&b->lock);
+		new = kzalloc_obj(*new, GFP_KERNEL_ACCOUNT);
+		if (!new)
+			return ERR_PTR(-ENOMEM);
+		goto again;
+	}
+	new->key = key;
+	new->bucket = b;
+	INIT_HLIST_HEAD(&new->members);
+	refcount_set(&new->ref, 1);
+	if (io_futex_key_has_mm(&key))
+		mmgrab(key.private.mm);
+	hlist_add_head(&new->hnode, &b->nodes);
+	spin_unlock(&b->lock);
+	return new;
+}
+
+static void io_futex_node_put(struct io_futex_node *node)
+{
+	if (!refcount_dec_and_lock(&node->ref, &node->bucket->lock))
+		return;
+	hlist_del(&node->hnode);
+	spin_unlock(&node->bucket->lock);
+	if (io_futex_key_has_mm(&node->key))
+		mmdrop(node->key.private.mm);
+	/* A registered wake may still be walking it. */
+	kfree_rcu(node, rcu);
+}
+
+static void io_futex_member_unlink(struct io_futex_member *m)
+{
+	spin_lock(&m->node->bucket->lock);
+	hlist_del_rcu(&m->mnode);
+	spin_unlock(&m->node->bucket->lock);
+}
+
+/* Under uring_lock: the ring's persistent wait slots, made on first use. */
+static struct io_futex_ring *io_futex_ring_get(struct io_ring_ctx *ctx)
+{
+	struct io_futex_ring *fr = ctx->futex_ring;
+	unsigned int cap = ctx->cq_entries;
+
+	if (fr)
+		return fr;
+	fr = kvzalloc(struct_size(fr, pending, BITS_TO_LONGS(cap)),
+		      GFP_KERNEL_ACCOUNT);
+	if (!fr)
+		return NULL;
+	fr->cap = cap;
+	fr->slots = kvcalloc(cap, sizeof(*fr->slots), GFP_KERNEL_ACCOUNT);
+	fr->used = bitmap_zalloc(cap, GFP_KERNEL_ACCOUNT);
+	if (!fr->slots || !fr->used) {
+		kvfree(fr->slots);
+		bitmap_free(fr->used);
+		kvfree(fr);
+		return NULL;
+	}
+	ctx->futex_ring = fr;
+	return fr;
+}
+
+/*
+ * From any task: publish @m to its ring's task.  The bit is set before the
+ * kick's full barrier, which the ring's xchg of futex_pending pairs with, so
+ * a ring that sees the kick sees the bit.
+ */
+static void io_futex_mark_pending(struct io_futex_member *m)
+{
+	set_bit(m->slot, m->pending);
+	io_ring_futex_kick(m->ctx);
+}
+
+/*
+ * From any task, under RCU.  Returns false if @m is going away.  Allocates
+ * nothing and takes no lock.
+ */
+static bool io_futex_notify(struct io_futex_member *m)
+{
+	int state = atomic_read(&m->state);
+
+	for (;;) {
+		switch (state) {
+		case IO_FUTEX_ARMED:
+			if (!atomic_try_cmpxchg(&m->state, &state,
+						IO_FUTEX_QUEUED))
+				continue;
+			fallthrough;
+		case IO_FUTEX_QUEUED:
+			/* Whoever moved it may not have published yet: do it too. */
+			io_futex_mark_pending(m);
+			return true;
+		case IO_FUTEX_FIRED:
+			if (!atomic_try_cmpxchg(&m->state, &state,
+						IO_FUTEX_MISSED))
+				continue;
+			return true;
+		case IO_FUTEX_MISSED:
+			/* Posted by the re-arm. */
+			return true;
+		default:
+			return false;
+		}
+	}
+}
+
+/* A persistent wait's end, in its ring's task: the final CQE, then free. */
+static void io_futex_persistent_tw(struct io_tw_req tw_req, io_tw_token_t tw)
+{
+	struct io_kiocb *req = tw_req.req;
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
+	struct io_futex_member *m = iof->member;
+
+	io_tw_lock(req->ctx, tw);
+	/* No wake can reach @m once a grace period has passed. */
+	if (m->res < 0)
+		req_set_fail(req);
+	io_req_set_res(req, m->res, 0);
+	iof->member = NULL;
+	io_futex_node_put(m->node);
+	kfree_rcu(m, rcu);
+	__io_futex_complete(tw_req, tw);
+}
+
+/*
+ * Under uring_lock: takes @req off futex_list, frees its slot, and queues its
+ * end.  A bit a waker sets for the slot after this finds it empty, or a
+ * later wait that is not QUEUED, and does nothing.
+ */
+static void io_futex_persistent_end(struct io_kiocb *req, int res)
+{
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
+	struct io_futex_member *m = iof->member;
+	struct io_futex_ring *fr = req->ctx->futex_ring;
+
+	hlist_del_init(&req->hash_node);
+	fr->slots[m->slot] = NULL;
+	__clear_bit(m->slot, fr->used);
+	io_futex_member_unlink(m);
+	m->res = res;
+	atomic_set(&m->state, IO_FUTEX_DEAD);
+	io_req_task_work_add(req);
+}
+
+/*
+ * In the ring's task, from __io_run_local_work(), under uring_lock: post the
+ * waits whose bits are set.  Returns how many CQEs it posted.
+ */
+int io_futex_run_pending(struct io_ring_ctx *ctx)
+{
+	struct io_futex_ring *fr = ctx->futex_ring;
+	unsigned int w;
+	int posted = 0;
+
+	lockdep_assert_held(&ctx->uring_lock);
+	if (!fr)
+		return 0;
+	for (w = 0; w < BITS_TO_LONGS(fr->cap); w++) {
+		unsigned long bits;
+
+		if (!READ_ONCE(fr->pending[w]))
+			continue;
+		/* Take them first: a wake after this sets its bit again. */
+		bits = xchg(&fr->pending[w], 0);
+		while (bits) {
+			const unsigned int slot = w * BITS_PER_LONG + __ffs(bits);
+			struct io_futex_member *m = fr->slots[slot];
+			int state = IO_FUTEX_QUEUED;
+
+			bits &= bits - 1;
+			/* An empty slot, or a wait already posted or ended. */
+			if (!m || !atomic_try_cmpxchg(&m->state, &state,
+						      IO_FUTEX_FIRED))
+				continue;
+			if (io_req_post_cqe(m->req, m->cqe_res, IORING_CQE_F_MORE)) {
+				posted++;
+				continue;
+			}
+			/* No room for it: end the wait, as multishot requests do. */
+			io_futex_persistent_end(m->req, -EOVERFLOW);
+		}
+	}
+	return posted;
+}
+
+/* Under uring_lock. */
+static bool io_futex_persistent_cancel(struct io_kiocb *req)
+{
+	io_futex_persistent_end(req, -ECANCELED);
+	return true;
+}
+
+static int io_futex_wait_persistent(struct io_kiocb *req,
+				    unsigned int issue_flags)
+{
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_futex_member *m;
+	struct io_futex_node *node;
+	struct io_futex_ring *fr;
+	unsigned int slot;
+	u32 uval;
+	int ret;
+
+	m = kzalloc_obj(*m, GFP_KERNEL_ACCOUNT);
+	if (!m) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	node = io_futex_node_get(iof->uaddr, iof->futex_flags);
+	if (IS_ERR(node)) {
+		ret = PTR_ERR(node);
+		kfree(m);
+		goto fail;
+	}
+	m->node = node;
+	m->ctx = ctx;
+	m->req = req;
+	m->bitset = iof->futex_mask;
+	atomic_set(&m->state, IO_FUTEX_ARMED);
+	iof->member = m;
+	req->io_task_work.func = io_futex_persistent_tw;
+
+	/*
+	 * Cancellation finds it on futex_list, once it is on the node too.
+	 * uring_lock is held through the look at the word below: issued from
+	 * io-wq, nothing else would keep a cancel from freeing @m under it.
+	 */
+	io_ring_submit_lock(ctx, issue_flags);
+	fr = io_futex_ring_get(ctx);
+	if (!fr) {
+		ret = -ENOMEM;
+		goto fail_unlock;
+	}
+	/* A slot as a direct descriptor's: the one named, or any free one. */
+	if (iof->futex_nr == IORING_FILE_INDEX_ALLOC) {
+		slot = find_first_zero_bit(fr->used, fr->cap);
+		ret = -ENFILE;
+		if (slot >= fr->cap)
+			goto fail_unlock;
+		m->cqe_res = slot;
+	} else {
+		slot = iof->futex_nr - 1;
+		ret = -EINVAL;
+		if (slot >= fr->cap)
+			goto fail_unlock;
+		slot = array_index_nospec(slot, fr->cap);
+		ret = -EBUSY;
+		if (test_bit(slot, fr->used))
+			goto fail_unlock;
+	}
+	__set_bit(slot, fr->used);
+	fr->slots[slot] = m;
+	m->slot = slot;
+	m->pending = fr->pending;
+	spin_lock(&node->bucket->lock);
+	hlist_add_head_rcu(&m->mnode, &node->members);
+	spin_unlock(&node->bucket->lock);
+	hlist_add_head(&req->hash_node, &ctx->futex_list);
+	/* As for a one-shot wait: an io-wq cancel may have missed the list. */
+	if (io_wq_cancel_seen(req, issue_flags)) {
+		io_futex_persistent_end(req, -ECANCELED);
+		io_ring_submit_unlock(ctx, issue_flags);
+		return IOU_ISSUE_SKIP_COMPLETE;
+	}
+
+	/*
+	 * On the list, then look at the word: pairs with the smp_mb() in a
+	 * registered wake, between the waker's store and its walk.  Either the
+	 * wake finds us or we see its value.  A word we can't read counts as
+	 * changed, and user space finds out why.
+	 */
+	smp_mb();
+	if (get_user(uval, (u32 __user *)iof->uaddr) || uval != iof->futex_val)
+		io_futex_notify(m);
+	io_ring_submit_unlock(ctx, issue_flags);
+	return IOU_ISSUE_SKIP_COMPLETE;
+fail_unlock:
+	io_ring_submit_unlock(ctx, issue_flags);
+	iof->member = NULL;
+	io_futex_node_put(node);
+	kfree(m);
+fail:
+	req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+
+static int io_futex_member_rearm(struct io_futex_member *m)
+{
+	int state = atomic_read(&m->state);
+
+	for (;;) {
+		switch (state) {
+		case IO_FUTEX_FIRED:
+			if (!atomic_try_cmpxchg(&m->state, &state,
+						IO_FUTEX_ARMED))
+				continue;
+			return 0;
+		case IO_FUTEX_MISSED:
+			if (!atomic_try_cmpxchg(&m->state, &state,
+						IO_FUTEX_QUEUED))
+				continue;
+			io_futex_mark_pending(m);
+			return 0;
+		case IO_FUTEX_DEAD:
+			return -ENOENT;
+		default:
+			return -EBUSY;
+		}
+	}
+}
+
+static int io_futex_rearm(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_futex_ring *fr;
+	struct io_futex_member *m;
+	int ret;
+
+	/* The slot's errors are a close's by file_index. */
+	io_ring_submit_lock(ctx, issue_flags);
+	fr = ctx->futex_ring;
+	if (!fr) {
+		ret = -ENXIO;
+	} else if (iof->futex_nr >= fr->cap) {
+		ret = -EINVAL;
+	} else {
+		m = fr->slots[array_index_nospec(iof->futex_nr, fr->cap)];
+		ret = m ? io_futex_member_rearm(m) : -EBADF;
+	}
+	io_ring_submit_unlock(ctx, issue_flags);
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+
+static int io_futex_wake_registered(struct io_kiocb *req)
+{
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
+	struct io_futex_table *table;
+	struct io_futex_member *m;
+	struct io_futex_node *node;
+	unsigned int idx = iof->futex_nr;
+	int ret = 0;
+
+	/* The waker's store to the word, then the walk: pairs with arming. */
+	smp_mb();
+	rcu_read_lock();
+	table = rcu_dereference(req->ctx->futex_table);
+	node = NULL;
+	if (table && idx < table->nr)
+		node = rcu_dereference(table->nodes[array_index_nospec(idx,
+								       table->nr)]);
+	/* As for a fixed file: an empty or missing slot is -EBADF. */
+	if (unlikely(!node)) {
+		rcu_read_unlock();
+		req_set_fail(req);
+		io_req_set_res(req, -EBADF, 0);
+		return IOU_COMPLETE;
+	}
+	hlist_for_each_entry_rcu(m, &node->members, mnode)
+		if ((m->bitset & iof->futex_mask) && io_futex_notify(m))
+			ret++;
+	rcu_read_unlock();
+
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+
+static bool io_futex_reg_flags_valid(unsigned int flags)
+{
+	/* The word is found by its key; NUMA and MPOL pick a bucket. */
+	return futex_flags_valid(flags) && !(flags & (FLAGS_NUMA | FLAGS_MPOL));
+}
+
+/* A registered word, or NULL for an empty slot (uaddr 0). */
+static struct io_futex_node *
+io_futex_reg_node(struct io_uring_futex_reg __user *ureg)
+{
+	struct io_uring_futex_reg reg;
+	unsigned int flags;
+
+	if (copy_from_user(&reg, ureg, sizeof(reg)))
+		return ERR_PTR(-EFAULT);
+	if (reg.resv || reg.resv2[0] || reg.resv2[1] ||
+	    (reg.futex2_flags & ~FUTEX2_VALID_MASK))
+		return ERR_PTR(-EINVAL);
+	if (!reg.uaddr)
+		return reg.futex2_flags ? ERR_PTR(-EINVAL) : NULL;
+	flags = futex2_to_flags(reg.futex2_flags);
+	if (!io_futex_reg_flags_valid(flags))
+		return ERR_PTR(-EINVAL);
+	return io_futex_node_get(u64_to_user_ptr(reg.uaddr), flags);
+}
+
+static void __io_futex_unregister(struct io_futex_table *table)
+{
+	unsigned int i;
+
+	/* Each node is freed a grace period after its last put. */
+	/* Unpublished, or unpublished by the caller under uring_lock. */
+	for (i = 0; i < table->nr; i++) {
+		struct io_futex_node *node;
+
+		node = rcu_dereference_protected(table->nodes[i], 1);
+
+		if (node)
+			io_futex_node_put(node);
+	}
+	kvfree_rcu(table, rcu);
+}
+
+/* As IORING_REGISTER_FILES2: a table of rr.nr words, sparse if asked. */
+int io_futex_register(struct io_ring_ctx *ctx, void __user *arg,
+		      unsigned int size)
+{
+	struct io_uring_futex_reg __user *uregs;
+	struct io_uring_rsrc_register rr;
+	struct io_futex_table *table;
+	unsigned int i;
+
+	if (size != sizeof(rr))
+		return -EINVAL;
+	if (copy_from_user(&rr, arg, sizeof(rr)))
+		return -EFAULT;
+	if (!rr.nr || rr.resv2 || rr.tags ||
+	    (rr.flags & ~IORING_RSRC_REGISTER_SPARSE))
+		return -EINVAL;
+	if ((rr.flags & IORING_RSRC_REGISTER_SPARSE) && rr.data)
+		return -EINVAL;
+	if (rr.nr > IO_FUTEX_REG_MAX)
+		return -EMFILE;
+	if (rcu_access_pointer(ctx->futex_table))
+		return -EBUSY;
+
+	table = kvzalloc(struct_size(table, nodes, rr.nr), GFP_KERNEL_ACCOUNT);
+	if (!table)
+		return -ENOMEM;
+	table->nr = rr.nr;
+	uregs = u64_to_user_ptr(rr.data);
+	for (i = 0; uregs && i < rr.nr; i++) {
+		struct io_futex_node *node = io_futex_reg_node(&uregs[i]);
+
+		if (IS_ERR(node)) {
+			__io_futex_unregister(table);
+			return PTR_ERR(node);
+		}
+		RCU_INIT_POINTER(table->nodes[i], node);
+	}
+	/* Fills the slots, then publishes them: pairs with the wake. */
+	rcu_assign_pointer(ctx->futex_table, table);
+	return 0;
+}
+
+/*
+ * As IORING_REGISTER_FILES_UPDATE2: replace up.nr slots from up.offset, and
+ * clear those whose uaddr is 0.  Returns how many were updated.
+ */
+int io_futex_register_update(struct io_ring_ctx *ctx, void __user *arg,
+			     unsigned int size)
+{
+	struct io_uring_futex_reg __user *uregs;
+	struct io_uring_rsrc_update2 up;
+	struct io_futex_table *table;
+	unsigned int done, end;
+	int err = 0;
+
+	if (size != sizeof(up))
+		return -EINVAL;
+	if (copy_from_user(&up, arg, sizeof(up)))
+		return -EFAULT;
+	if (!up.nr || up.resv || up.resv2 || up.tags)
+		return -EINVAL;
+	if (check_add_overflow(up.offset, up.nr, &end))
+		return -EOVERFLOW;
+	table = rcu_dereference_protected(ctx->futex_table,
+					  lockdep_is_held(&ctx->uring_lock));
+	if (!table)
+		return -ENXIO;
+	if (end > table->nr)
+		return -EINVAL;
+
+	uregs = u64_to_user_ptr(up.data);
+	for (done = 0; done < up.nr; done++) {
+		unsigned int i = array_index_nospec(up.offset + done, table->nr);
+		struct io_futex_node *node, *old;
+
+		node = io_futex_reg_node(&uregs[done]);
+		if (IS_ERR(node)) {
+			err = PTR_ERR(node);
+			break;
+		}
+		old = rcu_replace_pointer(table->nodes[i], node,
+					  lockdep_is_held(&ctx->uring_lock));
+		/* A wake still walking it holds RCU; it is freed after. */
+		if (old)
+			io_futex_node_put(old);
+	}
+	return done ? done : err;
+}
+
+int io_futex_unregister(struct io_ring_ctx *ctx)
+{
+	struct io_futex_table *table;
+
+	table = rcu_replace_pointer(ctx->futex_table, NULL,
+				    lockdep_is_held(&ctx->uring_lock));
+	if (!table)
+		return -ENXIO;
+	__io_futex_unregister(table);
+	return 0;
+}
+
+void io_futex_unregister_all(struct io_ring_ctx *ctx)
+{
+	struct io_futex_ring *fr = ctx->futex_ring;
+
+	io_futex_unregister(ctx);
+	/*
+	 * Every persistent wait has ended, and the ring's exit has waited a
+	 * grace period since, so no waker can still set a bit.
+	 */
+	if (fr) {
+		ctx->futex_ring = NULL;
+		kvfree(fr->slots);
+		bitmap_free(fr->used);
+		kvfree(fr);
+	}
+}
+
 static bool io_futexv_claim(struct io_futexv_data *ifd)
 {
 	if (test_bit(0, &ifd->owned) || test_and_set_bit_lock(0, &ifd->owned))
@@ -91,6 +806,11 @@ static bool io_futexv_claim(struct io_futexv_data *ifd)
 
 static bool __io_futex_cancel(struct io_kiocb *req)
 {
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
+
+	if (iof->member)
+		return io_futex_persistent_cancel(req);
+
 	/* futex wake already done or in progress */
 	if (req->opcode == IORING_OP_FUTEX_WAIT) {
 		struct io_futex_data *ifd = req->async_data;
@@ -127,23 +847,69 @@ bool io_futex_remove_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
-	u32 flags;
+	u32 flags, uflags;
 
-	if (unlikely(sqe->len || sqe->futex_flags || sqe->buf_index ||
-		     sqe->file_index))
+	if (unlikely(sqe->len))
 		return -EINVAL;
 
+	uflags = READ_ONCE(sqe->futex_flags);
+	iof->iou_flags = uflags;
+	iof->member = NULL;
 	iof->uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	iof->futex_val = READ_ONCE(sqe->addr2);
 	iof->futex_mask = READ_ONCE(sqe->addr3);
 	flags = READ_ONCE(sqe->fd);
 
+	if (req->opcode == IORING_OP_FUTEX_WAIT) {
+		if (uflags & ~(IORING_FUTEX_PERSISTENT | IORING_FUTEX_REARM) ||
+		    uflags == (IORING_FUTEX_PERSISTENT | IORING_FUTEX_REARM) ||
+		    sqe->buf_index)
+			return -EINVAL;
+		/*
+		 * A persistent wait's slot, as a direct descriptor's: index + 1,
+		 * or IORING_FILE_INDEX_ALLOC.  A re-arm names the slot the same
+		 * way, as a close does.
+		 */
+		iof->futex_nr = READ_ONCE(sqe->file_index);
+		if (!(uflags & (IORING_FUTEX_PERSISTENT | IORING_FUTEX_REARM)) !=
+		    !iof->futex_nr)
+			return -EINVAL;
+		if (uflags & IORING_FUTEX_REARM) {
+			if (iof->uaddr || iof->futex_val || iof->futex_mask ||
+			    flags || iof->futex_nr == IORING_FILE_INDEX_ALLOC)
+				return -EINVAL;
+			iof->futex_nr--;
+			return 0;
+		}
+	} else if (sqe->file_index) {
+		return -EINVAL;
+	} else if (uflags) {
+		/* Woken by slot: no word, no count, only the bitset. */
+		if (uflags != IORING_FUTEX_REGISTERED || iof->uaddr ||
+		    iof->futex_val || flags || !iof->futex_mask ||
+		    iof->futex_mask > U32_MAX)
+			return -EINVAL;
+		iof->futex_nr = READ_ONCE(sqe->buf_index);
+		return 0;
+	} else if (sqe->buf_index) {
+		return -EINVAL;
+	}
+
 	if (flags & ~FUTEX2_VALID_MASK)
 		return -EINVAL;
 
 	iof->futex_flags = futex2_to_flags(flags);
 	if (!futex_flags_valid(iof->futex_flags))
 		return -EINVAL;
+	/*
+	 * Persistent: links would wait for the wait's end, and a skipped
+	 * success would be every notification.
+	 */
+	if ((uflags & IORING_FUTEX_PERSISTENT) &&
+	    (!io_futex_reg_flags_valid(iof->futex_flags) ||
+	     !(req->ctx->flags & IORING_SETUP_DEFER_TASKRUN) ||
+	     (req->flags & (REQ_F_LINK | REQ_F_HARDLINK | REQ_F_CQE_SKIP))))
+		return -EINVAL;
 
 	if (!futex_validate_input(iof->futex_flags, iof->futex_val) ||
 	    !futex_validate_input(iof->futex_flags, iof->futex_mask))
@@ -179,6 +945,12 @@ int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (unlikely(ret))
 		return ret;
 
+	/*
+	 * Persistent waits never enter the futex hash, and a re-arm doesn't
+	 * set futex_flags at all.
+	 */
+	if (iof->iou_flags & (IORING_FUTEX_PERSISTENT | IORING_FUTEX_REARM))
+		return 0;
 	if (!(iof->futex_flags & FLAGS_SHARED))
 		return io_futex_prep_private(req);
 	return 0;
@@ -214,6 +986,7 @@ int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	iof->uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	iof->member = NULL;
 	iof->futex_nr = READ_ONCE(sqe->len);
 	if (!iof->futex_nr || iof->futex_nr > FUTEX_WAITV_MAX)
 		return -EINVAL;
@@ -322,11 +1095,17 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_futex_data *ifd = NULL;
 	int ret;
 
+	if (iof->iou_flags & IORING_FUTEX_REARM)
+		return io_futex_rearm(req, issue_flags);
+
 	if (!iof->futex_mask) {
 		ret = -EINVAL;
 		goto done;
 	}
 
+	if (iof->iou_flags & IORING_FUTEX_PERSISTENT)
+		return io_futex_wait_persistent(req, issue_flags);
+
 	io_ring_submit_lock(ctx, issue_flags);
 	ifd = io_cache_alloc(&ctx->futex_cache, GFP_NOWAIT);
 	if (!ifd) {
@@ -367,6 +1146,9 @@ int io_futex_wake(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	int ret;
 
+	if (iof->iou_flags & IORING_FUTEX_REGISTERED)
+		return io_futex_wake_registered(req);
+
 	/*
 	 * Strict flags - ensure that waking 0 futexes yields a 0 result.
 	 * See commit 43adf8449510 ("futex: FLAGS_STRICT") for details.
diff --git a/io_uring/futex.h b/io_uring/futex.h
index 987db3f2c6d9..51621e572e00 100644
--- a/io_uring/futex.h
+++ b/io_uring/futex.h
@@ -16,6 +16,13 @@ bool io_futex_remove_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 			 bool cancel_all);
 bool io_futex_cache_init(struct io_ring_ctx *ctx);
 void io_futex_cache_free(struct io_ring_ctx *ctx);
+int io_futex_register(struct io_ring_ctx *ctx, void __user *arg,
+		      unsigned int size);
+int io_futex_register_update(struct io_ring_ctx *ctx, void __user *arg,
+			     unsigned int size);
+int io_futex_unregister(struct io_ring_ctx *ctx);
+void io_futex_unregister_all(struct io_ring_ctx *ctx);
+int io_futex_run_pending(struct io_ring_ctx *ctx);
 #else
 static inline int io_futex_cancel(struct io_ring_ctx *ctx,
 				  struct io_cancel_data *cd,
@@ -35,4 +42,25 @@ static inline bool io_futex_cache_init(struct io_ring_ctx *ctx)
 static inline void io_futex_cache_free(struct io_ring_ctx *ctx)
 {
 }
+static inline int io_futex_register(struct io_ring_ctx *ctx, void __user *arg,
+				    unsigned int size)
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_futex_register_update(struct io_ring_ctx *ctx,
+					   void __user *arg, unsigned int size)
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_futex_unregister(struct io_ring_ctx *ctx)
+{
+	return -EOPNOTSUPP;
+}
+static inline void io_futex_unregister_all(struct io_ring_ctx *ctx)
+{
+}
+static inline int io_futex_run_pending(struct io_ring_ctx *ctx)
+{
+	return 0;
+}
 #endif
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e6569c204917..60a39cd03016 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2260,6 +2260,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_unregister_zcrx(ctx);
 	io_cqring_overflow_kill(ctx);
 	io_eventfd_unregister(ctx);
+	io_futex_unregister_all(ctx);
 	io_free_alloc_caches(ctx);
 	io_destroy_buffers(ctx);
 	io_free_region(ctx->user, &ctx->param_region);
diff --git a/io_uring/register.c b/io_uring/register.c
index 2ce36623e25a..4e47513f5d4e 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -28,6 +28,7 @@
 #include "cancel.h"
 #include "kbuf.h"
 #include "napi.h"
+#include "futex.h"
 #include "eventfd.h"
 #include "msg_ring.h"
 #include "memmap.h"
@@ -1026,6 +1027,18 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			WRITE_ONCE(ctx->bpf_filters,
 				   ctx->restrictions.bpf_filters->filters);
 		break;
+	case IORING_REGISTER_FUTEX:
+		ret = io_futex_register(ctx, arg, nr_args);
+		break;
+	case IORING_UNREGISTER_FUTEX:
+		ret = -EINVAL;
+		if (arg || nr_args)
+			break;
+		ret = io_futex_unregister(ctx);
+		break;
+	case IORING_REGISTER_FUTEX_UPDATE:
+		ret = io_futex_register_update(ctx, arg, nr_args);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/io_uring/tw.c b/io_uring/tw.c
index cfb591508662..0a8ce6dc2354 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -15,6 +15,7 @@
 #include "eventfd.h"
 #include "wait.h"
 #include "mpscq.h"
+#include "futex.h"
 
 static void ctx_flush_and_put(struct io_ring_ctx *ctx, io_tw_token_t tw)
 {
@@ -294,6 +295,45 @@ void io_req_normal_work_add(struct io_kiocb *req)
 	io_fallback_tw(tctx);
 }
 
+/*
+ * Tell @ctx's task, from any task, that one of its persistent futex waits
+ * was notified.  One atomic, and every caller wakes the waiter itself, so a
+ * notifier preempted between moving a wait to QUEUED and calling this
+ * delays nobody, because the next notifier calls it too.  The ring's task
+ * posts the CQEs in __io_run_local_work().
+ */
+void io_ring_futex_kick(struct io_ring_ctx *ctx)
+{
+	/*
+	 * Full barrier, pairs with the waiter's between arming ->cq_wait_nr
+	 * and looking for work, as in io_cq_wait_arm().
+	 */
+	atomic_fetch_or(1, &ctx->futex_pending);
+
+	guard(rcu)();
+	io_ctx_mark_taskrun(ctx);
+	/*
+	 * Zero and below: nobody is waiting, or this wait cycle's wake up has
+	 * been issued, or claimed by a task_work add that issues it with
+	 * preemption disabled (see io_req_local_work_add()).
+	 */
+	if (atomic_read(&ctx->cq_wait_nr) > 0)
+		wake_up_state(ctx->submitter_task, TASK_INTERRUPTIBLE);
+	/*
+	 * A task waiting outside io_uring_enter(): on an eventfd registered
+	 * with the ring, or in poll/epoll on the ring fd, which reports the
+	 * pending work as readable.  Each is tested without a lock, and takes
+	 * its wait queue's lock only when someone opted into it.  Every kicker
+	 * signals, as every kicker wakes: the first may be preempted before it
+	 * gets here.
+	 */
+	if (data_race(ctx->int_flags) & IO_RING_F_HAS_EVFD)
+		io_eventfd_signal(ctx, false, false);
+	/* whoever sets the flag wakes ->poll_wq afterwards */
+	if (data_race(ctx->int_flags) & IO_RING_F_POLL_ACTIVATED)
+		io_poll_wq_wake(ctx);
+}
+
 void io_req_task_work_add_remote(struct io_kiocb *req, unsigned flags)
 {
 	if (WARN_ON_ONCE(!(req->ctx->flags & IORING_SETUP_DEFER_TASKRUN)))
@@ -387,6 +427,10 @@ static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t tw,
 	tw.cancel = io_should_terminate_tw(ctx);
 	min_events -= ret;
 	ret = __io_run_local_work_loop(ctx, tw, max_events);
+	/* Take the flag first: a notify after this sets it again. */
+	if (atomic_read(&ctx->futex_pending) &&
+	    atomic_xchg(&ctx->futex_pending, 0))
+		ret += io_futex_run_pending(ctx);
 	loops++;
 
 	if (io_run_local_work_continue(ctx, ret, min_events))
diff --git a/io_uring/tw.h b/io_uring/tw.h
index 3ade5ad577fd..dc9125ebdd82 100644
--- a/io_uring/tw.h
+++ b/io_uring/tw.h
@@ -25,6 +25,7 @@ static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
 }
 
 void io_req_task_work_add_remote(struct io_kiocb *req, unsigned flags);
+void io_ring_futex_kick(struct io_ring_ctx *ctx);
 void tctx_task_work(struct callback_head *cb);
 void io_tctx_fallback_work(struct work_struct *work);
 int io_run_local_work(struct io_ring_ctx *ctx, int min_events, int max_events);
@@ -90,7 +91,8 @@ static inline int io_run_task_work(void)
 
 static inline bool io_local_work_pending(struct io_ring_ctx *ctx)
 {
-	return !mpscq_empty(&ctx->work_list);
+	return !mpscq_empty(&ctx->work_list) ||
+	       atomic_read(&ctx->futex_pending);
 }
 
 static inline bool io_task_work_pending(struct io_ring_ctx *ctx)
-- 
2.47.3

