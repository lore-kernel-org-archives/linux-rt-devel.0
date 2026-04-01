Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657A3E8C63
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Apr 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056526; cv=none; b=PZfBk9jO06Xll9N88d//93uAKg/h3Qq6ODWwFCKrB4PwmdpJWXIWUmlv11aURP/bkvxG1TgK65ZjRv/N6FenhKRfDWdy6AVPCRJ0gQphSAN3t8OySw+cAa7PtANU/s1Nw4zjX4BOQ76vd7LP+39UBeaHcS5r/hJRXWjB7o7q0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056526; c=relaxed/simple;
	bh=1PO9+f/JaaLvBzd0obmI11vNj8Jtv2SG/hdWDZNu+XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju8G+atCUfDXOY28ssUtVH8qD8qeBBHJLyEgizxLj4cSbkICH/sQ3CI/Uw5zqV0DGZQOD5H+AeE5JcxTICCdf0mIqE1r2c8p94y6pKQKqV93yC0UE4JQNYGFbDAnDOsHeAGvDk44wrmzrdzRJClxpbrVBnxT759uP9dazO5HZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTfgFF4/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQk+ztFp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTfgFF4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQk+ztFp"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775056520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zYJBFqymGlmMHzyNG+66TI38Sy9QpYJHrKB5IS6AO4=;
	b=mTfgFF4/UrrFhqGHy+C+rIE4r+PgvwrNXDvtpLraF/ZVxZlZ3bRcHhbMH1TvjYzufZn7Qj
	XPCdPBqLquOVNJFlz0rU/4GZeoKsO+4x04qjORmLGjJ3K3+HvFyO6wSKixwdXAwoYoTIj/
	Ez7spqfRc2eMAqm5PpQujyWZ24nc7HvdByxzVkgbycMDyRIJ1ZaMq8EEgqmCCvhCZkSliC
	/DLVOWwZu4HWiS0Aj3rfDCBwbddnu3XYzNVYzaCdCa58IPDK8k/YgAzrXbhH9S695OAKa1
	JqCQ7L6VZ41JupfUXA7eUlWejSNF3Y9mQr0q1alyCHlyacmVUDy0Pmr/XJAsTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775056520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zYJBFqymGlmMHzyNG+66TI38Sy9QpYJHrKB5IS6AO4=;
	b=GQk+ztFp5+yPg59A1ROffmzANqF2Yobv/ZB1WMPq3l8GAFVfT2wLI6NhkD/nbxgg7FB5i3
	YwYWzOVT9cmmsiCQ==
To: linux-hyperv@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep annotation
Date: Wed,  1 Apr 2026 17:15:16 +0200
Message-ID: <20260401151517.1743555-2-bigeasy@linutronix.de>
In-Reply-To: <20260401151517.1743555-1-bigeasy@linutronix.de>
References: <20260401151517.1743555-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

lockdep_hardirq_threaded() is supposed to be used within IRQ core code
and not within drivers. It is not obvious from within the driver, that
this is the only interrupt service routing and that it is not shared
handler.

Replace lockdep_hardirq_threaded() with a lockdep annotation limiting
threaded context on PREEMPT_RT to __vmbus_isr().

Fixes: f8e6343b7a89c ("Drivers: hv: vmbus: Use kthread for vmbus interrupts=
 on PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/hv/vmbus_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1c..e44275370ac2a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1407,8 +1407,11 @@ void vmbus_isr(void)
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		vmbus_irqd_wake();
 	} else {
-		lockdep_hardirq_threaded();
+		static DEFINE_WAIT_OVERRIDE_MAP(vmbus_map, LD_WAIT_CONFIG);
+
+		lock_map_acquire_try(&vmbus_map);
 		__vmbus_isr();
+		lock_map_release(&vmbus_map);
 	}
 }
 EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
--=20
2.53.0

