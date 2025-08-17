Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD820D4E9
	for <linux-rt-devel@lists.linux.dev>; Sun, 17 Aug 2025 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755430432; cv=none; b=Pojpv9U5H+8gfR0Ix8/3VIa3K5H/5ipPpad3RrLhcfNM9Ed5UE+LvhdcRQnmyd4m5ezEWsRuPEZXSTCZOEL6I4uQVhkCbjQpBs9cVmn7GtNcmrlP4qETg7+OJy+SoM9Eac6cufVgfMJaWegkI1vhZOMZ+k4TwZlN/gDbo06pf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755430432; c=relaxed/simple;
	bh=VSL6PEg8MxL2uScEXM1b+TMiDEeE4SxgUT/grljA0sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ib5LPSKknGweGG6N+SLKeEQVQJiKfiSEJ9Yoi+HGkdpX3nJLlfUoTo4Zt7aO9RJs9WzzGwI8/XFGgg9FhA2MKl30l5M/LLOEfhSyX3w7sal0LZizvOFTN2LGdkKuh1MW9uR6HmOlsGLaee14uRZTM+M89zzOT6KV8nUgE7y+tCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b471751142aso566067a12.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 17 Aug 2025 04:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755430429; x=1756035229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ak6zMtFbySLeOJ64BswfpOwYEwQ7oovCITgLDPUoaxE=;
        b=uoHp/XZmk+DzM59INxDUH9LBYzBUV3FcMR7szaMIvOXQcm4d9EXfVASUJQWlS7Vp9f
         TB/BJ8nI3uWJYLNWlgvMdgACApY4CYMKo/ViahYZ4LDdDRQu8dcqr5kTIwhGvT1rVZxn
         JFnC/thEZp3Jfd/v1/oBSQooxIRbXHX8xDjXYcsr8umMfV1b1p4WoAARvXWDl/wQmBCU
         A0sVUEuYrm30uugDfiIiBSNyqaN/lpDZwjfBa6fSyMk9syD9seoT+d1KVkvFs0wq/jeY
         fGHEl/7aa1/7MoMBZgcEzsZIlu/FNRqRBoSHQWTJvlTYI4ibBCDvlYdOUNG8/DE3iB+A
         dtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNgo8utJoh2xTTgeNGO9IryWKqZ/aKr46bNj3686kYsJgcR/Nut41lZmweSTP47puJ6gddfr5jNkWoNPDQxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu6f2daGZgqo25fOQre6G/4RcmvsBtE87ZlkUFA8leLbIfr26D
	4kbbg8h2NnvmZz+RhlLCs4skG3r0CDDX5uUVfw9OxPR/rNvdNpgaLWRx
X-Gm-Gg: ASbGncufE+tBziXSXbmJyLnA6vqOoYMl3g5bktJgY0TQ3dn+oKw2/eWADnbYEf8mHiP
	X4Bhy0Pxr4zQW9VuM/0e8vIrwQyfdcghX9DbmQk0j9bT0BdrES6+xoGPfASrmIUF6Z/JmNn+Fn+
	+kPwJB8wA3KdUfxYAaC5fSkCYhtwCYq7o62jrHVAgnyjYAlJBD8P916Grt4G6/2am7mQ0ZSxo0x
	0qnwP9dVi+uiHx0l2wd+UsfsTNrvuNPKuyZb0V30gz+xAKh4dhymxylkCCPVnKX2196TSBxRbIm
	gZ93IeJ5ATouaA8EnQpy6U1hWXfaHZNWLemBXEw9ZVTg383MuzB0KG9F0KYlxd2+wl1jlVpSaK2
	Gc/PtFuHQJj2V
X-Google-Smtp-Source: AGHT+IGZpxRPHFgkz6nMsx/vmZuGcU8C3T8gkrZOO2a+zfUrlfHCRWnkIiVJMn7vnKCuVpCCuNpSTw==
X-Received: by 2002:a17:902:e541:b0:240:9dcd:94c0 with SMTP id d9443c01a7336-2446d6f1c95mr53539515ad.2.1755430429491;
        Sun, 17 Aug 2025 04:33:49 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0f329sm54102285ad.70.2025.08.17.04.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 04:33:49 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>
Cc: linux-raid@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH] md/raid5-ppl: Fix invalid context sleep in ppl_io_unit_finished() on PREEMPT_RT
Date: Sun, 17 Aug 2025 11:31:16 +0000
Message-ID: <20250817113114.1335810-3-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ppl_io_unit_finished() uses a local_irq_save()/spin_lock()
sequence. On a PREEMPT_RT enabled kernel, spin_lock() can sleep. Calling it
with interrupts disabled creates an atomic context where sleeping is
forbidden.

Ensuring that the interrupt state is managed atomically with the lock
itself. The change is applied to both the 'log->io_list_lock' and
'ppl_conf->no_mem_stripes_lock' critical sections within the function.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 drivers/md/raid5-ppl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 56b234683ee6..650bd59ead72 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -553,15 +553,13 @@ static void ppl_io_unit_finished(struct ppl_io_unit *io)
 
 	pr_debug("%s: seq: %llu\n", __func__, io->seq);
 
-	local_irq_save(flags);
-
-	spin_lock(&log->io_list_lock);
+	spin_lock_irqsave(&log->io_list_lock, flags);
 	list_del(&io->log_sibling);
-	spin_unlock(&log->io_list_lock);
+	spin_unlock_irqrestore(&log->io_list_lock, flags);
 
 	mempool_free(io, &ppl_conf->io_pool);
 
-	spin_lock(&ppl_conf->no_mem_stripes_lock);
+	spin_lock_irqsave(&ppl_conf->no_mem_stripes_lock, flags);
 	if (!list_empty(&ppl_conf->no_mem_stripes)) {
 		struct stripe_head *sh;
 
@@ -571,9 +569,7 @@ static void ppl_io_unit_finished(struct ppl_io_unit *io)
 		set_bit(STRIPE_HANDLE, &sh->state);
 		raid5_release_stripe(sh);
 	}
-	spin_unlock(&ppl_conf->no_mem_stripes_lock);
-
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ppl_conf->no_mem_stripes_lock, flags);
 
 	wake_up(&conf->wait_for_quiescent);
 }
-- 
2.50.0

