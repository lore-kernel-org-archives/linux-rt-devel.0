Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A442652B7
	for <linux-rt-devel@lists.linux.dev>; Fri,  8 Aug 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643110; cv=none; b=dk62LJ8S+yHXFqRDtGxKd7QR5GODcjvAF7k4P4+Lq2zXYVMvv7rfgIfdSJgIyCeuURNiuWSAUKVCWqenoy83Xw8pSDlrW/BxHD0Duko0LJyGpC7h1MJ/UuzkRgqBDOHI3ftekajhpmPql3IHiGK0qfdZmn025n0EQOthy/U/dks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643110; c=relaxed/simple;
	bh=b1RW4sTK5p1w+rHdcQTifriYB02GALUE7xZBNlDNIsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cKRF/FYv/2g3zt4EnuEvCZPfWR1o/kfwRG79YCgMCkME5fiWHaFEJMYnzk4OaFTNj+dQa0iIjwpnzhDD16gbBZj+yqPTAl+Z2koZuEHzd+xK8JELyyNyd8Pn3Pf+xYNI1pKexmXe0F1Se1PXFjkWaCxZWMTftM7eOh/m97jHCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=shXVqWDx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4H7q8Mr/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="shXVqWDx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4H7q8Mr/"
Date: Fri, 8 Aug 2025 10:51:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754643100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wM/akm2mz5O9LuaSzkJB0AGXvTlzjCqIWaJkWSq5dic=;
	b=shXVqWDxNXCeBeFlQr2d5WH91P0JmWpBedRf3xcaazgw2VYECuj6qcLZNBlOfwCbFst8Rk
	2xaTP7obDYdCC2HwsDZq7jm5z+tGKfYyb8ZCsitTlFXJc/ydg7wBbS8vbRJXIb+XLDo9TY
	nAV8Zl7sF1Jb4WMf7r7DFUpM/S5KHa+Py7qbYc39ETBYgWCX4ZGoELiZV+qlluwBSEpK5A
	b41SFNThlsK/Nug8wPhQsAeV8PfvggfbmtPzME+KrVPYZ/c+54wJtGgbGlX6eoBwyc9XK8
	eYKZp17XqQr46ix1/eORPgRQzn7US+xQGD/uOJnnseeC0lBcm3yBPmwPIq01Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754643100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wM/akm2mz5O9LuaSzkJB0AGXvTlzjCqIWaJkWSq5dic=;
	b=4H7q8Mr/JhS5RuKLNuKkelp+QLuNxsw+PNWo7nOkPGhY2+WlI8MYgAC7ilIouwNoIDpFyz
	BnvEqik6lT8tqvBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.16-rt3
Message-ID: <20250808085138.jHKxYfUJ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.16-rt3 patch set. 

Changes since v6.16-rt2:

  - A patch to the i915 to recognize atomic context in a timeout
    function.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.16-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.16/incr/patch-6.16-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.16-rt3

The RT patch against v6.16 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.16/older/patch-6.16-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.16/older/patches-6.16-rt3.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index b721bbd233567..f5a6143ea8a24 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -1609,7 +1609,7 @@ u64 intel_engine_get_last_batch_head(const struct intel_engine_cs *engine)
 
 static unsigned long stop_timeout(const struct intel_engine_cs *engine)
 {
-	if (in_atomic() || irqs_disabled()) /* inside atomic preempt-reset? */
+	if (in_atomic() || irqs_disabled() || rcu_preempt_depth()) /* inside atomic preempt-reset? */
 		return 0;
 
 	/*
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
