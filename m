Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F12E11B8
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316843; cv=none; b=f13pzEhn2vmgIky09G4oFmobjtmoAD9F6pjrdGS0etk/jW1p1oLKyeje2No9Q8dUZ9nvD6UOUVUetRBil75mxdMx/EONZ+7mdwK3cRxPFtj6ajQ9IVvgtSHy4m1kRMlZ3XJYeHYY3EE1tlXyFsw4bYLDEX9thvAscVRbDIOgFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316843; c=relaxed/simple;
	bh=bVPIfKS/5fXxENMewaVZzRevyuDMEikMCDmxAN/yMPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gq0T4bU2f68kx89KszN2W0ClI0NhPnLNKrBGzPREmlFULjK3Vers93k4ubmeJtgNoo31kkbfJoPzhq/x39mviC3tlfSuNrTdAN74njeUhdQxEbEFA4YM890sHyacYl3FP1pZQOuNioxgwPDYwuqr/J7p+iX6h5gJLxiNli8z6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAUd6wi9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAUd6wi9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0ac29fca1so49483395ad.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768316841; x=1768921641; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQnWPRxNH9q72zgZ6FoCl23Dsj1j6a70O0K1DDg0+mo=;
        b=PAUd6wi9UfrYuSIWUdObZkgpdRTZGw+us2GP4FRMWK5SJkdQsJWjU6NZVKP/XomX7n
         tCK5ZuSSUVBE8OlHZAbv35qe9RKPl8NEtxWjiRhJj0oQyH1tgApt5KagDnxq4sYVWSur
         YPjW+AE3PX1OUF1jyEfMr/cE4IclZpDL6H4xbCI9SHqD+RKR43B748BMEdMj1IaaQMFj
         wpMTHYmmwSjVYXbsUkVguR2cqiZi79UETpjtaCmvgnaG81oc+nDbtk0q3Mu/y4sp6dNv
         3Ivd5wjRiJoBEZoRyX0M7QZ41dJ0590q2FGRnbFokN2YdPtY14w8dYDjoncwj6P3JoiC
         N0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316841; x=1768921641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQnWPRxNH9q72zgZ6FoCl23Dsj1j6a70O0K1DDg0+mo=;
        b=t5QwFK8bWP/FvzHarzNxHlQEFo5AjKA2/OKdRJmW4UYJbrJajVJhqhPE6u3D2BtRUf
         M+4oUonvG5k7EScDTD52+1sAyeOYts8KSAs9cw9h91TLyZ9+YsS62J7U0P8xO6PNbQb1
         oX58k4JXgFhhLUtyXOV1UP6JRJvko6X6aVFrRsGC71yU42ZZxL3I5AqmyJUE2Y16wUap
         /tSKbmUOYYishjNWkbr8WYYnQHgJWtCBa2bzFhwFi2LX4wONNB4p3oESVwxHCvLRkI71
         Ltxq5LrAHvEjlnE8VIOabf9S8W4TVbjs3ZmIqla1jlCFP2ku0MX2VvxdupPtoungSKaM
         Gqrg==
X-Forwarded-Encrypted: i=1; AJvYcCVI25+hwpuU7roXMOXvKRKi4N14X2VucZDto3cNwpFSWFcLAVd/QFNWl1kjzdnuiH+LHEc44VCEojSbby9KfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlsojcRFkqVbZLI6+XpeZXtfh4vUCWy1smklwSaTVMAEj8izJY
	SmgIhtSYO8iyRQytjXFVqAVfRp2eom/rW1uqS0G3PkjhQK6vnchbhOSL
X-Gm-Gg: AY/fxX57LDuRQYLr8rM2sI3ttGGivpZpoxntabU1F6pztNokWN6LnqHpRQz5LNFGRVd
	Ck/LzE7CHKRTyUXtUJ3ygBH3snO9nsG40pGTpHy+x0KTRe0jVQZSpYPW8hmfp42SevljLH+3b21
	iAdckQDwiO+1MUK35jsq9LkXeSQLmWoz99kvm12EAz1DOShCWzMif1rS5gVFcsfkD8p+7hkKIj2
	HgDY2XzZZMmGCsmiYn3uv9oXrkAO8gsrA5dC6C4wYiS/h0Vo0i6pcNNycrk2N7BV2AX7dz1XcV+
	+SIK/xr9Z3pgRW7ruGGMYe+jTD29neQ57VJaR2FU3HaYWyB430piSmOt5im9uUR0KCeqhXXK1Yz
	QZXd7b/lMo2p2SSrs5u0nwejqHqEhyd7eG88IKfEWc5a55iC+JH4sUcpJe4cPfIzxJ1/Wz8Xsv4
	iI2gmfEMSgUQCbwWD/QAz58PW8nkvU
X-Google-Smtp-Source: AGHT+IHKPSJ8kXxnj8Kql9+bODbOjeYJ8UeB1XiJVxthrhBSw85O6NRJi1luNAgVbTgInY27JkJcvw==
X-Received: by 2002:a17:90b:3c09:b0:34c:2db6:57f1 with SMTP id 98e67ed59e1d1-34f68c28425mr17392421a91.30.1768316840509;
        Tue, 13 Jan 2026 07:07:20 -0800 (PST)
Received: from LilGuy ([2409:40c2:1000:ae08:9f24:c96f:d20:3f76])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34f5fb7419csm20596125a91.13.2026.01.13.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:07:20 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-mm@kvack.org (open list:SLAB ALLOCATOR),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Subject: [PATCH v2] slab: fix kmalloc_nolock() context check for PREEMPT_RT
Date: Tue, 13 Jan 2026 20:36:39 +0530
Message-ID: <20260113150639.48407-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT kernels, local_lock becomes a sleeping lock. The current
check in kmalloc_nolock() only verifies we're not in NMI or hard IRQ
context, but misses the case where preemption is disabled.

When a BPF program runs from a tracepoint with preemption disabled
(preempt_count > 0), kmalloc_nolock() proceeds to call
local_lock_irqsave() which attempts to acquire a sleeping lock,
triggering:

  BUG: sleeping function called from invalid context
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128
  preempt_count: 2, expected: 0

Fix this by checking !preemptible() on PREEMPT_RT, which directly
expresses the constraint that we cannot take a sleeping lock when
preemption is disabled. This encompasses the previous checks for NMI
and hard IRQ contexts while also catching cases where preemption is
disabled.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
Changes in v2:
- Simplified condition from (in_nmi() || in_hardirq() || preempt_count())
  to !preemptible() as suggested by Luis Claudio R. Goncalves and agreed
  by Vlastimil Babka
- Updated comment to reflect the more descriptive check

Tested by building with syz config and running the syzbot
reproducer - kernel no longer crashes.

 mm/slub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2acce22590f8..642f4744d5c6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5689,8 +5689,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;

-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
-		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
+		/*
+		 * kmalloc_nolock() in PREEMPT_RT is not supported from
+		 * non-preemptible context because local_lock becomes a
+		 * sleeping lock on RT.
+		 */
 		return NULL;
 retry:
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))

base-commit: 559e608c46553c107dbba19dae0854af7b219400
--
2.52.0

