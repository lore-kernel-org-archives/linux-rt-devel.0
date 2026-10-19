Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055564F30CC
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416153; cv=none; b=ORk/JVhdyD6SWkxCnGLoDx3MSS5gjfYPVxsfyDScbVkkUjMiLM+t4AbBZ2oqfZKkwZZojlYqVTHJTsW4bPDyMWV80WUTfgJa4T+gOHCBXkkQrxmLNFwtwjPjfpXGdRSa+C9o65g/tqLc4NUJ9viIqWxQBSxm/4DUDU2hEOyZm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416153; c=relaxed/simple;
	bh=5Dw4ApFmugf86j9b3TFizFB0Yq2QsSowt3OciC3O4bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=prDSNbnn0gvMF4Qd+Z6PxZ0hLArcUGP9dgm2N1RZnTy+EpWsUyCOwvKHba6bvsXL8aCr+35y/pvPWNQ3cPYm9/zXFunQww0IiS1TJtPOMydI8hcBiP4VShnBvRV2q5YHftA42i7Hz0AYN550BIgMtAoGT2ZwnBWFMWRk9F3zEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlfCTobe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlfCTobe"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-878b44611ffso1159568b3a.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416151; x=1793020951; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nLKCvUycnmLTFqHSAdrCkAg3dpCGjBYjq7zy8w3DV4=;
        b=dlfCTobeyuJfCH3GrvWo8Nl6br3bNRupwTthmiCbMlrDo4QYra4Vfbr+l5mpRY6J+X
         DCZCiDtqDFe/XGv2DKXHVIUjSRhWwymhEG/dsroMisTLhfnbUA5mQS6Wz9NsZx/UOWDt
         Z0gUS+kuebYsXHeQb8LocjV8r5amZ2tLPev/XUVWh1wUh68t56wR3T1GxmBZAr3vCP9d
         o0GTBuz5cYXjNiNFIQut7my9hIqMzXuEZT5PYkNBT94mvJMx8Hq0BQaYopbXhK8oJ9NB
         TIJM410fNoLBzFr902pnOL8JuAj5xOXhfIuLATT1m3puPYzeQuto7gCWqBS7Jy47t2TU
         4Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416151; x=1793020951;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0nLKCvUycnmLTFqHSAdrCkAg3dpCGjBYjq7zy8w3DV4=;
        b=xRMegaMMH6HsM8aPt4V9PPSw0L+ZR+pS2Bm1FKTtQMO5gv20LQKU22iJqqrXpMNCkY
         Pc35lQRsylgqU0BtjRjBGyJiW81Bxbvn5LAxyUHasdqw3WAVxW7xDUYTu6c8SkN9qSpt
         6ecwIQ6qtJeAU5TuBKrHVuhXdtkf29YDJrc7e3osqbcNFKHBuusXjDH8GOZQUNQhZFdu
         EXYkRmCpGfWErVpddMkLn9eQw13E+xC4EbpsWd16DySK0nF8jxRcitMmT4rHtNCzelLq
         FNnr8iq7fDrZxXEoWbxkw48QWbXbDTg/mAVibWuIujxOGzpR5SKoEDb9WVOsoxir9pQl
         4aYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/eg1PbF8aOhCUam5qh2+PxA4A+Ug08Sdf4REYAHf4R6sPvdu1dcpTvOJHpC4iPj0ITMkbd0jbzFGqn7xZdQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLSZqK0+JDLHG7nsNT2/UAYys0kFo1PJjyvTq8a4Py0Um7VTna7
	X322lDb3lvgNbrnrhykP0eIuv5acGLxfvO5AG+q2jR0hS6cm3572lv3D
X-Gm-Gg: AYBFou2xJV3lpQBp5hv7MGc6Vyht4dDr8Jj904bimytxKIPD2/ln3y86IPjzrnf+lc2
	jeYPAW0PwzSWIyj/DUm6s3a7PubX33aen/YaXmciWIIvYI8Etw1f4QQ7B9C2/2J7Zi9z2KGMjjS
	w3UfHpFeFWajiGLXTve5MCzKPPTE9qeggch+y8GJxfjMkFq67t5Ip3+a1tqszYS+JMnNC5qFASd
	F63JHmkoYsOv3IgrauZbQjFUYKij/ik0ThwxiNf1fDrDx7r89OyDzbX8WB3Pz2+fZzDxzaVZdbd
	nudNufGgTSoCET0KH0mmA53FGy1350ApicPxk0yQNT6/zHSLMxzIDp9UnyySDLJgSC6RizUhINl
	Fe7c29O1cWJzpllRQrswAbaoKhaA/7Y9TfnSdACfYKzmIACSG86z+I54he9/rG7uL2c/G8Z0sgo
	aLZW9hbZ0GrcrreKz5DI1b6tCMECkbppk7S29WM3f91Imq/vc3A9qC9LFiNfc3CHjtt7AHh3qOo
	biC5g==
X-Received: by 2002:a05:6a00:408d:b0:882:905d:aa05 with SMTP id d2e1a72fcca58-8a04c14e9fbmr6226914b3a.50.1792416151035;
        Mon, 19 Oct 2026 06:22:31 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fcd67cf30sm3329023b3a.17.2026.10.19.06.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:30 -0700 (PDT)
From: Haoran Wang <haoranwangsec@gmail.com>
To: Varun Prakash <varun@chelsio.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev, linux-scsi@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, haoranwangsec@gmail.com
Subject: [PATCH] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Mon, 19 Oct 2026 21:22:27 +0800
Message-ID: <179241614797.5916.13928836073297916808@whr>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

ppm_get_cpu_entries() disables preemption with get_cpu(), reads the
current CPU's pool with per_cpu_ptr(), then acquires spin_lock_bh()
while preemption is still disabled, and finally put_cpu().

    cpu = get_cpu();
    pool = per_cpu_ptr(ppm->pool, cpu);
    spin_lock_bh(&pool->lock);
    put_cpu();

On PREEMPT_RT kernels spin_lock_bh() becomes a sleeping lock
(rt_spin_lock).  get_cpu() raises preempt_count, so acquiring the
lock right after sleeps with preempt_count still positive.  Sleeping
in that state is the scheduling-while-atomic case, which under
CONFIG_DEBUG_ATOMIC_SLEEP reports a BUG and, if the lock is contended,
deadlocks on the spot.  The trigger path is any iSCSI offload I/O
through a Chelsio NIC that reaches ppm_get_cpu_entries().

The preemption disable exists only to stabilize the per-CPU accessor,
the pool is serialized by pool->lock, not by preemption.  Replace
get_cpu() + per_cpu_ptr() + put_cpu() with raw_smp_processor_id() +
raw_cpu_ptr(), which read the current CPU without disabling preemption.

On non-RT kernels spin_lock_bh() does not sleep, so the BUG does not
fire there; the defect is PREEMPT_RT-specific.

With the fix, preempt_count is 0 at spin_lock_bh(), so rt_spin_lock()'s
might_sleep() no longer triggers.

Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
---
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 2e3973a32..5f68c5d57 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -125,10 +125,9 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
 	if (!ppm->pool)
 		return -EINVAL;
 
-	cpu = get_cpu();
-	pool = per_cpu_ptr(ppm->pool, cpu);
+	cpu = raw_smp_processor_id();
+	pool = raw_cpu_ptr(ppm->pool);
 	spin_lock_bh(&pool->lock);
-	put_cpu();
 
 	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
 				    pool->next, count, 0);
