Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218874;
	b=TrN+wvyqC9neOVv6OdErJNs6YTx+7oqmfA8xkUDSprTJ+UNYKia14LhiHxpsTtWthp2f
	 6RkYD/chdhnyeUl5fztZnYr4DR8QsIS0+XzUVC29wDSmwt1LlfhoEe7FHNhxSBQsalfnx
	 tFpXDcbvbRq/bksaIh5ZeiDFFnZZyOK9xf5O4iI2o2Pyw1Cujji8BJYkF05WQ9K7d2H8g
	 P/opJEo241UQkSo3Gw3NfycRhQOvqCSVi8Fn91xIkvba+vzP3V+HYytqDD8W5LtwjDlOX
	 S9RNDPzfJ5o0SGHE9Z0Dh98krotxJhUoxRDm5AUd3xZ5W8hlD+uXZnYlxlSQVCghHRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References;
	bh=om8tdBMSIgCokEYF5704NEkqNK3MfST8p47zx4fkZms=;
	b=2EPiGme2QNE/VDUeZLfBUSchgIztcLdq7jzcyAtHmX32ZvZEon6Ybw8JlFE8GLzNFnXW
	 nn5+2z6Smg/WZH9fm0mi7Iaxzvou+kadhiHFEYFX6Rz7ry8rE5kL3r0FzMeRB15rq3QnE
	 xX1YTKNmVrkO9NzvHeZu1KOuioQwTncbJ4EStjr4A6FEb9yBnC+jJCUQAmfdxZQ4i5F80
	 fb5RxOS74xkj+EL+bxn+n2uTtr0s7hSo7C4IQ7WQA39aOKD4kyFmpFLP4g4XeFVbO9haA
	 ITBjfAktHAux5HcK+sBSLGyfd/b04YmDmp/e0c6TSj8pRpStuUSI8ubpAUj4s5rI6KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kbo1aG2z;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B1606D803
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F41B1606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kbo1aG2z
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ccca948203aso231813a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 02:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218873; x=1794823673; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=om8tdBMSIgCokEYF5704NEkqNK3MfST8p47zx4fkZms=;
        b=Kbo1aG2zpR3UZOKU2SfZGX7jQd31hTljbJf3n5suYi112M+uIhJq4lVtVtKxoIxIwg
         W9G2YLEZ00q0A2b/prQzHGKrNMazkJ95MfTPJgsKn2EVj4mpTU2niPbE4QQxc8UQUcrM
         xmoTjga+h22XS0C8p88Zf11WO1QMpnVdlQdlWsFBynca3Jm3pgnoo2XD2vkh2ThWWfz2
         bWj9POvpgiEVWnMV4tTKHKvlFIDRMxETKcjvAjnx51eREU9wIcdzNnXirl3POLyvRy12
         RMGO2PaDdmB+kPTNO356dSFhUqcRoNOByz/BuiCYj+K537IL2VNzfJGEepRzbjBUwaPo
         B+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218873; x=1794823673;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=om8tdBMSIgCokEYF5704NEkqNK3MfST8p47zx4fkZms=;
        b=dnpgUmCGeGtIWU+kVEOIPbnXTrF4FWNGZte+ymYI4sEpyIaRNbQnLcKkl1jTRnNI7a
         GdkjpKEYuXW1bf1KWDv/eDjriJHmxibVrkVpvpZZupm0WPF9OddxWJzTI+9HwIzuzERw
         0JlqYfe0gX2uo2buOvDQJ82ERKsdgmHRymltsCpaZHQiybLKCg3ZZAzk5oGfveVLUkev
         nY9pfPrC2R3UrZ6FuU1JmiD4LPlxR5F7zUJrzNa7relG1EqhL3bSIaq7JNPf4INrpEsw
         k7a+7ZEA1qb31PXclOpjswoGHyFvOojPkU/AdiKflCV+sLoWobLlHYDNFMEwaTNI+x8/
         sY7A==
X-Forwarded-Encrypted: i=1; AL+hErFfUARTyCYPotGgODtBkoA1OMsAqPOqs+mDt8OIJ6SmpxPVGw18diXnhGBcMvUkP2U189cEZdUlR/6di47WsQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8R5aJO62xMEV6jLhTpPDebE8tytWG+lZ3CRZwRK/SCZDujnORb
	tw3Mw7+UHWbh6Hj6oozjuKzo9vh+fbfC+JDQVWGstozzAqLn695Lw5Oy
X-Gm-Gg: AYBFou2Bh0YRw8TtJAVIg8pn783wl7P1URlaIhtanJ7eF0q7Kx6LXNaIfhWsboFkfqS
	Havy5R3NbX2G5/x5zekf2S01jG3zWoYorzEltQKwWbt05O/T/VvG5L3z3GLfIKtrAXSsjvVqLoc
	qSV6QA7ClUyT/qoqvgtpjE3n8ieXK+bPuIp0kIE/kp07R1dJGRj+72lLbKLGUWgbfkWhbb3TRMb
	mdQ1fxHKcdFAepQKJ6hTPIVd+mhA+BiYddNEqASrOdm5B7nbCS4BVXlDCMR9A2Dg27Okh5QWUpn
	RUWjJgg6hy/4yPcfl9NcVhDS0e13kstJ4H12sRW+GRZ6S8/Xfj/AyEC0gPyLaXOKVR6d+v1HDft
	Dk8mZ1P3HOz8QismQGL4C+7LRuJERD6GXO5zqx/wMODLcdtZN75tyCqxNN33RPjd+Y4FvsqrU0K
	C9+RcdVWOvFH3GvIiB/OFprBAjK21I9X5NtA946pgQWIARqP4/sPOy0wxB1z4LEQMOdMqGAx08D
	k4e6qSGCyAKeY+/uepdH1FumWkIMvPwxCtWAtsizO4cL3btIio14oWG4wJdqGsQliUs25du3tvW
	hYj3ytw+/dMlfAax/wf/XBY4ySCwTgmhY0G++g==
X-Received: by 2002:a17:90b:3d86:b0:3b0:92be:ea4a with SMTP id 98e67ed59e1d1-3b12d441c8dmr2831006a91.45.1794218873254;
        Mon, 09 Nov 2026 02:07:53 -0800 (PST)
Received: from [58.206.202.11] ([104.28.215.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm6303578a91.6.2026.11.09.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:07:52 -0800 (PST)
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Haoran Wang <haoranwangsec@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org, haoranwangsec@gmail.com
Subject: [PATCH v3] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Mon, 09 Nov 2026 18:07:48 +0800
Message-ID: <20261109180748.33682-1-haoranwangsec@gmail.com>
In-Reply-To: <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
References: <179241614797.5916.13928836073297916808@whr> <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>

ppm_get_cpu_entries() disables preemption with get_cpu(), reads the
current CPU's pool with per_cpu_ptr(), then acquires the pool's
spin_lock_bh() while preemption is still disabled, and finally put_cpu().

On PREEMPT_RT kernels spin_lock_bh() becomes a sleeping lock
(rt_spin_lock), so the task may sleep with preempt_count elevated:
scheduling while atomic, reported as a BUG by CONFIG_DEBUG_ATOMIC_SLEEP
and a deadlock once the lock is contended.  Any iSCSI offload I/O
through a Chelsio NIC that reaches ppm_get_cpu_entries() triggers it.

Read the current CPU with raw_cpu_ptr() without raising preempt_count,
and derive the global index base from pool->base (initialised when the
pools are allocated) instead of cpu * pool_index_max, so the base
always matches the pool that was locked.  The owning CPU remains in the
debug output, now derived from pool->base.

Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>

---
(Resent with the complete Cc list; the earlier copy reached only you.)

Hi Sebastian,

thanks for the review.  v3 below addresses your comments:

- The commit message now describes what the patch does; the review
  rationale moved into the changelog below the --- separator.
- PREEMPT_RT spelled out.
- pr_debug() keeps printing the owning CPU of the pool, derived as
  pool->base / ppm->pool_index_max; the global index stays
  i + pool->base.
- Tested on: x86_64, compile-tested with CONFIG_PREEMPT_RT=y and
  CONFIG_DEBUG_ATOMIC_SLEEP=y; no Chelsio hardware at hand, so the
  change is not exercised on real offload I/O.

Changes since v2:
- Keep the owning CPU in the pr_debug() output, derived from
  pool->base / ppm->pool_index_max (suggested by Sebastian).
- Reword the commit message to describe what the patch does and move
  the review discussion into this changelog; spell PREEMPT_RT.

Changes since v1:
- Drop the cpu variable: read the global-index base from pool->base
  (initialised at pool allocation) instead of a cpu captured before
  the lock, so the base is always consistent with the pool that was
  locked.  The per-CPU pools are shards of the global ppod index
  space and not tied to the running CPU (ppm_unmark_entries() derives
  the owning pool from the index itself), so locking another CPU's
  pool after a migration is a cache-locality matter, not a
  correctness one.

 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -119,16 +119,13 @@
 			       unsigned long caller_data)
 {
 	struct cxgbi_ppm_pool *pool;
-	unsigned int cpu;
 	int i;
 
 	if (!ppm->pool)
 		return -EINVAL;
 
-	cpu = get_cpu();
-	pool = per_cpu_ptr(ppm->pool, cpu);
+	pool = raw_cpu_ptr(ppm->pool);
 	spin_lock_bh(&pool->lock);
-	put_cpu();
 
 	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
 				    pool->next, count, 0);
@@ -145,10 +142,10 @@
 	spin_unlock_bh(&pool->lock);
 
 	pr_debug("%s: cpu %u, idx %d + %d (%d), next %u.\n",
-		 __func__, cpu, i, count, i + cpu * ppm->pool_index_max,
-		pool->next);
+		 __func__, pool->base / ppm->pool_index_max, i, count,
+		i + pool->base, pool->next);
 
-	i += cpu * ppm->pool_index_max;
+	i += pool->base;
 	ppm_mark_entries(ppm, i, count, caller_data);
 
 	return i;
@@ -375,6 +372,7 @@
 
 		memset(ppool, 0, alloc_sz);
 		spin_lock_init(&ppool->lock);
+		ppool->base = count;
 		count += ppmax;
 	}
 
